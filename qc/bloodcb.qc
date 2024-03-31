/* ------------------------------------------------------------- */
/* |                    ** The BloodCube **                    | */
/* |										   | */
/* |  A new powerup.  The Cube is alive, and when you touch it | */
/* |  you become its master.  The cube will start circling     | */
/* |  above your head, and will atack any monsters on sight.   | */
/* |  If you don't feed the Cube plenty of gibs, it will get   | */
/* |  hungry and start to feed off of your blood.		   | */
/* ------------------------------------------------------------- */

// .state
float BLOOD_WAIT = -1;
float BLOOD_ASLEEP = 0;
float BLOOD_AWAKE = 1;

// .height
float CUBE_RANGE = 400;			//How far the cube can 'see' enemies

// .dmg
float CUBE_DAMAGE = 20;			//The amount of damage of one zap

float CUBE_GOAWAYTIME_DM = 30;		//Initial time limit for cube life
float CUBE_GOAWAYTIME = 40;		//Initial time limit for cube life

float CUBE_RESPAWNTIME = 300;		//Time until cube respawns

// .delay
float CUBE_ATTACKDELAY = 0.1;		//How quickly cube attacks again
float CUBE_ATTACKDELAY_DM = 0.25;

// * prototypes *
void() StartCube;
void() Cube_die;
void() Cube_control;



float bloodcube_is_awake(entity cube) {
	return cube.state == BLOOD_AWAKE;
}



float count_shooters() {
	float shooter_count = 0;
	for (entity it = find(world, classname, "bloodcube_shooter"); it; it = find(it, classname, "bloodcube_shooter")) {
		shooter_count += 1;
	}
	dprint("\n\nFound "); dprint(ftos(shooter_count)); dprint(" shooters\n\n");
	return shooter_count;
}

/* ----------------------------------------------------- */
/*   CubeAttack - A new attack style for the BloodCube.  */
/* ----------------------------------------------------- */
void Particle_Beam(vector start, vector end, float color1, float color2, float pdensity) {
	vector spray, next;
	float dist, loop, clr;

	clr = color1;
	spray = start - end;
	dist = vlen(spray);
	loop = dist / 24;
	spray = normalize(spray);
	next = spray * 24;

	while (loop > 0) {
		particle (end, spray, clr, pdensity);
		end = end + next;
		loop--;
		clr = clr == color1 ? color2 : color1;
	}
}

void CubeAttack(vector start, vector end, entity attacker, entity targ) {
	Particle_Beam(start, end, 73, 225, 40);

	float extra_damage_threshold = deathmatch ? self.dmg : self.dmg + 10;

	if (targ.health < extra_damage_threshold) {
		T_Damage(targ, attacker, attacker, self.dmg * 5);
	}
	else {
		T_Damage(targ, attacker, attacker, self.dmg);
	}
		
	if (self.t_width < time) {
		sound (self, CHAN_AUTO, "cube/bc_attck.wav", 1, ATTN_NORM);
		self.t_width = time + 0.4;
	}
}


/* ------------------------------------------------ */
/* | bloodcube_shoot_next_target - used to traverse linked list to  | */
/* | shoot lightning at all visible enemies.      | */
/* ------------------------------------------------ */
void bloodcube_shoot_next_target() {
	dprint("bloodcube_shoot_next_target()\n");

	if (self.aiment) {
		if (self.aiment.health > 0) {
			if (visible(self.aiment)) {
				traceline(self.owner.origin, self.aiment.origin, TRUE, self.owner);
				CubeAttack(self.owner.origin, (self.aiment.origin + '0 0 16'), self.owner, self.aiment);
			}
		}
		self.aiment = self.aiment.aiment;
		self.nextthink = time + self.delay;
	}
	else {
		remove(self);
	}
}

/* -------------------------------------------- */
/* | FeedMe - Looks through linked list and   | */
/* |  removes all dead entities.  If this is  | */
/* |  a multiplayer game, give owner a frag.  | */
/* -------------------------------------------- */
void FeedMe() {
	dprint("ENTER >>> FeedMe()\n");

	entity shooter, temp;
	float loop_counter = 0;

	temp = self;
	while (self.aiment && loop_counter < 40) {
		if(self.aiment.health <= 0) {
			self.aiment = self.aiment.aiment;

			// if (deathmatch || coop) {
			// 	temp.owner.frags = temp.owner.frags + 1;
			// }
		}
		self = self.aiment;
		loop_counter += 1;
		dprint("LOOP COUNTER: "); dprint(ftos(loop_counter)); dprint("\n");
	}

	self = temp;
	if (!self.aiment) {
		self.avelocity = '0 100 0';
		return;
	}

	dprint("\n\n***\n");
	dprint("*** Creating new shooter\n");
	dprint("***\n");
	shooter = spawn();
	shooter.classname = "bloodcube_shooter";
	shooter.aiment = self.aiment;
	shooter.origin = self.origin;
	shooter.owner = self;
	shooter.think = bloodcube_shoot_next_target;
	shooter.delay = 0.01;
	shooter.nextthink = time + self.delay;
	shooter.dmg = self.dmg;

	count_shooters();

	dprint("EXIT <<< FeedMe()\n");
}

void(vector cdest) FeedonPlayer =
{
local vector	spray,vec;
local float		t;

	spray = cdest - self.owner.origin;
	particle (self.owner.origin + '0 0 24', spray, 225, 70);
	sound (self, CHAN_AUTO, "cube/bc_attck.wav", 1, ATTN_NORM);
	T_Damage (self.owner, self, self, 1);
	self.invisible_time = time + 2;    // suck blood again in 2 secs
};

/* ----------------------------------------------------- */
/* | LookforBlood - Looks for all entities within the  | */
/* | range given by CUBE_RANGE, and creates a linked   | */
/* | list of all possible targets.	self.aiment is the | */
/* | link field.							 | */
/* ----------------------------------------------------- */
void LookforBlood() {
	dprint("\n\nENTER >>> LookforBlood()\n");

	entity linker;

	linker = self;

	float target_counter = 0;
	float loop_counter = 0;

	entity head = findradius(self.origin, CUBE_RANGE);
	while (head && loop_counter < 20) {
		if (head.flags & FL_MONSTER || head.flags & FL_CLIENT) {
			if (head.health > 0 && head != self.owner) {
				if (visible(head)) {
					linker.aiment = head;
					linker = head;
					target_counter += 1;
				}
			}
		}
		head = head.chain;
		loop_counter += 1;
	}

	dprint("Found "); dprint(ftos(target_counter)); dprint(" enemies in range\n");

	// Set the first enemy as the enemy of the blood cube
	if (self.aiment) {
		self.enemy = self.aiment;
		self.avelocity = '0 500 0';
	}
	dprint("\nEXIT <<< LookforBlood()\n");
}

/* --------------------------------------------------------- */
/* | blood_CalcMove - Used to calculate the cubes velocity | */
/* |  to get it to the next position.			     | */
/* --------------------------------------------------------- */
void blood_CalcMove(vector tdest, float tspeed, void() func) {
	vector vdestdelta;
	float len, traveltime;

	self.finaldest = tdest;
	self.think = func;

	if (tdest == self.origin)
	{
		self.velocity = '0 0 0';
		self.nextthink = time + 0.05;
		return;
	}
	vdestdelta = tdest - self.origin;
	len = vlen (vdestdelta);
	traveltime = len / tspeed;
	if (traveltime < 0.01)
	{
		self.velocity = '0 0 0';
		self.nextthink = time + 0.01;
		return;
	}
	self.nextthink = time + traveltime;
	self.velocity = vdestdelta * (1/traveltime);
};


/* ---------------------------------------------------- */
/* | Cube_control - This is called by the Cube every  | */
/* | 0.5 seconds.  It assigns the cube a destination  | */
/* | and also scans the area for enemies.  Also keeps | */
/* | track of all the timers.	 It's a bit too big.	| */
/* ---------------------------------------------------- */
void Cube_control() {
	vector cdest;
	float clen, cuspeed;

	// Check if player dead? Or is this intermission?
	if (self.owner.view_ofs == '0 0 0') {
		self.velocity = '0 0 0';
		self.think = Cube_control;
		self.nextthink = time + 0.5;
		return;
	}

	// Pick a position around the player
	if (self.cnt == 0)      cdest = self.owner.origin + '0 36 52';
	else if (self.cnt == 1) cdest = self.owner.origin + '25 25 52';
	else if (self.cnt == 2) cdest = self.owner.origin + '36 0 52';
	else if (self.cnt == 3) cdest = self.owner.origin + '25 -25 52';
	else if (self.cnt == 4) cdest = self.owner.origin + '0 -36 52';
	else if (self.cnt == 5) cdest = self.owner.origin + '-25 -25 52';
	else if (self.cnt == 6) cdest = self.owner.origin + '-36 0 52';
	else                    cdest = self.owner.origin + '-25 25 52';

	traceline(self.origin + '0 0 16', cdest, TRUE, self);
	//dprint(ftos(trace_fraction));dprint(" = trace_fraction\n");
	if (trace_fraction < 1)
		cdest = self.owner.origin + '0 0 48';

	traceline(self.origin, cdest + '0 0 32', TRUE, self);
	if (trace_fraction < 1)
		cdest = cdest - '0 0 16';

	clen = vlen(cdest - self.origin);
	if (clen > 500) {
		// Too far from player so teleport to them
		setorigin (self, (self.owner.origin + '0 0 24'));
		self.velocity = '0 0 0';
		self.think = Cube_control;
		self.nextthink = time + 0.1;
		return;
	}

	if (clen < 50)
		cuspeed = clen * 2;
	else
		cuspeed = clen * 4;

	self.cnt = self.cnt + 1;
	if (self.cnt >= 8)
		self.cnt = 0;

	LookforBlood();	   //dhm: this sets self.aiment if a target is found

	if (self.aiment) {
		if(self.attack_finished < time) {
			FeedMe();
			self.attack_finished = time + CUBE_ATTACKDELAY;
		}
	}

	if (self.invincible_finished < time) {
		sound(self, CHAN_ITEM, "cube/bc_hngry.wav", 1, ATTN_NORM);
		self.invincible_finished = time + 30;
	}
	
	if (self.invisible_time < time) {
		FeedonPlayer(cdest);
	}

	if (self.radsuit_finished < (time+5)) {
		if(self.rad_time < time) {
			sound(other, CHAN_AUTO, "cube/bc_activ.wav", 1, ATTN_NORM);
			stuffcmd(self.owner, "bf\n");
			sprint(self.owner, "The Sanguinoch grows weary of you\n");
			self.rad_time = time + 5.5;
		}
	}

	if (self.radsuit_finished < time) {
		sprint(self.owner, "The Sanguinoch has left you\n");
		Cube_die();
		return;
	}

	if (self.owner.health <= 0) {
		Cube_die();
		return;
	}

	blood_CalcMove(cdest, cuspeed, Cube_control);
}

/* ------------------------------------- */
/* | bloodcb_touch - called when the   | */
/* | cube touches something.  If it    | */
/* | sees that it will hit a wall, it  | */
/* | centers itself above player until | */
/* | next call to Control_cube.        | */
/* ------------------------------------- */
void bloodcb_touch() {
	if (self.state == BLOOD_ASLEEP)
		return;

	if (other.flags & FL_MONSTER)
		return;

	if (other.health <= 0 || other.classname != "player") {
		if (self.state == BLOOD_AWAKE) {
			self.velocity = ((self.owner.origin + '0 0 48') - self.origin) * 2;
		}

		return;
	}

	if (other == self.enemy) {
		if (self.invincible_time < time) {
		   sprint(other, "The Sanguinoch doesn't want you anymore\n");
		   self.invincible_time = time + 2;
		}
		return;
	}

	if (self.state == BLOOD_AWAKE)  // already has an owner!
		return;

	self.owner = other;
	self.state = BLOOD_AWAKE;	//Cube is in the AWAKE state now
	self.cnt = 0;
	self.radsuit_finished = time + (deathmatch ? CUBE_GOAWAYTIME_DM : CUBE_GOAWAYTIME);
	self.invincible_finished = time + 12;   //time until hungry sound
	self.invisible_time = time + 2;

	sprint(other, "The Sanguinoch befriends you\n");
	sound(other, CHAN_AUTO, "cube/bc_activ.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");
	
	if (!(deathmatch))
		SUB_UseTargets ();

	self.nextthink = time + 0.2;
	self.think = Cube_control;
}

void() Cube_stop = 
{
	self.velocity = '0 0 0';
	//self.movetype = MOVETYPE_NONE;
	self.think = StartCube;
	self.nextthink = time + CUBE_RESPAWNTIME;
};

void() Cube_sleep =
{
	blood_CalcMove(self.origin - '0 0 32', 20, Cube_stop);
};

/* ----------------------------------------------------- */
/* | Cube_die - called when cube leaves the player for | */
/* |  any reason.  The cube will just lower itself a   | */
/* |  few feet and wait for someone else to pick it up.| */
/* |  The same player cannot pick it up twice in a row.| */
/* ----------------------------------------------------- */
void() Cube_die =
{
local vector 	spot;

// dhm: in single play, gone.
	if(!(deathmatch) && !(coop))
	{
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		return;
	}

	self.enemy = self.owner;
	self.aiment = world;
	self.owner = world;
	self.solid = SOLID_NOT;
	self.state = BLOOD_ASLEEP;
	self.velocity = '0 0 0';
	setorigin(self, self.oldorigin);
	self.mdl = self.model;
	self.model = string_null;
	self.nextthink = time + CUBE_RESPAWNTIME;
	self.think = StartCube;
};

void StartCube() {
	self.state = BLOOD_WAIT;
	self.netname = "BloodCube";
	setorigin(self, self.origin);

	if (deathmatch)
		self.solid = SOLID_TRIGGER;
	else
		self.solid = SOLID_BBOX;

	self.flags = self.flags | FL_ITEM;
	self.movetype = MOVETYPE_FLY;	
	self.velocity = '0 0 0';
	self.avelocity = '0 100 0';
	self.model = self.mdl;
	setmodel (self, "progs/bloodcb.mdl");
	setsize (self, '-1 -1 -1', '1 1 1');
}


/* --------------------------------------------------------- */
/*QUAKED item_bloodcube (0 .5 .8) (-16 -16 -24) (16 16 32)
New powerup!
*/
/* --------------------------------------------------------- */
void item_bloodcube() {
	self.dmg = CUBE_DAMAGE;
	self.height = CUBE_RANGE;
	self.delay = CUBE_ATTACKDELAY;

	if (deathmatch)
	{
		// CUBE_DAMAGE = CUBE_DAMAGE - 5;
		self.dmg = CUBE_DAMAGE - 5;

		// CUBE_ATTACKDELAY = 0.25;
		self.delay = CUBE_ATTACKDELAY_DM;

		// CUBE_RANGE = CUBE_RANGE - 100;
		self.height = CUBE_RANGE - 100;

		SUB_UseTargets();
	}

	self.classname = "BloodCube";
	self.touch = bloodcb_touch;
	self.oldorigin = self.origin;
	precache_model("progs/bloodcb.mdl");
	precache_sound("cube/bc_activ.wav");
	precache_sound("cube/bc_hngry.wav");
	precache_sound("cube/bc_gulp.wav");
	precache_sound("cube/bc_attck.wav");
	self.nextthink = time + 0.2;
	self.think = StartCube;
}


/* ---------------------------------- */
/* |  Used by flying gibs to guide  | */
/* |  them into the Bloodcube.      | */
/* ---------------------------------- */
void SeekCube() {
	vector vdestdelta;
	float len, traveltime, addhealth;

	if (deathmatch)
		addhealth = 7;
	else
		addhealth = 3;

	if(self.enemy == world || self.enemy.delay == 0)
	{
		self.movetype = MOVETYPE_BOUNCE;
		self.think = SUB_Remove;
		self.nextthink = time + 10 * random();
		return;
	}

	if(!(visible(self.enemy)))
	{
		self.movetype = MOVETYPE_BOUNCE;
		self.think = SUB_Remove;
		self.nextthink = time + 10 * random();
		return;
	}

	vdestdelta = self.enemy.origin - self.origin;
	len = vlen (vdestdelta);
	traveltime = len / 300;
	if (traveltime < 0.2)
	{
		if (self.enemy.super_time < time)
		{
			sound(self.enemy, CHAN_ITEM, "cube/bc_gulp.wav", 1, ATTN_NORM);
			self.enemy.super_time = time + 0.8;
		}
		self.enemy.owner.health = self.enemy.owner.health + addhealth;
		stuffcmd(self.enemy.owner, "bf\n");
		remove(self);
		return;
	}
	self.velocity = vdestdelta * (1/traveltime);
	self.nextthink = time + 0.2;
	self.think = SeekCube;
};

void() SeekCube;	//dhm - used for BloodCube!
void() bubble_bob;
void() player_die_sw1;
void() W_FireSuperShotgun;
/*
==============================================================================

PLAYER

==============================================================================
*/

$cd id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

//
// running
//
$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6

$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6

$frame sawrun1 sawrun2 sawrun3 sawrun4 sawrun5 sawrun6

//
// standing
//
$frame stand1 stand2 stand3 stand4 stand5

$frame swstnd1 swstnd2 swstnd3 swstnd4 swstnd5

$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12


//
// pain
//
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame swpain1 swpain2 swpain3 swpain4 swpain5 swpain6

//
// death
//

$frame axdeth1 axdeth2 axdeth3 axdeth4 axdeth5 axdeth6
$frame axdeth7 axdeth8 axdeth9

$frame swdeth1 swdeth2 swdeth3 swdeth4 swdeth5 swdeth6
$frame swdeth7 swdeth8 swdeth9

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 deatha11

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 deathc13 deathc14 deathc15

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7
$frame deathd8 deathd9

$frame deathe1 deathe2 deathe3 deathe4 deathe5 deathe6 deathe7
$frame deathe8 deathe9

//
// attacks
//
$frame nailatt1 nailatt2

$frame sawatt1 sawatt2

$frame light1 light2

$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6

$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6

$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6

$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6

$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6

$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6


/*
==============================================================================
PLAYER
==============================================================================
*/

void() player_run;

void()	player_stand1 =[	$axstnd1,	player_stand1	]
{
	if (self.velocity_x || self.velocity_y)
	{
		self.walkframe=0;
		player_run();
		return;
	}

	if (self.weapon == IT_CHAINSAW)
	{
		self.weaponframe = self.weaponframe + 1;
		if(self.weaponframe >= 5)
		{
			self.weaponframe = 0;
			if (self.view_ofs != '0 0 0')
				sound (self, CHAN_AUTO, "weapons/sawridle.wav", 1, ATTN_NORM);
		}
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $swstnd1 + self.walkframe;
		self.walkframe = self.walkframe + 1;	
		return;
	}
	else
		self.weaponframe=0;

	if (self.weapon == IT_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;	
};

void()	player_run =[	$rockrun1,	player_run	]
{
	if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
		player_stand1();
		return;
	}

	if (self.weapon == IT_CHAINSAW)
	{
		self.weaponframe = self.weaponframe + 1;
		if(self.weaponframe >= 5)
		{
			self.weaponframe = 0;
			if (self.view_ofs != '0 0 0')
				sound (self, CHAN_AUTO, "weapons/sawridle.wav", 1, ATTN_NORM);
		}
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = $sawrun1 + self.walkframe;
		self.walkframe = self.walkframe + 1;
		return;
	}
	else
		self.weaponframe=0;

	if (self.weapon == IT_AXE)
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = $axrun1 + self.walkframe;
	}
	else
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;
};


void()	player_shot1 =	[$shotatt1, player_shot2	] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()	player_shot2 =	[$shotatt2, player_shot3	] {self.weaponframe=2;};
void()	player_shot3 =	[$shotatt3, player_shot4	] {self.weaponframe=3;};
void()	player_shot4 =	[$shotatt4, player_shot5	] {self.weaponframe=4;};
void()	player_shot5 =	[$shotatt5, player_shot6	] {self.weaponframe=5;};
void()	player_shot6 =	[$shotatt6, player_run	] {
if (self.weapon != IT2_SRE) 
	self.weaponframe=6; 
else
	self.weaponframe=0;
};

void() W_FireRC =
{
	local vector dir, back;

	if (self.currentammo == 1)
	{
		W_FireShotgun ();
		return;
	}
		
	if (self.weaponframe < 3)
		sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM);	

	self.punchangle_x = -4;

//dhm - if shot in the air - do Newton's 3rd law.
	if (!(self.flags & FL_ONGROUND))
		self.velocity = self.velocity - (v_forward * 20);

	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	makevectors(self.v_angle);
	dir = v_forward; //aim (self, 100000);
	if (deathmatch)
		FireBullets (18, dir, '0.13 0.09 0');
	else
		FireBullets (13, dir, '0.12 0.08 0');
};

void()	player_rc1 =	[$shotatt1, player_rc2	] {self.weaponframe=1;
W_FireRC (); self.effects = self.effects | EF_MUZZLEFLASH;};
void()	player_rc2 =	[$shotatt2, player_rc3	] {self.weaponframe=2;};
void()	player_rc3 =	[$shotatt3, player_rc4	] {self.weaponframe=3;};
void()	player_rc4 =	[$shotatt4, player_rc5	] {self.weaponframe=4; W_FireRC (); self.effects = self.effects | EF_MUZZLEFLASH;};
void()	player_rc5 =	[$shotatt5, player_rc6	] {self.weaponframe=5;};
void()	player_rc6 =	[$shotatt6, player_run	] {self.weaponframe=6;};


void()	player_axe1 =	[$axatt1, player_axe2	] {self.weaponframe=1;};
void()	player_axe2 =	[$axatt2, player_axe3	] {self.weaponframe=2;};
void()	player_axe3 =	[$axatt3, player_axe4	] {self.weaponframe=3; W_FireAxe();};
void()	player_axe4 =	[$axatt4, player_run	] {self.weaponframe=4;};

void()	player_axeb1 =	[$axattb1, player_axeb2	] {self.weaponframe=5;};
void()	player_axeb2 =	[$axattb2, player_axeb3	] {self.weaponframe=6;};
void()	player_axeb3 =	[$axattb3, player_axeb4	] {self.weaponframe=7;W_FireAxe();};
void()	player_axeb4 =	[$axattb4, player_run	] {self.weaponframe=8;};

void()	player_axec1 =	[$axattc1, player_axec2	] {self.weaponframe=1;};
void()	player_axec2 =	[$axattc2, player_axec3	] {self.weaponframe=2;};
void()	player_axec3 =	[$axattc3, player_axec4	] {self.weaponframe=3;W_FireAxe();};
void()	player_axec4 =	[$axattc4, player_run	] {self.weaponframe=4;};

void()	player_axed1 =	[$axattd1, player_axed2	] {self.weaponframe=5;};
void()	player_axed2 =	[$axattd2, player_axed3	] {self.weaponframe=6;};
void()	player_axed3 =	[$axattd3, player_axed4	] {self.weaponframe=7;W_FireAxe();};
void()	player_axed4 =	[$axattd4, player_run	] {self.weaponframe=8;};

//==========================================================

void() player_chainsaw1   =[$sawatt1, player_chainsaw2 ] 
{self.weaponframe=5; W_FireSaw();};
void() player_chainsaw2   =[$sawatt2, player_chainsaw3 ] {self.weaponframe=6; 	if (!self.button0)
		{player_run ();return;}
};
void() player_chainsaw3   =[$sawatt1, player_chainsaw4 ] {self.weaponframe=7; W_FireSaw();};
void() player_chainsaw4   =[$sawatt2, player_chainsaw5 ] {self.weaponframe=8; 	if (!self.button0)
		{player_run ();return;}
};
void() player_chainsaw5   =[$sawatt1, player_chainsaw6 ] {self.weaponframe=9; W_FireSaw();};
void() player_chainsaw6   =[$sawatt2, player_run  ] {self.weaponframe=10;};

//============================================================================

void() player_nail1   =[$nailatt1, player_nail2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireSpikes (4);
	self.attack_finished = time + 0.2;
};
void() player_nail2   =[$nailatt2, player_nail1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireSpikes (-4);
	self.attack_finished = time + 0.2;
};

//=========================================================================

/* Obselete - too star-wars like. */
void(vector start, vector end) atat_Beam =
{
local vector	spray, next;
local float		dist, loop;
local entity	alaser;

	spray = start - end;
	dist = vlen(spray);
	loop = dist / 75;
	spray = normalize(spray);
	next = spray * 75;
	while(loop > 0)
	{
		//particle (end, spray, clr, pdensity);
		alaser = spawn();
		alaser.origin = end;
		alaser.angles = vectoangles(spray);
		setorigin(alaser, alaser.origin);
		setmodel(alaser, "progs/turlaser.mdl");
		alaser.think = SUB_Remove;
		alaser.nextthink = time + 0.1;
		end = end + next;
		loop = loop - 1;
	}
};
/* --------------------------------------------------- */

/* ChainGun code - if you can borrow code from id that does what you 
want to do ... DO IT!  It saves time, and you can worry more about 
making it better, optimizing, etc. */

void()	s_puff1	=	[0,	s_puff2] {};
void()	s_puff2	=	[1,	s_puff3] {};
void()	s_puff3	=	[2,	SUB_Remove] {};

void(vector org, vector vel) CG_puff =
{
local entity  puff, temp;
local float  prnd;

	puff = spawn();

	puff.origin = org;
	puff.solid = SOLID_NOT;
	puff.movetype = MOVETYPE_FLYMISSILE;
	puff.velocity = (vel * 0.4);
	setorigin(puff, puff.origin);

	prnd = random();
	if (prnd < 0.33)
		setmodel(puff, "progs/s_cg_1.spr");
	else if (prnd < 0.66)
		setmodel(puff, "progs/s_cg_2.spr");
	else	
		setmodel(puff, "progs/s_cg_3.spr");
		
	temp = self;
	self = puff;
	s_puff1 ();
	self = temp;
	//remove(temp);
};

void (vector dir) CG_Fire;

void(float damage, vector dir) CG_Attack =
{
	local	vector	vel, org, reverse;
	local entity	temp;
	local float		courage;

	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
		SpawnBlood (org, vel*0.2, damage);
		T_Damage (trace_ent, self, self, damage);
	}
	else
	{
		CG_puff (org, vel);
	}
};

void() Tracer_Remove =
{
	if (other != self.owner)
		remove(self);
};

void(vector dir) FireTracer =
{
local entity	tracer1;
local vector	src;
local float	calc;

	tracer1 = spawn();
	tracer1.solid = SOLID_BBOX;
	tracer1.owner = self;
	tracer1.movetype = MOVETYPE_FLYMISSILE;
	tracer1.effects = EF_DIMLIGHT;
	tracer1.touch = Tracer_Remove;
	tracer1.velocity = dir*1400;
	tracer1.angles = vectoangles(tracer1.velocity);
	tracer1.origin = src = self.origin + v_forward*5 + '0 0 12';

	setorigin(tracer1, tracer1.origin);
	setsize(tracer1, '0 0 0', '0 0 0');
	setmodel(tracer1, "progs/tracer.mdl");
};

void(vector dir) CG_Fire =
{
	local	vector direction;
	local	vector	src;
	
	src = self.origin + v_forward*10 + '0 0 12';
	direction = dir + crandom()*0.02*v_right + random()*0.02*v_up;

	traceline (src, src + direction*2048, FALSE, self);
	if (trace_fraction != 1.0)
		CG_Attack (12, direction);
};

void() player_atat1   =[$nailatt1, player_atat2  ] 
{
local vector dir, end;

	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);	

	self.currentammo = self.ammo_nails = self.ammo_nails - 1;
	self.punchangle_x = -1;
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 8)
		self.weaponframe = 1;
	SuperDamageSound();
	makevectors(self.v_angle);
	dir = v_forward; 
	if (self.cnt == 6)
	{
		self.cnt = 0;
		FireTracer (dir);
	}
	CG_Fire(dir);
	self.cnt = self.cnt + 1;
	self.attack_finished = time + 0.3;
};

void() player_atat2   =[$nailatt2, player_atat1  ]
{
local vector dir, end;

	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);	

	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 8)
		self.weaponframe = 1;
	SuperDamageSound();
	makevectors(self.v_angle);
	dir = v_forward; 
	if (self.cnt == 6)
	{
		self.cnt = 0;
		FireTracer (dir);
	}
	CG_Fire(dir);
	self.cnt = self.cnt + 1;
	self.attack_finished = time + 0.3;
};

//============================================================================

void() player_light1   =[$light1, player_light2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};
void() player_light2   =[$light2, player_light1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;
};

//----------------------
void() player_chain1   =[$rockatt1, player_chain2  ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void() player_chain2   =[$rockatt2, player_chain3  ] {self.weaponframe=2;};
void() player_chain3   =[$rockatt3, player_chain4  ] {self.weaponframe=3;};
void() player_chain4   =[$rockatt4, player_run     ] {self.weaponframe=4;};

//============================================================================


void() player_rocket1   =[$rockatt1, player_rocket2  ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void() player_rocket2   =[$rockatt2, player_rocket3  ] {self.weaponframe=2;};
void() player_rocket3   =[$rockatt3, player_rocket4  ] {self.weaponframe=3;};
void() player_rocket4   =[$rockatt4, player_rocket5  ] {self.weaponframe=4;};
void() player_rocket5   =[$rockatt5, player_rocket6  ] {self.weaponframe=5;};
void() player_rocket6   =[$rockatt6, player_run  ] {self.weaponframe=6;};
void(float num_bubbles) DeathBubbles;

void() PainSound =
{
local float		rs;

	if (self.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

// water pain sounds
	if (self.watertype == CONTENT_WATER && self.waterlevel == 3)
	{
		DeathBubbles(1);
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/drown2.wav", 1, ATTN_NORM);
		return;
	}

// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, CHAN_VOICE, "player/axhit1.wav", 1, ATTN_NORM);
		return;
	}
	

	rs = rint((random() * 5) + 1);

	self.noise = "";
	if (rs == 1)
		self.noise = "player/pain1.wav";
	else if (rs == 2)
		self.noise = "player/pain2.wav";
	else if (rs == 3)
		self.noise = "player/pain3.wav";
	else if (rs == 4)
		self.noise = "player/pain4.wav";
	else if (rs == 5)
		self.noise = "player/pain5.wav";
	else
		self.noise = "player/pain6.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	return;
};

void()	player_pain1 =	[	$pain1,	player_pain2	] {PainSound();self.weaponframe=0;};
void()	player_pain2 =	[	$pain2,	player_pain3	] {};
void()	player_pain3 =	[	$pain3,	player_pain4	] {};
void()	player_pain4 =	[	$pain4,	player_pain5	] {};
void()	player_pain5 =	[	$pain5,	player_pain6	] {};
void()	player_pain6 =	[	$pain6,	player_run	] {};

void()	player_swpain1 =	[	$swpain1,	player_pain2	] {PainSound();self.weaponframe=0;};
void()	player_swpain2 =	[	$swpain2,	player_pain3	] {};
void()	player_swpain3 =	[	$swpain3,	player_pain4	] {};
void()	player_swpain4 =	[	$swpain4,	player_pain5	] {};
void()	player_swpain5 =	[	$swpain5,	player_pain6	] {};
void()	player_swpain6 =	[	$swpain6,	player_run	] {};

void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();self.weaponframe=0;};
void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
void()	player_axpain5 =	[	$axpain5,	player_axpain6	] {};
void()	player_axpain6 =	[	$axpain6,	player_run	] {};

void player_pain(entity attacker, float damage) {
	if (self.weaponframe)
		return;

	if (self.invisible_finished > time)
		return;		// eyes don't have pain frames

	if (self.weapon == IT_AXE)
		player_axpain1 ();
	else if (self.weapon == IT_CHAINSAW)
		player_swpain1 ();
	else
		player_pain1 ();
};

void() player_diea1;
void() player_dieb1;
void() player_diec1;
void() player_died1;
void() player_diee1;
void() player_die_ax1;

void() DeathBubblesSpawn =
{
local entity	bubble;
	if (self.owner.waterlevel != 3)
		return;
	bubble = spawn();
	setmodel (bubble, "progs/s_bubble.spr");
	setorigin (bubble, self.owner.origin + '0 0 24');
	bubble.movetype = MOVETYPE_NOCLIP;
	bubble.solid = SOLID_NOT;
	bubble.velocity = '0 0 15';
	bubble.nextthink = time + 0.5;
	bubble.think = bubble_bob;
	bubble.classname = "bubble";
	bubble.frame = 0;
	bubble.cnt = 0;
	setsize (bubble, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
	if (self.air_finished >= self.bubble_count)
		remove(self);
};

void(float num_bubbles) DeathBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, self.origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = self;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};


void() DeathSound =
{
local float		rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		DeathBubbles(20);
		sound (self, CHAN_VOICE, "player/h2odeath.wav", 1, ATTN_NONE);
		return;
	}
	
	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		self.noise = "player/death1.wav";
	if (rs == 2)
		self.noise = "player/death2.wav";
	if (rs == 3)
		self.noise = "player/death3.wav";
	if (rs == 4)
		self.noise = "player/death4.wav";
	if (rs == 5)
		self.noise = "player/death5.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NONE);
	return;
};


void() PlayerDead =
{
	self.nextthink = -1;
// allow respawn after a certain time
	self.deadflag = DEAD_DEAD;
};

/* ----------------------------------------------- */
/* | dhm:  I modified this function to choose a  | */
/* |  velocity based on the vector between the   | */
/* |  target and the inflictor.  All calls to a  | */
/* |  ThrowGib or ThrowHead function were changed| */
/* |  to include this vector.                    | */
/* ----------------------------------------------- */
vector(float dm, vector dir) VelocityForDamage =
{
	local vector v, gib_dir;

	gib_dir = normalize(dir);

	v_x = 90 * gib_dir_x + (random() * 70 - 35);
	v_y = 90 * gib_dir_y + (random() * 70 - 35);
	v_z = 200 + 100 * random();

	if (dm > -50)
	{
//		dprint ("level 1\n");
		v = v * 0.9;
	}
	else if (dm > -200)
	{
//		dprint ("level 3\n");
		v = v * 2;
	}
	else
		v = v * 10;

	return v;
};

/* ------------------------------------- */
/* | dhm: This has been modified for 2 | */
/* |  reasons.  It sends a vector to   | */
/* |  calculate realistic gib velocity | */
/* |  and it looks for the BloodCube   | */
/* |  to see if it needs to fly at it. | */
/* ------------------------------------- */
float bloodcube_is_awake(entity);

void(string gibname, float dm, vector dir) ThrowGib =
{
	local	entity new,cube;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, gibname);
	setsize (new, '0 0 0', '0 0 0');
	new.velocity = VelocityForDamage (dm, dir);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_TRIGGER;
	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;
	new.think = SUB_Remove;
	new.ltime = time;
	new.nextthink = time + 10 + random()*10;
	new.frame = 0;
	new.flags = 0;

// dhm - if there is an active bloodcube, go for it!
	cube = find(world, classname, "BloodCube");
	while(cube != world)
	{
		if (bloodcube_is_awake(cube))
		 if (visible(cube))
		 {
			new.movetype = MOVETYPE_FLY;
			new.solid = SOLID_BBOX;
			new.enemy = cube;
			new.think = SeekCube;
			new.nextthink = time + 0.2 + random()*0.8;
			return;
		 }
		cube = find(cube, classname, "BloodCube");
	}
};

void(string gibname, float dm, vector dir) ThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
	self.think = SUB_Null;
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	if (self.classname != "player" && self.classname != "actor")
		self.solid = SOLID_TRIGGER;
	else
		self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = VelocityForDamage (dm, dir);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
};


void() GibPlayer =
{
	ThrowHead ("progs/h_player.mdl", self.health, self.dest);
	ThrowGib ("progs/gib1.mdl", self.health, self.dest);
	ThrowGib ("progs/gib2.mdl", self.health, self.dest);
	ThrowGib ("progs/gib3.mdl", self.health, self.dest);

	self.deadflag = DEAD_DEAD;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}
		
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
};

void() PlayerDie =
{
	local	float	i;
	
	self.items = self.items - (self.items & IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.invincible_finished = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.wing_finished = 0;
	self.modelindex = modelindex_player;	// don't use eyes

	if (deathmatch || coop)
		DropBackpack();
	
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;

	self.lefty = time + 0.5;		// time of death, to stop respawns before .5 secs

	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;

	sound (self, CHAN_WEAPON, "misc/null.wav", 1, ATTN_NORM);

	if (self.health < -40)
	{
		GibPlayer ();
		return;
	}

	DeathSound();
	
	self.angles_x = 0;
	self.angles_z = 0;
	
	if (self.weapon == IT_AXE)
	{
		player_die_ax1 ();
		return;
	}
	if (self.weapon == IT_CHAINSAW)
	{
		player_die_sw1 ();
		return;
	}
	
	i = cvar("temp1");
	if (!i)
		i = 1 + floor(random()*6);
	
	if (i == 1)
		player_diea1();
	else if (i == 2)
		player_dieb1();
	else if (i == 3)
		player_diec1();
	else if (i == 4)
		player_died1();
	else
		player_diee1();

};

void() set_suicide_frame =
{	// used by klill command and diconnect command
	if (self.model != "progs/player.mdl")
		return;	// allready gibbed
	self.frame = $deatha11;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_TOSS;
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
};


void()	player_diea1	=	[	$deatha1,	player_diea2	] {};
void()	player_diea2	=	[	$deatha2,	player_diea3	] {};
void()	player_diea3	=	[	$deatha3,	player_diea4	] {};
void()	player_diea4	=	[	$deatha4,	player_diea5	] {};
void()	player_diea5	=	[	$deatha5,	player_diea6	] {};
void()	player_diea6	=	[	$deatha6,	player_diea7	] {};
void()	player_diea7	=	[	$deatha7,	player_diea8	] {};
void()	player_diea8	=	[	$deatha8,	player_diea9	] {};
void()	player_diea9	=	[	$deatha9,	player_diea10	] {};
void()	player_diea10	=	[	$deatha10,	player_diea11	] {};
void()	player_diea11	=	[	$deatha11,	player_diea11 ] {PlayerDead();};

void()	player_dieb1	=	[	$deathb1,	player_dieb2	] {};
void()	player_dieb2	=	[	$deathb2,	player_dieb3	] {};
void()	player_dieb3	=	[	$deathb3,	player_dieb4	] {};
void()	player_dieb4	=	[	$deathb4,	player_dieb5	] {};
void()	player_dieb5	=	[	$deathb5,	player_dieb6	] {};
void()	player_dieb6	=	[	$deathb6,	player_dieb7	] {};
void()	player_dieb7	=	[	$deathb7,	player_dieb8	] {};
void()	player_dieb8	=	[	$deathb8,	player_dieb9	] {};
void()	player_dieb9	=	[	$deathb9,	player_dieb9	] {PlayerDead();};

void()	player_diec1	=	[	$deathc1,	player_diec2	] {};
void()	player_diec2	=	[	$deathc2,	player_diec3	] {};
void()	player_diec3	=	[	$deathc3,	player_diec4	] {};
void()	player_diec4	=	[	$deathc4,	player_diec5	] {};
void()	player_diec5	=	[	$deathc5,	player_diec6	] {};
void()	player_diec6	=	[	$deathc6,	player_diec7	] {};
void()	player_diec7	=	[	$deathc7,	player_diec8	] {};
void()	player_diec8	=	[	$deathc8,	player_diec9	] {};
void()	player_diec9	=	[	$deathc9,	player_diec10	] {};
void()	player_diec10	=	[	$deathc10,	player_diec11	] {};
void()	player_diec11	=	[	$deathc11,	player_diec12	] {};
void()	player_diec12	=	[	$deathc12,	player_diec13	] {};
void()	player_diec13	=	[	$deathc13,	player_diec14	] {};
void()	player_diec14	=	[	$deathc14,	player_diec15	] {};
void()	player_diec15	=	[	$deathc15,	player_diec15 ] {PlayerDead();};

void()	player_died1	=	[	$deathd1,	player_died2	] {};
void()	player_died2	=	[	$deathd2,	player_died3	] {};
void()	player_died3	=	[	$deathd3,	player_died4	] {};
void()	player_died4	=	[	$deathd4,	player_died5	] {};
void()	player_died5	=	[	$deathd5,	player_died6	] {};
void()	player_died6	=	[	$deathd6,	player_died7	] {};
void()	player_died7	=	[	$deathd7,	player_died8	] {};
void()	player_died8	=	[	$deathd8,	player_died9	] {};
void()	player_died9	=	[	$deathd9,	player_died9	] {PlayerDead();};

void()	player_diee1	=	[	$deathe1,	player_diee2	] {};
void()	player_diee2	=	[	$deathe2,	player_diee3	] {};
void()	player_diee3	=	[	$deathe3,	player_diee4	] {};
void()	player_diee4	=	[	$deathe4,	player_diee5	] {};
void()	player_diee5	=	[	$deathe5,	player_diee6	] {};
void()	player_diee6	=	[	$deathe6,	player_diee7	] {};
void()	player_diee7	=	[	$deathe7,	player_diee8	] {};
void()	player_diee8	=	[	$deathe8,	player_diee9	] {};
void()	player_diee9	=	[	$deathe9,	player_diee9	] {PlayerDead();};

void()	player_die_ax1	=	[	$axdeth1,	player_die_ax2	] {};
void()	player_die_ax2	=	[	$axdeth2,	player_die_ax3	] {};
void()	player_die_ax3	=	[	$axdeth3,	player_die_ax4	] {};
void()	player_die_ax4	=	[	$axdeth4,	player_die_ax5	] {};
void()	player_die_ax5	=	[	$axdeth5,	player_die_ax6	] {};
void()	player_die_ax6	=	[	$axdeth6,	player_die_ax7	] {};
void()	player_die_ax7	=	[	$axdeth7,	player_die_ax8	] {};
void()	player_die_ax8	=	[	$axdeth8,	player_die_ax9	] {};
void()	player_die_ax9	=	[	$axdeth9,	player_die_ax9	] {PlayerDead();};

void()	player_die_sw1	=	[	$swdeth1,	player_die_sw2	] {};
void()	player_die_sw2	=	[	$swdeth2,	player_die_sw3	] {};
void()	player_die_sw3	=	[	$swdeth3,	player_die_sw4	] {};
void()	player_die_sw4	=	[	$swdeth4,	player_die_sw5	] {};
void()	player_die_sw5	=	[	$swdeth5,	player_die_sw6	] {};
void()	player_die_sw6	=	[	$swdeth6,	player_die_sw7	] {};
void()	player_die_sw7	=	[	$swdeth7,	player_die_sw8	] {};
void()	player_die_sw8	=	[	$swdeth8,	player_die_sw9	] {};
void()	player_die_sw9	=	[	$swdeth9,	player_die_sw9	] {PlayerDead();};


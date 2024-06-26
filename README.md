# Zerstörer - Testament of the Destroyer


## Introduction

Nihilism Unlimited is proud to present a new experience for Quake...
Zerstörer - Testament of the Destroyer!

A new single-player experience will draw you into a demented world like never
before.  All new professional quality levels make up the Single-player
episode, complete with cut-scenes to further the story.  You'll wield some
fantastic weapons and discover amazing artifacts to help you on your journey
into the Zerstörer's realm.  We haven't forgotten the Multi-player game
though, as all single-player maps make great deathmatch maps as well ... PLUS
you'll have another entire episode of deathmatch-only maps to frag in.  Many
fast-paced and frag-friendly levels have been play-tested to perfection for
your enjoyment.  Not only that, but you can play them all on QuakeWorld.


## Story

He took you from the streets and gave you all that you could have asked for.
He spoke with eloquence of the dreams which he would share with you.  In
return you ran special missions for him, some mundane and some bizarre.  It
was not long before you noticed things around you were not always as they
seemed, but you were well taken care of.  What did it matter anyway?  Things
have steadily gotten worse, and you are starting to see him in your dreams.
Nightmares haunt your slumber and leave you with visions you'd kill to
forget.  It is time to get out of this place while you still can.  Perhaps
you won't return from the mission tonight.

It all seemed right before the blood stained your hands.  The mission did not
go as planned, and now you are left with the cold chill of murder under your
skin.  There wasn't supposed to be anyone here.  You were supposed to find
medical supplies, but in fact, all you found was a crazed man with a knife.
Did you just hear laughter?  No, must have been the wind.

How could you have done this?  What kind of monster have you become?  His
words all seem twisted now, and you begin to see through his infectious lies.
He has controlled and manipulated you from the start.  No one will believe
your story, and as the blood drips from your clenched fists you realize there
is no one who can help you now. You've got to keep moving, you've got to get
out of here. Your only choice is to right your wrongs, rewrite what has been
written. You must make weapons out of his corruption, and use this strength
he has given you to turn these mistakes against him.  There is no other
choice.

The final chapter must be written...

Zerstörer - Testament of the Destroyer


## Installation

Unzip into a directory beneath the Quake directory, e.g.:  `c:\quake\zer`

Start by typing:  

```shell
quake -game zer
```

## Single-player Games

You should automatically start in the new start map.  If you don't, start a new single player game using the menu.  You can now pick your skill level and enter the realm of the Zerstörer.  I recommend playing on the 'Hard' skill level for maximum enjoyment.

## Deathmatch Games

You have two choices of level sequences that you can play.

You may choose to play the single-player episode (all maps have been designed for DM play - with weapons, powerups, teleporters, and even new architecture to make the maps suitable for great deathmatch action). To play the single-player episode, start on the level 'zer1m1' and the maps will cycle through the single-player episode.

You may also choose the play the deathmatch specific set of maps.  To play these maps, start on the level 'start' and the maps will cycle through the deathmatch-only episode.


## Technical Notes

1.  If you have already seen a cut-scene, and would like to stop it, any impulse will abort.  You may bind a key to an unused impulse, like 100, or you could just press any number key.  I recommend pressing the key to select the weapon you are carrying.

2.  glQuake is supported and recommended.  Transparent water is supported in the Deathmatch Levels Only.  Much of the single player episode was designed before glQuake made transparent water a possibility, so there are areas that suffer from high r_speed values if the levels are compiled with transparent water.  We are not willing to trade framerate for gee-whiz effects.

3.  It is possible to double the amount of ammo that is contained inside all weapons.  This is useful for certain modes of deathmatch.  To turn this feature on in normal Quake, set the 'temp1' CVAR to '22'.  (Go to the console and type: temp1 22)  To set this feature in QuakeWorld, you must type: "serverinfo temp1 22" on the server.

4.  There is a file, devkit.zip, which includes all the source code and documentation that we accumulated over the course of the project.  Make sure you use the unzip option to recreate the directory structure (pkunzip -d).

5.  The new impulses for weapon selection are as follows:
	- New melee weapon == `impulse 252`  (impulse 1 will also toggle select)
	- Chain-lightning gun == `impulse 253`  (impulse 8 will also toggle select)
	- ScREw Cannon == `impulse 254` (automatically bound to '9')

6.  If you are playing 'zer1m3' and must start over, please use the console command 'map zer1m3' to start over.  Do not use 'restart', because an entity will not spawn properly on its bmodel.


## Weapons

1. Toggles between AXE and a NEW melee weapon.
2. SHOTGUN - standard issue, but with beefed up cartridges.
3. RIOT CONTROLLER - Fires two heavy duty cartridges one after another.
4. CHAINGUN - Unload quite a bit of lead, quickly.
5. SUPER NAILGUN - standard issue.
6. GRENADE LAUNCHER - standard issue.
7. ROCKET LAUNCHER - standard issue.
8. Toggles between the normal LIGHTNING GUN and the new CHAIN-LIGHTNING GUN.
9. ScREw CANNON - Fires a plasma charge with an embedded detonator. While the 'attack' button is held down, the projectile will continue flying until it has bounced twice off solid objects. Any time during its flight, you may release the 'attack' button to detonate the plasma for the maximum blast damage.


## Powerups

### The Sanguinoch

You'll see.

### The Dark-Angel Wings

These take a while to master, but are very useful once you get used to them.  Look in the direction you'd like to go, and press jump to flap your wings.

### The Courage Armor

A breastplate that will reflect some enemy fire away from you.  Just don't get shot in the back.


## Levels

* start  'Another Perfect Day' - Kandyman
* zer1m1 'Shipping Complex' - Manzer
* zer1m2 'Deceit' - Manzer(level) and Darin(cut-scene)
* zer1m3 'Among the Dead' - Ace_Dave
* zer1m4 'Organ Grinder' - Midiguy
* zer1m5 'Blutsturz' - Kandyman and Manzer
* zer1m6 'True Love Waits' - Kandyman
* zer1m7 'Bunker' - Kandyman
* zer1m8 'The Destroyer' - Ace_Dave(level) and Darin(cut-scene)

* zerdm1 'Brainwash' - Manzer
* zerdm2 'Sparsatorium' - Dr. Rigormortis
* zerdm3 'Utera' - Dr. Rigormortis
* zerdm4 'Brutalizer' - Kandyman
* zerdm5 'Blood Base' - Manzer


## Credits

Every team member contributed greatly in every aspect of the conversion, so it seems almost a disservice to label each person with a task.  The following is only what a persons main responsibility was on the project and does not accurately reflect who did what for Zerstörer.

Brandon 'Killme' James
 - (bjames@idsoftware.com) ........ Founder/Support/Inspiration

Marin 'Kandyman' Gazzari
 - (kandyman@ims.at) .............. Level Design/models
 * Kandyman wishes to thank Lilgirl, Zlatko, Qphi and Flood,
   Clan QL, and Bunny[med] for help with betatesting."
 * Kandyman uses Quest and Ed3d for making levels.

Dave 'Ace_Dave' Weiden
 - (weiden@tcnj.edu) .............. Level Design/Programming
 - (http://www.tcnj.edu/~weiden/quake)
 * Ace_Dave wishes to thank this incredible team, the almighty id(!), Brandon James for starting this whole thing many months ago, Quest, WorldCraft, QBSP256c, RVis, and all those who have contributed **so much** to the Quake community, making it such a great place to be.
   And of course, our supporters!

Cole 'Manzer' Savage
 - (cole@dodgenet.com) ............ Level Design
 * Manzer would like to thank id Software for Quake, Ben Morris for Worldcraft, and all the people who have supported Zerstörer over the months.
 * Manzer would like to congratulate KillMe for getting that job at that one place :)
 * Manzer used WC1.1 to make his zer maps and now uses WC1.5

Dale 'Midiguy' Bertheola
 - (midiguy@crl.com) .............. Level Design

Scott 'Dr. Rigormortis' Dalton
 - (s975020@obirin.ac.jp) ......... Art/Models/Level Design
 * Dr. Rigormortis would like to thank Darin for making all my nightmares reality; the whole level-design team for giving me new nightmares; Kandy for the weapon models that always looked cooler than mine; the impulse 9 clan bunker crew for inspiration, criticism, and beta testing; id Software for Quake; Rene Post and Ben Morris for making this kind of editing possible; and all the people who have made Quake what it is.

Ratmonkey
 - (yagyu@falcon.cc.ukans.edu) ..... Sound Effects/Art

Darin McNeil
 - (darin@usl.edu) ................. Programming/Cinematics
 * Darin would like to thank the entire team for making this project the most amazing experience I've ever had; id Software for giving us the power to create new worlds; Brandon James for bringing us all together and inspiring us to do wonderful things; and most of all, everyone out there in the Quake community for making it worth our while.

## Disclaimers

* This product is property and is copyrighted by Nihilism Unlimited.
* If this product appears on any medium/media without the consent of Nihilism Unlimited, full legal action will be taken.
* Some music samples from Zerstörer are snipped from:
  
  'The Perfect Drug' by Nine Inch Nails, appearing on the 'Lost Highway' soundtrack - copyright 1997 Nothing Records.
  
  And..
  
  'The Perfect Drug' by Nine Inch Nails, appearing on 'The Perfect Drug Remixes' - copyright 1997 Nothing Records.
* A small amount of code is borrowed from 'Quake Mission Pack No. 1' by Ritual. A BIG thanks to Ritual for their contributions to the Quake community.
* Rain code and graphics adapted from the patch originally released by Brian Cozzens.
* func_frame code adapted from the patch by Matt Houser, who was inspired by Dimensionality.
* exploding_wall code adapted from the patch by Ben Lehman.
* A special thank-you goes to id Software, who with their tireless commitment to the genre and to the Quake community, have given us the tools and engine to make our ideas and dreams a reality.


Nihilism Unlimited.


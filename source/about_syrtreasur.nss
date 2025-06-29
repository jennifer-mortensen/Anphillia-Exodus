/////////////////////////////////////////////////////////////////
/////
/////
/*

The Modified Treasure Generation Scripts:

The goal of these scripts is to create a treasure generation system closer to
that of the DMG.

This script package will overwrite these scripts automatically. Certain key BioWare scripts are
preserved in the original (default) version to permit recovery if the system is disabled.

The default OnSpawn script (nw_c2_default9) is preserved as old_c2_default9.  If the BioWare system
is desired this can be saved as nw_c2_default9, restoring the BioWare NPC loot system.
The old nw_o2_classhig script is perserved as sy_i_classhig.  The purpose of this is to
allow you to create (if desired) a bountious (special purpose) treasure with tailored to
the class of the player who opens the chest.

These tables also reference a collection of new items, which are in Syr_Treasure002.erf.  These
items include scrolls for all divine spells, a bunch of rings, wands and potions and
a collection of items left off of the BioWare tables (including MW Weapons).  There are also four
placeable containers which are used in the NPC treasure generation system.

QUICK START:  How do I plan on using my own system?
    Default settings (why else did I choose those settings.....).
    Place a (often trapped) NPCBag for each 'placed' encounter.
    Random or Patrolling encounters will not use NPCBags (they are carrying their excess gear
        because they are not in the 'lair'.
    Container scripts will be used for hidden or trapped treasure not directly guarded by NPCs.

Note:  OBSOLETE FILES:  If you installed this version over an old version you may
  have some files which begin with "sy_".  Although the presence of these files will '
  not affect the operation of the system, they can be erased if desired.  Files
  beginning with "syr_" should NOT be erased.



CONTAINER TREASURE GENERATION:
    *note*:  If you use both the item and NPC treasure generation systems (recommended) the NPC
    system will generate sufficient loot (and a chest if so desired) so placement of a treasure
    chest for standard treasure is not necessary.  The container scripts can instead be used for
    specific situations (e.g. unguarded or hidden treasure).

In these scripts, in keeping with the DMG system, magic items are randomly generated
according to a CR value but without regard for the players class (making it dependant
on the class of the chest opener is a bad idea in multiplayer anyways - it tends to
make the loot disproportionatly favor the rogue or whomever is the fastest
on the clicker).

However, the quantity of gold and the frequency of gems is reduced from the 3rd edition
levels to reflect the fact that most PCs will kill far more creatures over the span of a
level, thus allowing them to accumulate excessive loot in that time.  This value of this
variable is what distinguishes the three nw_o2_generalxxx scripts from each other.

By default there are six different scripts that can be found on a chest, but
three of these are redundant copies.  These are overwritten by default.
At present this CR value is based on the level of the character who opens the
chest, but the low and med scripts have the maximum CR capped (to prevent bottom
feeding by high level characters in low level areas).

nw_o2_classlow: Produces a "rich" treasure with the CR capped at 5.
nw_o2_generallow: Produces a "standard" treasure with the CR capped at 5.
nw_o2_classmed: Produces a "rich" treasure with the CR capped at 10.
nw_o2_generalmed: Produces a "standard" treasure with the CR capped at 10.
nw_o2_classhig: Produces a "rich" treasure (no CR cap).
nw_o2_generalhig: Produces a "standard" treasure (no CR cap).

In addition there are two container specific scripts:
nw_02_bookshelf (overwrites the BioWare script): Generates a book (90%) or a random scroll.
nw_o2_weaponrack (no BioWare equivelent): Generates a small selection of non-magical items with a
  chance for a magical weapon.

A better system (for non-scaled encounters) would be to create a series of chests for each CR
and set the value of the CR in the relevant OnOpen/OnDeath script (i.e. create a new script to
replace nw_o2_generalmed).

NPC TREASURE GENERATION SYSTEM:
This system is designed to generate a treasure appropriate to an NPC.  This system will genenerate
a treasure according to the guidelines in the MM and DMG (modified by the CashLevel and MagicLevel settings).
In addition, NPCs who have a PC class as their major class have an increased chance (~3% per level)
for a magical item appropriate to their class, as well as non-magical armor and weapons.

Any items the NPCs can use they should equip.  If there is a NPCBag in the area, they will move any gold or
items they cannot equip to that container.  Scrolls, potions and other 'useful' items are kept in
inventory, as are gems.

There are three different ways this can be set up, depending on how the NPC containers
are set up.
1)  By default - CreateNPCBag is set to False.  With this setting, the NPCs will not generate their own
containers.  If this is set to TRUE, one NPC per area will generate a container (Chest, Crate, Bag or
Pile of Bones depending on the Race) and the NPCs will transfer some of their excess items (mostly
items they cannot equip) to the container.
2)  Rather then having a random NPC create the container you can either place the container manually (giving
the DM the most control over the placement of the container as well as its DCs and Trap status).  Note:  All
that matters for the purpose of the script is that the TAG of the item be correct (SYR_NPC_VIC).  If you place
the containers yourself, you can create any container you wish for this purpose.
3)  Alternately - if you want some NPCs to keep their excess loot in inventory (for example to prevent cluttering
the city streets with treasure chests) while allowing others (for example in the dungeon) to create
chests:  Leave CreateNPCBag = FALSE but change the OnSpawn script of at least one NPC per encounter
to nw_c2_default9b.  This script sets CreateNPCBag = TRUE for that individual only.

Notes on the NPC system:

**Items equipped on an NPC will enter the Equipping queue and (if no better item is generated) will be
equipped.  Items placed in general inventory (not equipped) will not be equipped and will remain in
inventory.  Note:  The current algorithm looks for Point Blank Shot and if not found will equip a melee weapon
over a range weapon (although the range weapon is retained in inventory).

**Creature Melee Items are equipped by default.  If you notice a creature that is unequipping its
creature melee weapon, please point it out to me so that I can determine what the problem is.

**This system uses the gold piece value of an item to determine relative value.  If anyone can think of a
better system to use to compare a wide range of items, I welcome the suggestion.  Until then - NPCs will equip
their most valuable item (for which they have the required proficiency) in any given slot.

**Known issue:  At present - this system attempts to verify that the NPCs have the necessary
proficiencies to use any item but it cannot detect Use Restrictions placed on an item.  This is noticed
most frequently in the case of monk robes being generated on wizards/sorcerers.  Hopefully a solution will
be found to this problem.

Notes on Switches:
Syrsuro = TRUE
    This turns on the system.
    - NOTE:  To disable the system, in addition to setting Syrsuro = FALSE you must ALSO save old_c2_default9
    as nw_c2_default9.
CreateNPCBag = FALSE
    This determines whether all encounters/NPCs will have the ability to create a
    container to put stuff in.
BWHeal = FALSE;
HighLevelPotions = FALSE;
BWLockPick = FALSE;
HCRPickDrop = FALSE;
    These determine whether certain specific items can be generated by the system.  See Syr_TG_Switches for
        details.
CashLevel = SYR_DEFAULT;
    This determines the multiplier used to adjust the 3rd edition tables to NWN.
MagicLevel = SYR_DEFAULT;
    This determines the relative magic level, affecting both the value of the magic items generated
        as well as the likelihood of getting multiple items.


Version HC1.1.1
    Fixed (REALLY STUPID) bugs in switches that prevented their working properly.

Version HC1.1.0
    Fixed typo that resulted in Master Adventurer Robe dropping as minor magic item.
    Improved handling of Low MagicLevel.
    Tweaked item generation routines for creatures with PC Classes.
    Tweaked the drop rates of all creatures.  This should result in a lowering of the
       overall drop rates, but especially for higher level creatures.

Version HC1.0.1
    Fixed bug that resulted in Cash_Level not working properly in NPC Treasure Generation

Version HC1.0.0
    Added Syr_TG_Switches to permit enabling/disabling and customization of the system.
        note:  Option to restore high level potions (removed in HC001) added back in via
        a switch (still disabled by default).
    Added NPC treasure generation system (including custom placeables).
    Changed Item Generation functions to return strings (for use in CreateItem functions) rather then
        voids.  This allows more complex handling of the items.
    Changed the types of treasure generated by each of the default container scripts to allow for max CR caps.
    Added Bookshelf and WeaponRack generation scripts.
    Numerous minor fixes.

Version: HC001
    Replaced HC Heal kit with HC Medicine Bag
    Disabled High Level Potions (including Heal).  Potions still in Item file
        but can no longer occur as random treasure.
    Added Masterwork weapons.
    Added a bunch of minor magical weapons.
    Tweaked (decreased) odds of getting multiple magic item.
    Other minor bug fixes.

Version: 101
    These scripts now also include HC items from HCR version 1.4.5

Carl
















 */

void main()
{

}

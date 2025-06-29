//J. Persinne, Feb. 11 2010; restructured and optimized code.

#include "_inc_subrace"

void SpawnScrollsLevel1(object oContainer);
void SpawnScrollsLevel2(object oContainer);
void SpawnScrollsLevel3(object oContainer);
void SpawnScrollsLevel4(object oContainer);
void SpawnScrollsLevel5(object oContainer);
void SpawnScrollsLevel6(object oContainer);
void SpawnScrollsLevel7(object oContainer);
void SpawnScrollsLevel8(object oContainer);
void SpawnScrollsLevel9(object oContainer);

//Destroys the hide object if it is not currently equipped on the specified PC.
void DestroyUnequippedHide(object oHide, object oPC)
{
    if(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC) != oHide)
        DestroyObject(oHide);
}

void main()
{
    object oItem = GetModuleItemAcquired();
    object oAcquiredFrom = GetModuleItemAcquiredFrom();
    object oPC = GetModuleItemAcquiredBy();
    int nObjectType = GetObjectType(oAcquiredFrom);
    int nScrollsSpawned;
    int nScrollsLevel;

    if(nObjectType == OBJECT_TYPE_STORE)
    {
        if(GetLocalInt(oItem, "DO_NOT_DUPLICATE_ON_PURCHASE") != TRUE && GetInfiniteFlag(oItem) == FALSE && GetItemStackSize(oItem) == 1 && GetBaseItemType(oItem) != BASE_ITEM_POTIONS)
            CopyItem(oItem, oAcquiredFrom, TRUE); //Replace items back into merchant inventory.

        if(GetTag(oItem) == "SCROLL_CASE") //Handle purchasing of scroll case items.
        {
            nScrollsSpawned = GetLocalInt(oItem, "SCROLLS_SPAWNED");
            if(nScrollsSpawned) //Don't respawn scrolls if we've done that already.
                return;

            nScrollsLevel = GetLocalInt(oItem, "SCROLL_LEVEL");

            switch(nScrollsLevel)
            {
                case 1:
                    SpawnScrollsLevel1(oItem);
                    break;
                case 2:
                    SpawnScrollsLevel2(oItem);
                    break;
                case 3:
                    SpawnScrollsLevel3(oItem);
                    break;
                case 4:
                    SpawnScrollsLevel4(oItem);
                    break;
                case 5:
                    SpawnScrollsLevel5(oItem);
                    break;
                case 6:
                    SpawnScrollsLevel6(oItem);
                    break;
                case 7:
                    SpawnScrollsLevel7(oItem);
                    break;
                case 8:
                    SpawnScrollsLevel8(oItem);
                    break;
                case 9:
                    SpawnScrollsLevel9(oItem);
                    break;
            } //We have no default case, since the default case should be, "Hey guyz, whichever builder created this item totally forgot to add a scroll level variable", but we'd rather not burden our players
              //with ugly bug report code on the off chance that should ever happen.
        }
    }
    else if(GetBaseItemType(oItem) == BASE_ITEM_TRAPKIT)
    {
        SetIdentified(oItem, TRUE);
    }
    else if(GetTag(oItem) == "x3_it_pchide")
    {
        SetItemCursedFlag(oItem, FALSE);
        DelayCommand(0.5, ApplySubraceFeats(oPC));
        DelayCommand(3.0, DestroyUnequippedHide(oItem, oPC));
    }
    else if(GetObjectType(oAcquiredFrom) == OBJECT_TYPE_PLACEABLE && GetLocalInt(oAcquiredFrom, "LOOT_CHEST") == 1) //J. Persinne, Feb. 11 2010; while this functionality was "nice", it wasn't needed.
    {                                                                                                               //Removing it will speed up item acquisition code slightly.
        CopyItem(oItem, oAcquiredFrom, TRUE);                                                                       //Why am I so particularly fussy about this, when the difference seems practically negligible?
    }                                                                                                               //Blame George.
}

void SpawnScrollsLevel1(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 27)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "x1_it_spdvscr101"; //Bane
                break;
            case 2:
                sScrollResRef = "nw_it_sparscr112"; //Burning Hands
                break;
            case 3:
                sScrollResRef = "nw_it_sparscr107"; //Charm Person
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr110"; //Color Spray
                break;
            case 5:
                sScrollResRef = "x2_it_spdvscr105"; //Doom
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr101"; //Endure Elements
                break;
            case 7:
                sScrollResRef = "x1_it_sparscr101"; //Expeditious Retreat
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr103"; //Grease
                break;
            case 9:
                sScrollResRef = "x2_it_sparscr101"; //Horizikaul's Boom
                break;
            case 10:
                sScrollResRef = "x2_it_sparscr104"; //Ice Dagger
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr106"; //Identify
                break;
            case 12:
                sScrollResRef = "x2_it_sparscr102"; //Ironguts
                break;
            case 13:
                sScrollResRef = "nw_it_sparscr104"; //Mage Armor
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr109"; //Magic Missile
                break;
            case 15:
                sScrollResRef = "x2_it_sparscr105"; //Magic Weapon
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr113"; //Negative Energy Ray
                break;
            case 17:
                sScrollResRef = "x2_it_sparscral"; //Protection from Alignment
                break;
            case 18:
                sScrollResRef = "nw_it_sparscr111"; //Ray of Enfeeblement
                break;
            case 19:
                sScrollResRef = "x2_it_spdvscr107"; //Remove Fear
                break;
            case 20:
                sScrollResRef = "x2_it_spdvscr108"; //Sanctuary
                break;
            case 21:
                sScrollResRef = "nw_it_sparscr210"; //Scare
                break;
            case 22:
                sScrollResRef = "x2_it_sparscr103"; //Shelgarn's Persistent Blade
                break;
            case 23:
                sScrollResRef = "x1_it_sparscr103"; //Shield
                break;
            case 24:
                sScrollResRef = "nw_it_sparscr108"; //Sleep
                break;
            case 25:
                sScrollResRef = "nw_it_sparscr105"; //Summon Creature I
                break;
            case 26:
                sScrollResRef = "x1_it_sparscr104"; //True Strike
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}
void SpawnScrollsLevel2(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 33)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "x1_it_sparscr201"; //Balagarn's Iron Horn
                break;
            case 2:
                sScrollResRef = "nw_it_sparscr211"; //Blindness/Deafness
                break;
            case 3:
                sScrollResRef = "nw_it_sparscr212"; //Bull's Strength
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr213"; //Cat's Grace
                break;
            case 5:
                sScrollResRef = "nw_it_spdvscr202"; //Charm Person or Animal
                break;
            case 6:
                sScrollResRef = "x2_it_sparscr206"; //Cloud of Bewilderment
                break;
            case 7:
                sScrollResRef = "x2_it_sparscr201"; //Combust
                break;
            case 8:
                sScrollResRef = "x1_it_spdvscr301"; //Continual Flame
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr206"; //Darkness
                break;
            case 10:
                sScrollResRef = "x2_it_sparscr202"; //Death Armor
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr219"; //Eagle's Splendor
                break;
            case 12:
                sScrollResRef = "nw_it_sparscr215"; //Endurance
                break;
            case 13:
                sScrollResRef = "x2_it_sparscr205"; //Flame Weapon
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr220"; //Fox's Cunning
                break;
            case 15:
                sScrollResRef = "x2_it_sparscr203"; //Gedlee's Electric Loop
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr208"; //Ghostly Visage
                break;
            case 17:
                sScrollResRef = "nw_it_sparscr209"; //Ghoul Touch
                break;
            case 18:
                sScrollResRef = "x2_it_spdvscr204"; //Hold Animal
                break;
            case 19:
                sScrollResRef = "nw_it_sparscr207"; //Invisibility
                break;
            case 20:
                sScrollResRef = "nw_it_sparscr216"; //Knock
                break;
            case 21:
                sScrollResRef = "nw_it_sparscr218"; //Lesser Dispel
                break;
            case 22:
                sScrollResRef = "nw_it_sparscr202"; //Melf's Acid Arrow
                break;
            case 23:
                sScrollResRef = "nw_it_sparscr221"; //Owl's Wisdom
                break;
            case 24:
                sScrollResRef = "x2_it_spdvscr205"; //Remove Paralysis
                break;
            case 25:
                sScrollResRef = "nw_it_sparscr201"; //Resist Elements
                break;
            case 26:
                sScrollResRef = "nw_it_sparscr205"; //See Invisibility
                break;
            case 27:
                sScrollResRef = "nw_it_spdvscr204"; //Sound Burst
                break;
            case 28:
                sScrollResRef = "x2_it_sparscr204"; //Stone Bones
                break;
            case 29:
                sScrollResRef = "nw_it_sparscr203"; //Summon Creature II
                break;
            case 30:
                sScrollResRef = "x1_it_sparscr202"; //Tasha's Hideous Laughter
                break;
            case 31:
                sScrollResRef = "nw_it_sparscr214"; //Ultravision
                break;
            case 32:
                sScrollResRef = "nw_it_sparscr204"; //Web
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel3(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 26)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "nw_it_sparscr307"; //Clairaudience/Clairvoyance
                break;
            case 2:
                sScrollResRef = "nw_it_sparscr217"; //Clarity
                break;
            case 3:
                sScrollResRef = "nw_it_sparscr301"; //Dispel Magic
                break;
            case 4:
                sScrollResRef = "x1_it_sparscr301"; //Displacement
                break;
            case 5:
                sScrollResRef = "x2_it_sparscr305"; //Find Traps
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr309"; //Fireball
                break;
            case 7:
                sScrollResRef = "nw_it_sparscr304"; //Flame Arrow
                break;
            case 8:
                sScrollResRef = "x2_it_sparscr304"; //Greater Magic Weapon
                break;
            case 9:
                sScrollResRef = "x1_it_sparscr303"; //Gust of Wind
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr312"; //Haste
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr308"; //Hold Person
                break;
            case 12:
                sScrollResRef = "x2_it_spdvscr310"; //Invisibility Purge
                break;
            case 13:
                sScrollResRef = "nw_it_sparscr314"; //Invisibility Sphere
                break;
            case 14:
                sScrollResRef = "x2_it_sparscr303"; //Keen Edge
                break;
            case 15:
                sScrollResRef = "nw_it_sparscr310"; //Lightning Bolt
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr302"; //Magic Circle Against Alignment
                break;
            case 17:
                sScrollResRef = "x2_it_sparscr301"; //Mestil's Acid Breath
                break;
            case 18:
                sScrollResRef = "nw_it_sparscr315"; //Negative Energy Burst
                break;
            case 19:
                sScrollResRef = "x2_it_spdvscr407"; //Poison
                break;
            case 20:
                sScrollResRef = "nw_it_sparscr303"; //Protection From Elements
                break;
            case 21:
                sScrollResRef = "x2_it_sparscr302"; //Scintillating Sphere
                break;
            case 22:
                sScrollResRef = "nw_it_sparscr313"; //Slow
                break;
            case 23:
                sScrollResRef = "nw_it_sparscr305"; //Stinking Cloud
                break;
            case 24:
                sScrollResRef = "nw_it_sparscr306"; //Summon Creature III
                break;
            case 25:
                sScrollResRef = "nw_it_sparscr311"; //Vampiric Touch
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel4(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 24)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "nw_it_sparscr414"; //Bestow Curse
                break;
            case 2:
                sScrollResRef = "x2_it_spdvscr307"; //Call Lightning
                break;
            case 3:
                sScrollResRef = "nw_it_sparscr405"; //Charm Monster
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr406"; //Confusion
                break;
            case 5:
                sScrollResRef = "nw_it_sparscr411"; //Contagion
                break;
            case 6:
                sScrollResRef = "x2_it_spdvscr309"; //Dominate Animal
                break;
            case 7:
                sScrollResRef = "nw_it_sparscr416"; //Elemental Shield
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr412"; //Enervation
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr418"; //Evard's Black Tentacles
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr413"; //Fear
                break;
            case 11:
                sScrollResRef = "x2_it_sparscr401"; //Ice Storm
                break;
            case 12:
                sScrollResRef = "nw_it_sparscr408"; //Improved Invisibility
                break;
            case 13:
                sScrollResRef = "x1_it_sparscr401"; //Isaac's Lesser Missile Storm
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr417"; //Lesser Spell Breach
                break;
            case 15:
                sScrollResRef = "nw_it_sparscr401"; //Minor Globe of Invulnerability
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr409"; //Phantasmal Killer
                break;
            case 17:
                sScrollResRef = "nw_it_sparscr415"; //Polymorph Self
                break;
            case 18:
                sScrollResRef = "nw_it_spdvscr301"; //Remove Blindness/Deafness
                break;
            case 19:
                sScrollResRef = "nw_it_sparscr402"; //Remove Curse
                break;
            case 20:
                sScrollResRef = "nw_it_sparscr410"; //Shadow Conjuration
                break;
            case 21:
                sScrollResRef = "nw_it_sparscr403"; //Stoneskin
                break;
            case 22:
                sScrollResRef = "nw_it_sparscr404"; //Summon Creature IV
                break;
            case 23:
                sScrollResRef = "nw_it_sparscr407"; //Wall of Fire
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel5(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 20)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "nw_it_sparscr509"; //Animate Dead
                break;
            case 2:
                sScrollResRef = "x2_it_sparscr501"; //Ball Lightning
                break;
            case 3:
                sScrollResRef = "x1_it_sparscr502"; //Bigby's Interposing Hand
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr502"; //Cloudkill
                break;
            case 5:
                sScrollResRef = "nw_it_sparscr507"; //Cone of Cold
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr501"; //Dismissal
                break;
            case 7:
                sScrollResRef = "nw_it_sparscr503"; //Dominate Person
                break;
            case 8:
                sScrollResRef = "x2_it_sparscr503"; //Energy Buffer
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr504"; //Feeblemind
                break;
            case 10:
                sScrollResRef = "x1_it_sparscr501"; //Firebrand
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr508"; //Greater Shadow Conjuration
                break;
            case 12:
                sScrollResRef = "nw_it_sparscr505"; //Hold Monster
                break;
            case 13:
                sScrollResRef = "x1_it_spdvscr501"; //Inferno
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr511"; //Lesser Mind Blank
                break;
            case 15:
                sScrollResRef = "nw_it_sparscr512"; //Lesser Planar Binding
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr513"; //Lesser Spell Mantle
                break;
            case 17:
                sScrollResRef = "x2_it_sparscr502"; //Mestil's Acid Sheath
                break;
            case 18:
                sScrollResRef = "nw_it_sparscr506"; //Mind Fog
                break;
            case 19:
                sScrollResRef = "nw_it_sparscr510"; //Summon Creature V
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel6(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 22)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "nw_it_sparscr603"; //Acid Fog
                break;
            case 2:
                sScrollResRef = "x1_it_sparscr602"; //Bigby's Forceful Hand
                break;
            case 3:
                sScrollResRef = "nw_it_sparscr607"; //Chain Lightning
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr610"; //Circle of Death
                break;
            case 5:
                sScrollResRef = "nw_it_sparscr608"; //Ethereal Visage
                break;
            case 6:
                sScrollResRef = "x2_it_spdvscr509"; //Evil Blight
                break;
            case 7:
                sScrollResRef = "x1_it_sparscr605"; //Flesh to Stone
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr601"; //Globe of Invulnerability
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr602"; //Greater Dispelling
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr612"; //Greater Spell Breach
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr613"; //Greater Stoneskin
                break;
            case 12:
                sScrollResRef = "x1_it_sparscr603"; //Isaac's Greater Missile Storm
                break;
            case 13:
                sScrollResRef = "x2_it_sparscr602"; //Legend Lore
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr611"; //Mass Haste
                break;
            case 15:
                sScrollResRef = "nw_it_sparscr604"; //Planar Binding
                break;
            case 16:
                sScrollResRef = "nw_it_sparscr609"; //Shades
                break;
            case 17:
                sScrollResRef = "x1_it_sparscr604"; //Stone to Flesh
                break;
            case 18:
                sScrollResRef = "nw_it_sparscr605"; //Summon Creature VI
                break;
            case 19:
                sScrollResRef = "nw_it_sparscr614"; //Tenser's Transformation
                break;
            case 20:
                sScrollResRef = "nw_it_sparscr606"; //True Seeing
                break;
            case 21:
                sScrollResRef = "x2_it_sparscr601"; //Undeath to Death
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel7(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 15)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "x1_it_spdvscr601"; //Banishment
                break;
            case 2:
                sScrollResRef = "x1_it_sparscr701"; //Bigby's Grasphing Hand
                break;
            case 3:
                sScrollResRef = "x2_it_spdvscr603"; //Blade Barrier
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr707"; //Control Undead
                break;
            case 5:
                sScrollResRef = "nw_it_sparscr704"; //Delayed Blast Fireball
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr708"; //Finger of Death
                break;
            case 7:
                sScrollResRef = "x2_it_sparscr701"; //Great Thunderclap
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr705"; //Mordenkainen's Sword
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr702"; //Power Word, Stun
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr706"; //Prismatic Spray
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr802"; //Protection From Spells
                break;
            case 12:
                sScrollResRef = "x2_it_sparscr703"; //Shadow Shield
                break;
            case 13:
                sScrollResRef = "nw_it_sparscr701"; //Spell Mantle
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr703"; //Summon Creature VII
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel8(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 14)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "x1_it_sparscr801"; //Bigby's Clenched Fist
                break;
            case 2:
                sScrollResRef = "x2_it_sparscr801"; //Blackstaff
                break;
            case 3:
                sScrollResRef = "x1_it_spdvscr605"; //Create Undead
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr803"; //Greater Planar Binding
                break;
            case 5:
                sScrollResRef = "x2_it_spdvscr606"; //Greater Sanctuary
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr809"; //Horrid Wilting
                break;
            case 7:
                sScrollResRef = "nw_it_sparscr804"; //Incendiary Cloud
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr807"; //Mass Blindness/Deafness
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr806"; //Mass Charm
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr801"; //Mind Blank
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr808"; //Premonition
                break;
            case 12:
                sScrollResRef = "nw_it_sparscr805"; //Summon Creature VIII
                break;
            case 13:
                sScrollResRef = "x1_it_spdvscr802"; //Sunburst
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

void SpawnScrollsLevel9(object oContainer)
{
    object oScroll;
    int i = 1;
    string sScrollResRef;

    SetLocalInt(oContainer, "SCROLLS_SPAWNED", 1);
    SetPlotFlag(oContainer, TRUE);

    while(i < 16)
    {
        switch(i)
        {
            case 1:
                sScrollResRef = "x1_it_sparscr901"; //Bigby's Crushing Hand
                break;
            case 2:
                sScrollResRef = "x2_it_sparscr901"; //Black Blade of Disaster
                break;
            case 3:
                sScrollResRef = "x1_it_spdvscr804"; //Create Greater Undead
                break;
            case 4:
                sScrollResRef = "nw_it_sparscr905"; //Dominate Monster
                break;
            case 5:
                sScrollResRef = "nw_it_sparscr908"; //Energy Drain
                break;
            case 6:
                sScrollResRef = "nw_it_sparscr902"; //Gate
                break;
            case 7:
                sScrollResRef = "nw_it_sparscr912"; //Greater Spell Mantle
                break;
            case 8:
                sScrollResRef = "nw_it_sparscr906"; //Meteor Swarm
                break;
            case 9:
                sScrollResRef = "nw_it_sparscr901"; //Mordenkainen's Disjunction
                break;
            case 10:
                sScrollResRef = "nw_it_sparscr903"; //Power Word, Kill
                break;
            case 11:
                sScrollResRef = "nw_it_sparscr910"; //Shapechange
                break;
            case 12:
                sScrollResRef = "nw_it_sparscr904"; //Summon Creature IX
                break;
            case 13:
                sScrollResRef = "nw_it_sparscr911"; //Timestop
                break;
            case 14:
                sScrollResRef = "nw_it_sparscr909"; //Wail of the Banshee
                break;
            case 15:
                sScrollResRef = "nw_it_sparscr907"; //Weird
                break;
        }
        oScroll = CreateItemOnObject(sScrollResRef, oContainer);
        SetIdentified(oScroll, TRUE);
        i++;
    }
}

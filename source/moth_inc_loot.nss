//'''''''''''''****************************'''''''''''''''''
//------------ Moth's Random Loot Scriptset ----------------
//'''''''''''''____________________________'''''''''''''''''
//Makes a random item and places it in the inventory of sTag.
//For using chest-pools, the Tags are as follow:
//Low: X0_MOD_TREASURE_LOW
//Medium: X0_MOD_TREASURE_MED
//High: X0_MOD_TREASURE_HIGH
//Epic: X0_MOD_TREASURE_UNIQ
//Make sure there are no more than 20 pages already in the container.
//Activate the different "Make*" to create the different types of items.
//Created for AnphilliaGenesis and should only be used on OnModuleLoad.
void MothRandomLootSystem();

// Random Name
// Made seperate for fast and easy modification/addition
void MothRandomItemNameAndDescription(object oItem,
                                       string sBaseType,
                                       string sBaseName,
                                       string sPrefix)
{
   string sItemRandomTwo;
   string sItemRandomThree;
   string sItemNewName;
   string sDescription;
   int nRandNameTwo = Random(30)+1;
   int nRandNameThree = Random(30)+1;
   switch (nRandNameTwo)
   {
        case 1:
            sItemRandomTwo = "Perfect ";
        break;
        case 2:
            sItemRandomTwo = "Mighty ";
        break;
        case 3:
            sItemRandomTwo = "Ultimate ";
        break;
        case 4:
            sItemRandomTwo = "Harden ";
        break;
        case 5:
            sItemRandomTwo = "Everlasting ";
        break;
        case 6:
            sItemRandomTwo = "Sleepless ";
        break;
        case 7:
            sItemRandomTwo = "Valiant ";
        break;
        case 8:
            sItemRandomTwo = "Drunk ";
        break;
        case 9:
            sItemRandomTwo = "Old ";
        break;
        case 10:
            sItemRandomTwo = "Strong ";
        break;
        case 11:
            sItemRandomTwo = "Weak ";
        break;
        case 12:
            sItemRandomTwo = "Determand ";
        break;
        case 13:
            sItemRandomTwo = "Pious ";
        break;
        case 14:
            sItemRandomTwo = "Reckless ";
        break;
        case 15:
            sItemRandomTwo = "Devoted ";
        break;
        case 16:
            sItemRandomTwo = "Watching ";
        break;
        case 17:
            sItemRandomTwo = "Endless ";
        break;
        case 18:
            sItemRandomTwo = "Deep ";
        break;
        case 19:
            sItemRandomTwo = "Thrusting ";
        break;
        case 20:
            sItemRandomTwo = "Raging ";
        break;
        case 21:
            sItemRandomTwo = "Sleeping ";
        break;
        case 22:
            sItemRandomTwo = "Rolling ";
        break;
        case 23:
            sItemRandomTwo = "New ";
        break;
        case 24:
            sItemRandomTwo = "Eternal ";
        break;
        case 25:
            sItemRandomTwo = "Wicked ";
        break;
        case 26:
            sItemRandomTwo = "Tempting ";
        break;
        case 27:
            sItemRandomTwo = "Luring ";
        break;
        case 28:
            sItemRandomTwo = "Moving ";
        break;
        case 29:
            sItemRandomTwo = "Fleeing ";
        break;
        case 30:
            sItemRandomTwo = "Deprived ";
        break;

   }
   switch (nRandNameThree)
   {
        case 1:
            sItemRandomThree = "Warrior";
        break;
        case 2:
            sItemRandomThree = "Priest";
        break;
        case 3:
            sItemRandomThree = "Champion";
        break;
        case 4:
            sItemRandomThree = "Nightelf";
        break;
        case 5:
            sItemRandomThree = "Talon";
        break;
        case 6:
            sItemRandomThree = "Rumbler";
        break;
        case 7:
            sItemRandomThree = "Smiter";
        break;
        case 8:
            sItemRandomThree = "Dancer";
        break;
        case 9:
            sItemRandomThree = "General";
        break;
        case 10:
            sItemRandomThree = "Fleeter";
        break;
        case 11:
            sItemRandomThree = "Runner";
        break;
        case 12:
            sItemRandomThree = "Mocker";
        break;
        case 13:
            sItemRandomThree = "Jester";
        break;
        case 14:
            sItemRandomThree = "Guard";
        break;
        case 15:
            sItemRandomThree = "Rumbler";
        break;
        case 16:
            sItemRandomThree = "Watcher";
        break;
        case 17:
            sItemRandomThree = "Enigma";
        break;
        case 18:
            sItemRandomThree = "Hook";
        break;
        case 19:
            sItemRandomThree = "Rammer";
        break;
        case 20:
            sItemRandomThree = "Grunt";
        break;
        case 21:
            sItemRandomThree = "Shopkeeper";
        break;
        case 22:
            sItemRandomThree = "Truster";
        break;
        case 23:
            sItemRandomThree = "Miner";
        break;
        case 24:
            sItemRandomThree = "Zealot";
        break;
        case 25:
            sItemRandomThree = "Preacher";
        break;
        case 26:
            sItemRandomThree = "Woodelf";
        break;
        case 27:
            sItemRandomThree = "Drow";
        break;
        case 28:
            sItemRandomThree = "Halfling";
        break;
        case 29:
            sItemRandomThree = "Singer";
        break;
        case 30:
            sItemRandomThree = "Zodiac";
        break;
   }
   sItemNewName = sBaseName+sPrefix+sItemRandomTwo+sItemRandomThree;
   SetIdentified(oItem,TRUE);
   sDescription = ""+sItemNewName+" is "+sBaseType+" of an unknown origin.";
   SetName(oItem,sItemNewName);
   SetDescription(oItem,sDescription);
   DelayCommand(1.0,SetIdentified(oItem,FALSE));
}


//----------------------------------------------------------
// AMULET
//----------------------------------------------------------
//Makes random low-loot necklaces.
void MothRandomItemLowAmulet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseAmulet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique amulet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddResistance;
   itemproperty ipAddSave;
   itemproperty ipAddImmunity;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nResistance;
   int nResistanceHP;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nImmunity;
   int nSkill;
   int nSkillBonus;
   //Make Base Amulet
   oItemBaseAmulet = CreateItemOnObject("nw_it_mneck022",oChest,1);
   //Local Switches
   int nItemBase = Random(2)+1;
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomResistance = Random(10)+1;
   int nRandomResistanceHP = Random(3)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomImmunity = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Amulet of ";;
        break;
        case 2:
          sItemBase = "Necklace of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_SET_TRAP;
        break;
   }
   switch (nRandomResistanceHP)
   {
        case 1:
            nResistance = IP_CONST_DAMAGERESIST_5;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGERESIST_5;
        break;
   }
   switch (nRandomResistance)
   {
        case 1:
            nResistance = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 3:
            nResistance = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nResistance = IP_CONST_DAMAGETYPE_DIVINE;
        break;
        case 5:
            nResistance = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;
        case 7:
            nResistance = IP_CONST_DAMAGETYPE_SLASHING;
        break;
        case 8:
            nResistance = IP_CONST_DAMAGETYPE_SONIC;
        break;
        case 9:
            nResistance = IP_CONST_DAMAGETYPE_PIERCING;
        break;
        case 10:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 1;
        break;
        case 2:
            nBaseSaveTypeBonus = 1;
        break;
        case 3:
            nBaseSaveTypeBonus = 2;
        break;
        case 4:
            nBaseSaveTypeBonus = 2;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomImmunity)
   {
        case 1:
            nImmunity = IP_CONST_IMMUNITYMISC_FEAR;
        break;
        case 2:
            nImmunity = IP_CONST_IMMUNITYMISC_PARALYSIS;
        break;
        case 3:
            nImmunity = IP_CONST_IMMUNITYMISC_POISON;
        break;
        case 4:
            nImmunity = IP_CONST_IMMUNITYMISC_DISEASE;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddResistance = ItemPropertyDamageResistance(nResistance,nResistanceHP);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddImmunity = ItemPropertyImmunityMisc(nImmunity);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ammy
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddResistance,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddImmunity,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseAmulet);
   MothRandomItemNameAndDescription(oItemBaseAmulet,sBaseType,sItemBase,sPrefix);
}

//Makes random medium-loot necklaces.
void MothRandomItemMediumAmulet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseAmulet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique amulet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddResistance;
   itemproperty ipAddSave;
   itemproperty ipAddImmunity;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nResistance;
   int nResistanceHP;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nImmunity;
   int nSkill;
   int nSkillBonus;
   //Make Base Amulet
   oItemBaseAmulet = CreateItemOnObject("nw_it_mneck022",oChest,1);
   //Local Switches
   int nItemBase = Random(2)+1;
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomResistance = Random(10)+1;
   int nRandomResistanceHP = Random(3)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomImmunity = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Amulet of ";;
        break;
        case 2:
          sItemBase = "Necklace of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_SET_TRAP;
        break;
   }
   switch (nRandomResistanceHP)
   {
        case 1:
            nResistance = IP_CONST_DAMAGERESIST_5;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGERESIST_10;
        break;
   }
   switch (nRandomResistance)
   {
        case 1:
            nResistance = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 3:
            nResistance = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nResistance = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 5:
            nResistance = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;
        case 7:
            nResistance = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 8:
            nResistance = IP_CONST_DAMAGETYPE_SONIC;
        break;
        case 9:
            nResistance = IP_CONST_DAMAGETYPE_SONIC;
        break;
        case 10:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 4;
        break;
        case 2:
            nBaseSaveTypeBonus = 4;
        break;
        case 3:
            nBaseSaveTypeBonus = 2;
        break;
        case 4:
            nBaseSaveTypeBonus = 2;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomImmunity)
   {
        case 1:
            nImmunity = IP_CONST_IMMUNITYMISC_FEAR;
        break;
        case 2:
            nImmunity = IP_CONST_IMMUNITYMISC_PARALYSIS;
        break;
        case 3:
            nImmunity = IP_CONST_IMMUNITYMISC_POISON;
        break;
        case 4:
            nImmunity = IP_CONST_IMMUNITYMISC_DISEASE;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddResistance = ItemPropertyDamageResistance(nResistance,nResistanceHP);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddImmunity = ItemPropertyImmunityMisc(nImmunity);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ammy
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddResistance,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddImmunity,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseAmulet);
   MothRandomItemNameAndDescription(oItemBaseAmulet,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot necklaces.
void MothRandomItemHighAmulet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseAmulet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique amulet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddResistance;
   itemproperty ipAddSave;
   itemproperty ipAddImmunity;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nResistance;
   int nResistanceHP;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nImmunity;
   int nSkill;
   int nSkillBonus;
   //Make Base Amulet
   oItemBaseAmulet = CreateItemOnObject("nw_it_mneck022",oChest,1);
   //Local Switches
   int nItemBase = Random(2)+1;
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomResistance = Random(10)+1;
   int nRandomResistanceHP = Random(3)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomImmunity = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Amulet of ";;
        break;
        case 2:
          sItemBase = "Necklace of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_SET_TRAP;
        break;
   }
   switch (nRandomResistanceHP)
   {
        case 1:
            nResistance = IP_CONST_DAMAGERESIST_15;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGERESIST_10;
        break;
   }
   switch (nRandomResistance)
   {
        case 1:
            nResistance = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nResistance = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 3:
            nResistance = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nResistance = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 5:
            nResistance = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;
        case 7:
            nResistance = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 8:
            nResistance = IP_CONST_DAMAGETYPE_SONIC;
        break;
        case 9:
            nResistance = IP_CONST_DAMAGETYPE_SONIC;
        break;
        case 10:
            nResistance = IP_CONST_DAMAGETYPE_FIRE;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 4;
        break;
        case 2:
            nBaseSaveTypeBonus = 4;
        break;
        case 3:
            nBaseSaveTypeBonus = 5;
        break;
        case 4:
            nBaseSaveTypeBonus = 5;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomImmunity)
   {
        case 1:
            nImmunity = IP_CONST_IMMUNITYMISC_FEAR;
        break;
        case 2:
            nImmunity = IP_CONST_IMMUNITYMISC_PARALYSIS;
        break;
        case 3:
            nImmunity = IP_CONST_IMMUNITYMISC_POISON;
        break;
        case 4:
            nImmunity = IP_CONST_IMMUNITYMISC_DISEASE;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddResistance = ItemPropertyDamageResistance(nResistance,nResistanceHP);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddImmunity = ItemPropertyImmunityMisc(nImmunity);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ammy
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddResistance,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddImmunity,oItemBaseAmulet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseAmulet);
   MothRandomItemNameAndDescription(oItemBaseAmulet,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// ARMOR
//----------------------------------------------------------
//Makes random low-loot Armor.
void MothRandomItemLowArmor(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseArmor;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique armor";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddWeight;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nWeight;
   //Make Base Armor of a random type
   int nRandomArmor = Random(10)+1;
   switch (nRandomArmor)
   {
        case 1:
          oItemBaseArmor = CreateItemOnObject("nw_cloth004",oChest,1);
        break;
        case 2:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl001",oChest,1);
        break;
        case 3:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl003",oChest,1);
        break;
        case 4:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl007",oChest,1);
        break;
        case 5:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl006",oChest,1);
        break;
        case 6:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl005",oChest,1);
        break;
        case 7:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl012",oChest,1);
        break;
        case 8:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl010",oChest,1);
        break;
        case 9:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl004",oChest,1);
        break;
        case 10:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl008",oChest,1);
        break;
   }
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomWeight = Random(6)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Armor of ";
        break;
        case 2:
          sItemBase = "Chest of ";
        break;
   }
   if(nRandomArmor==1)
   {
       switch (nItemBase)
       {
            case 1:
              sItemBase = "Robe of ";
            break;
            case 2:
              sItemBase = "Vest of ";
            break;
       }
       sBaseType = "a unique robe";
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomWeight)
   {
        case 1:
            nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
        break;
        case 2:
            nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
        break;
        case 3:
            nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
        break;
        case 4:
            nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
        break;
        case 5:
            nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
        break;
        case 6:
            nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 1;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_1D6;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_1D6;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddWeight = ItemPropertyWeightReduction(nWeight);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseArmor);
   if(nRandomArmor>1)
   {
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oItemBaseArmor);
   }
   MothRandomItemNameAndDescription(oItemBaseArmor,sBaseType,sItemBase,sPrefix);
}


//Makes random medium-loot Armor.
void MothRandomItemMediumArmor(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseArmor;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique armor";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddWeight;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nWeight;
   //Make Base Armor of a random type
   int nRandomArmor = Random(10)+1;
   switch (nRandomArmor)
   {
        case 1:
          oItemBaseArmor = CreateItemOnObject("nw_cloth004",oChest,1);
        break;
        case 2:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl001",oChest,1);
        break;
        case 3:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl003",oChest,1);
        break;
        case 4:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl007",oChest,1);
        break;
        case 5:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl006",oChest,1);
        break;
        case 6:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl005",oChest,1);
        break;
        case 7:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl012",oChest,1);
        break;
        case 8:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl010",oChest,1);
        break;
        case 9:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl004",oChest,1);
        break;
        case 10:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl008",oChest,1);
        break;
   }
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomWeight = Random(6)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Armor of ";
        break;
        case 2:
          sItemBase = "Chest of ";
        break;
   }
   if(nRandomArmor==1)
   {
       switch (nItemBase)
       {
            case 1:
              sItemBase = "Robe of ";
            break;
            case 2:
              sItemBase = "Vest of ";
            break;
       }
       sBaseType = "a unique robe";
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomWeight)
   {
        case 1:
            nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
        break;
        case 2:
            nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
        break;
        case 3:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
        case 4:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
        case 5:
            nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
        break;
        case 6:
            nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 2;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_2D6;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_1D6;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddWeight = ItemPropertyWeightReduction(nWeight);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseArmor);
   if(nRandomArmor>1)
   {
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oItemBaseArmor);
   }
   MothRandomItemNameAndDescription(oItemBaseArmor,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot Armor.
void MothRandomItemHighArmor(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseArmor;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique armor";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddWeight;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nWeight;
   //Make Base Armor of a random type
   int nRandomArmor = Random(10)+1;
   switch (nRandomArmor)
   {
        case 1:
          oItemBaseArmor = CreateItemOnObject("nw_cloth004",oChest,1);
        break;
        case 2:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl001",oChest,1);
        break;
        case 3:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl003",oChest,1);
        break;
        case 4:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl007",oChest,1);
        break;
        case 5:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl006",oChest,1);
        break;
        case 6:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl005",oChest,1);
        break;
        case 7:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl012",oChest,1);
        break;
        case 8:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl010",oChest,1);
        break;
        case 9:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl004",oChest,1);
        break;
        case 10:
          oItemBaseArmor = CreateItemOnObject("nw_aarcl008",oChest,1);
        break;
   }
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomWeight = Random(6)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Armor of ";
        break;
        case 2:
          sItemBase = "Chest of ";
        break;
   }
   if(nRandomArmor==1)
   {
       switch (nItemBase)
       {
            case 1:
              sItemBase = "Robe of ";
            break;
            case 2:
              sItemBase = "Vest of ";
            break;
       }
       sBaseType = "a unique robe";
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 10;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomWeight)
   {
        case 1:
            nWeight = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
        break;
        case 2:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
        case 3:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
        case 4:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
        case 5:
            nWeight = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
        break;
        case 6:
            nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 2;
        break;
        case 2:
            nBaseRegen = 3;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_2D6;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_3D6;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddWeight = ItemPropertyWeightReduction(nWeight);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseArmor);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseArmor);
   if(nRandomArmor>1)
   {
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oItemBaseArmor);
   }
   MothRandomItemNameAndDescription(oItemBaseArmor,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// BELT
//----------------------------------------------------------
//Makes random low-loot Belts.
void MothRandomItemLowBelt(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBelt;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique belt";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSkill;
   int nSkillBonus;
   //Make Base Belt
   oItemBaseBelt = CreateItemOnObject("leatherbelt",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Belt of ";;
        break;
        case 2:
          sItemBase = "Bucket of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   itemproperty ipAddRegen = ItemPropertyRegeneration(1);
   //Finalize the Belt
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseBelt);
   MothRandomItemNameAndDescription(oItemBaseBelt,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Belts.
void MothRandomItemMediumBelt(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBelt;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique belt";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSkill;
   int nSkillBonus;
   //Make Base Belt
   oItemBaseBelt = CreateItemOnObject("leatherbelt",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Belt of ";;
        break;
        case 2:
          sItemBase = "Bucket of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_HIDE;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 3;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 2;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   itemproperty ipAddRegen = ItemPropertyRegeneration(1);
   //Finalize the Belt
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseBelt);
   MothRandomItemNameAndDescription(oItemBaseBelt,sBaseType,sItemBase,sPrefix);
}

//Makes random High-loot Belts.
void MothRandomItemHighBelt(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBelt;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique belt";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSkill;
   int nSkillBonus;
   //Make Base Belt
   oItemBaseBelt = CreateItemOnObject("leatherbelt",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Belt of ";;
        break;
        case 2:
          sItemBase = "Bucket of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 10;
        break;
        case 5:
            nSkillBonus = 11;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_HIDE;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   itemproperty ipAddRegen = ItemPropertyRegeneration(1);
   //Finalize the Belt
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBelt);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseBelt);
   MothRandomItemNameAndDescription(oItemBaseBelt,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// BOOTS
//----------------------------------------------------------
//Makes random low-loot Boots.
void MothRandomItemLowBoots(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBoots;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of boots";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Boots
   oItemBaseBoots = CreateItemOnObject("leatherboots",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(20)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Boots of ";;
        break;
        case 2:
          sItemBase = "Footwear of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_BLESS_2;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_AID_3;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_FOXS_CUNNING_15;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_BULLS_STRENGTH_15;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_FIND_TRAPS_3;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CATS_GRACE_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_DEATH_WARD_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_OWLS_WISDOM_15;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_ENDURANCE_15;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 1;
        break;
        case 2:
            nBaseSaveTypeBonus = 1;
        break;
        case 3:
            nBaseSaveTypeBonus = 2;
        break;
        case 4:
            nBaseSaveTypeBonus = 2;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBoots);
   MothRandomItemNameAndDescription(oItemBaseBoots,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Boots.
void MothRandomItemMediumBoots(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBoots;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of boots";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Boots
   oItemBaseBoots = CreateItemOnObject("leatherboots",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(20)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(14)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Boots of ";;
        break;
        case 2:
          sItemBase = "Footwear of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 4;
        break;
        case 2:
            nSkillBonus = 5;
        break;
        case 3:
            nSkillBonus = 6;
        break;
        case 4:
            nSkillBonus = 7;
        break;
        case 5:
            nSkillBonus = 8;
        break;
        case 6:
            nSkillBonus = 9;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
        case 13:
            nSkill = SKILL_HIDE;
        break;
        case 14:
            nSkill = SKILL_PARRY;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_AURA_OF_VITALITY_13;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_FOXS_CUNNING_15;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_BULLS_STRENGTH_15;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_ETHEREAL_VISAGE_9;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CATS_GRACE_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_OWLS_WISDOM_15;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_ENDURANCE_15;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 2;
        break;
        case 2:
            nBaseSaveTypeBonus = 2;
        break;
        case 3:
            nBaseSaveTypeBonus = 4;
        break;
        case 4:
            nBaseSaveTypeBonus = 4;
        break;
        case 5:
            nBaseSaveTypeBonus = 5;
        break;
        case 6:
            nBaseSaveTypeBonus = 5;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_ARMOR_PROF_HEAVY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_ARMOR_PROF_LIGHT;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_ARMOR_PROF_MEDIUM;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_CLEAVE;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_DISARM;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_EXTRA_TURNING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_RAPID_SHOT;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_SHIELD_PROFICIENCY;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_WHIRLWIND;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 3;
        break;
        case 2:
            nAC = 4;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 2;
        break;
        case 2:
            nAbilityBonus = 3;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBoots);
   MothRandomItemNameAndDescription(oItemBaseBoots,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot Boots.
void MothRandomItemHighBoots(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBoots;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of boots";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Boots
   oItemBaseBoots = CreateItemOnObject("leatherboots",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(20)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(14)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Boots of ";;
        break;
        case 2:
          sItemBase = "Footwear of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 6;
        break;
        case 2:
            nSkillBonus = 7;
        break;
        case 3:
            nSkillBonus = 7;
        break;
        case 4:
            nSkillBonus = 8;
        break;
        case 5:
            nSkillBonus = 8;
        break;
        case 6:
            nSkillBonus = 9;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PARRY;
        break;
        case 13:
            nSkill = SKILL_HIDE;
        break;
        case 14:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_AURA_OF_VITALITY_13;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_FOXS_CUNNING_15;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_BULLS_STRENGTH_15;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_HEAL_11;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SHADOW_SHIELD_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CATS_GRACE_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_OWLS_WISDOM_15;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_TRUE_STRIKE_5;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_GUST_OF_WIND_10;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_ENDURANCE_15;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_GREATER_STONESKIN_11;
        break;

   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 4;
        break;
        case 2:
            nBaseSaveTypeBonus = 4;
        break;
        case 3:
            nBaseSaveTypeBonus = 5;
        break;
        case 4:
            nBaseSaveTypeBonus = 5;
        break;
        case 5:
            nBaseSaveTypeBonus = 6;
        break;
        case 6:
            nBaseSaveTypeBonus = 6;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_RAPID_SHOT;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_CLEAVE;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_DISARM;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_EXTRA_TURNING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_WEAPON_PROF_EXOTIC;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_USE_POISON;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_2D6;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_WHIRLWIND;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_SNEAK_ATTACK_3D6;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   if(nRandomSpell == 11)
   {
   nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
   itemproperty ipClass1 = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
   itemproperty ipClass2= ItemPropertyLimitUseByClass(IP_CONST_CLASS_DRUID);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipClass1,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipClass2,oItemBaseBoots);
   }
   if(nRandomSpell == 12)
   {
   nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
   itemproperty ipClass1 = ItemPropertyLimitUseByClass(IP_CONST_CLASS_SORCERER);
   itemproperty ipClass2 = ItemPropertyLimitUseByClass(IP_CONST_CLASS_WIZARD);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipClass1,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipClass2,oItemBaseBoots);
   }
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Boots
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBoots);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBoots);
   MothRandomItemNameAndDescription(oItemBaseBoots,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// BRACERS
//----------------------------------------------------------
//Makes random low-loot Bracers.
void MothRandomItemLowBracers(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBracers;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of bracers";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Bracers
   oItemBaseBracers = CreateItemOnObject("nw_it_mbracer001",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Bracers of ";;
        break;
        case 2:
          sItemBase = "Gauntlets of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_AWAKEN_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BESTOW_CURSE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLESS_2;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_20;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CLARITY_3;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_15;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CONFUSION_10;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_CONTINUAL_FLAME_7;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_CREATE_UNDEAD_16;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_DEATH_WARD_7;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_20;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_DESTRUCTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_DIRGE_15;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_DISMISSAL_18;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_DIVINE_POWER_7;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_DROWN_15;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_EARTHQUAKE_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17;
        break;
   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 1;
        break;
        case 2:
            nBaseSaveTypeBonus = 1;
        break;
        case 3:
            nBaseSaveTypeBonus = 2;
        break;
        case 4:
            nBaseSaveTypeBonus = 2;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Bracers
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBracers);
   MothRandomItemNameAndDescription(oItemBaseBracers,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Bracers.
void MothRandomItemMediumBracers(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBracers;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of bracers";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Bracers
   oItemBaseBracers = CreateItemOnObject("nw_it_mbracer001",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Bracers of ";;
        break;
        case 2:
          sItemBase = "Gauntlets of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_AWAKEN_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BESTOW_CURSE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLESS_2;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_20;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CLARITY_3;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_15;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CONFUSION_10;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_CONTINUAL_FLAME_7;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_CREATE_UNDEAD_16;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_DEATH_WARD_7;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_20;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_DESTRUCTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_DIRGE_15;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_DISMISSAL_18;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_DIVINE_POWER_7;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_DROWN_15;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_EARTHQUAKE_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17;
        break;
   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 4;
        break;
        case 2:
            nBaseSaveTypeBonus = 4;
        break;
        case 3:
            nBaseSaveTypeBonus = 2;
        break;
        case 4:
            nBaseSaveTypeBonus = 2;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Bracers
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBracers);
   MothRandomItemNameAndDescription(oItemBaseBracers,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot Bracers.
void MothRandomItemHighBracers(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseBracers;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique pair of bracers";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSave;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nBaseSaveType;
   int nBaseSaveTypeBonus;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Bracers
   oItemBaseBracers = CreateItemOnObject("nw_it_mbracer001",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomBaseSaveType = Random(3)+1;
   int nRandomBaseSaveTypeBonus = Random(6)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Bracers of ";;
        break;
        case 2:
          sItemBase = "Gauntlets of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_AWAKEN_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_BANISHMENT_15;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_12;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_BESTOW_CURSE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLESS_2;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_20;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CLARITY_3;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_15;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CONFUSION_10;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_CONTINUAL_FLAME_7;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_CREATE_UNDEAD_16;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_DEATH_WARD_7;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_20;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_DESTRUCTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_DIRGE_15;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_DISMISSAL_18;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_DISPLACEMENT_9;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_DIVINE_POWER_7;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_DROWN_15;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_EARTHQUAKE_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17;
        break;
   }
   switch (nRandomBaseSaveTypeBonus)
   {
        case 1:
            nBaseSaveTypeBonus = 4;
        break;
        case 2:
            nBaseSaveTypeBonus = 4;
        break;
        case 3:
            nBaseSaveTypeBonus = 5;
        break;
        case 4:
            nBaseSaveTypeBonus = 5;
        break;
        case 5:
            nBaseSaveTypeBonus = 3;
        break;
        case 6:
            nBaseSaveTypeBonus = 3;
        break;
   }
   switch (nRandomBaseSaveType)
   {
        case 1:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nBaseSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 5;
        break;
        case 2:
            nAC = 4;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSave = ItemPropertyBonusSavingThrow(nBaseSaveType,nBaseSaveTypeBonus);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Bracers
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseBracers);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseBracers);
   MothRandomItemNameAndDescription(oItemBaseBracers,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// CLOAKS
//----------------------------------------------------------
//Makes random low-loot Cloaks.
void MothRandomItemLowCloak(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseCloak;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique cloak";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseCloak = CreateItemOnObject("x0_maarcl025",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Cloak of ";;
        break;
        case 2:
          sItemBase = "Cape of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_WORD_OF_FAITH_13;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_WALL_OF_FIRE_9;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_SUNBURST_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_SUNBEAM_13;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_SPIKE_GROWTH_9;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_SLAY_LIVING_9;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Cloaks
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseCloak);
   MothRandomItemNameAndDescription(oItemBaseCloak,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Cloaks.
void MothRandomItemMediumCloak(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseCloak;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique cloak";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseCloak = CreateItemOnObject("x0_maarcl025",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Cloak of ";;
        break;
        case 2:
          sItemBase = "Cape of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_WORD_OF_FAITH_13;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_WALL_OF_FIRE_9;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_SUNBURST_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_SUNBEAM_13;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_SPIKE_GROWTH_9;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_SLAY_LIVING_9;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Cloaks
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseCloak);
   MothRandomItemNameAndDescription(oItemBaseCloak,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot Cloaks.
void MothRandomItemHighCloak(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseCloak;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique cloak";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseCloak = CreateItemOnObject("x0_maarcl025",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Cloak of ";;
        break;
        case 2:
          sItemBase = "Cape of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
        case 10:
            nSkill = SKILL_HIDE;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_DISABLE_TRAP;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_WORD_OF_FAITH_13;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_WALL_OF_FIRE_9;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_SUNBURST_20;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_SUNBEAM_13;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_SPIKE_GROWTH_9;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_SLAY_LIVING_9;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 4;
        break;
        case 2:
            nAbilityBonus = 3;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Cloaks
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseCloak);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseCloak);
   MothRandomItemNameAndDescription(oItemBaseCloak,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// HELMET
//----------------------------------------------------------
//Makes random low-loot Helmet.
void MothRandomItemLowHelmet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseHelmet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique helmet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddRace;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nRace;
   int nRaceAC;
   oItemBaseHelmet = CreateItemOnObject("x2_it_arhelm03",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomRaceAC = Random(6)+1;
   int nRandomRace = Random(11)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Helmet of ";
        break;
        case 2:
          sItemBase = "Hood of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomRaceAC)
   {
        case 1:
            nRaceAC = 1;
        break;
        case 2:
            nRaceAC = 2;
        break;
        case 3:
            nRaceAC = 3;
        break;
        case 4:
            nRaceAC = 4;
        break;
        case 5:
            nRaceAC = 2;
        break;
        case 6:
            nRaceAC = 3;
        break;
   }
   switch (nRandomRace)
   {
        case 1:
            nRace = IP_CONST_RACIALTYPE_DWARF;
        break;
        case 2:
            nRace = IP_CONST_RACIALTYPE_ELF;
        break;
        case 3:
            nRace = IP_CONST_RACIALTYPE_GNOME;
        break;
        case 4:
            nRace = IP_CONST_RACIALTYPE_HALFELF;
        break;
        case 5:
            nRace = IP_CONST_RACIALTYPE_HALFLING;
        break;
        case 6:
            nRace = IP_CONST_RACIALTYPE_HALFORC;
        break;
        case 7:
            nRace = IP_CONST_RACIALTYPE_HUMAN;
        break;
        case 8:
            nRace = IP_CONST_RACIALTYPE_ANIMAL;
        break;
        case 9:
            nRace = IP_CONST_RACIALTYPE_DRAGON;
        break;
        case 10:
            nRace = IP_CONST_RACIALTYPE_UNDEAD;
        break;
        case 11:
            nRace = IP_CONST_RACIALTYPE_OUTSIDER;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 1;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 2;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddRace = ItemPropertyACBonusVsRace(nRace,nRaceAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Helmet
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRace,oItemBaseHelmet);
   MothRandomItemNameAndDescription(oItemBaseHelmet,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Helmet.
void MothRandomItemMediumHelmet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseHelmet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique helmet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddRace;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nRace;
   int nRaceAC;
   oItemBaseHelmet = CreateItemOnObject("x2_it_arhelm03",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomRaceAC = Random(6)+1;
   int nRandomRace = Random(11)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Helmet of ";
        break;
        case 2:
          sItemBase = "Hood of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomRaceAC)
   {
        case 1:
            nRaceAC = 1;
        break;
        case 2:
            nRaceAC = 2;
        break;
        case 3:
            nRaceAC = 3;
        break;
        case 4:
            nRaceAC = 4;
        break;
        case 5:
            nRaceAC = 5;
        break;
        case 6:
            nRaceAC = 6;
        break;
   }
   switch (nRandomRace)
   {
        case 1:
            nRace = IP_CONST_RACIALTYPE_DWARF;
        break;
        case 2:
            nRace = IP_CONST_RACIALTYPE_ELF;
        break;
        case 3:
            nRace = IP_CONST_RACIALTYPE_GNOME;
        break;
        case 4:
            nRace = IP_CONST_RACIALTYPE_HALFELF;
        break;
        case 5:
            nRace = IP_CONST_RACIALTYPE_HALFLING;
        break;
        case 6:
            nRace = IP_CONST_RACIALTYPE_HALFORC;
        break;
        case 7:
            nRace = IP_CONST_RACIALTYPE_HUMAN;
        break;
        case 8:
            nRace = IP_CONST_RACIALTYPE_ANIMAL;
        break;
        case 9:
            nRace = IP_CONST_RACIALTYPE_DRAGON;
        break;
        case 10:
            nRace = IP_CONST_RACIALTYPE_UNDEAD;
        break;
        case 11:
            nRace = IP_CONST_RACIALTYPE_OUTSIDER;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 1;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 2;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddRace = ItemPropertyACBonusVsRace(nRace,nRaceAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Helmet
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRace,oItemBaseHelmet);
   MothRandomItemNameAndDescription(oItemBaseHelmet,sBaseType,sItemBase,sPrefix);
}
//Makes random high-loot Helmet.
void MothRandomItemHighHelmet(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseHelmet;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique helmet";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAC;
   itemproperty ipAddFeat;
   itemproperty ipAddRegen;
   itemproperty ipAddRace;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAC;
   int nFeat;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   int nRace;
   int nRaceAC;
   oItemBaseHelmet = CreateItemOnObject("x2_it_arhelm03",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAC = Random(2)+1;
   int nRandomFeat = Random(20)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomRaceAC = Random(6)+1;
   int nRandomRace = Random(11)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Helmet of ";
        break;
        case 2:
          sItemBase = "Hood of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 10;
        break;
        case 5:
            nSkillBonus = 11;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_PERFORM;
        break;
   }
   switch (nRandomRaceAC)
   {
        case 1:
            nRaceAC = 7;
        break;
        case 2:
            nRaceAC = 2;
        break;
        case 3:
            nRaceAC = 3;
        break;
        case 4:
            nRaceAC = 4;
        break;
        case 5:
            nRaceAC = 5;
        break;
        case 6:
            nRaceAC = 6;
        break;
   }
   switch (nRandomRace)
   {
        case 1:
            nRace = IP_CONST_RACIALTYPE_DWARF;
        break;
        case 2:
            nRace = IP_CONST_RACIALTYPE_ELF;
        break;
        case 3:
            nRace = IP_CONST_RACIALTYPE_GNOME;
        break;
        case 4:
            nRace = IP_CONST_RACIALTYPE_HALFELF;
        break;
        case 5:
            nRace = IP_CONST_RACIALTYPE_HALFLING;
        break;
        case 6:
            nRace = IP_CONST_RACIALTYPE_HALFORC;
        break;
        case 7:
            nRace = IP_CONST_RACIALTYPE_HUMAN;
        break;
        case 8:
            nRace = IP_CONST_RACIALTYPE_ANIMAL;
        break;
        case 9:
            nRace = IP_CONST_RACIALTYPE_DRAGON;
        break;
        case 10:
            nRace = IP_CONST_RACIALTYPE_UNDEAD;
        break;
        case 11:
            nRace = IP_CONST_RACIALTYPE_OUTSIDER;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 2;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 2;
        break;
        case 4:
            nBaseRegen = 3;
        break;
   }
   switch (nRandomFeat)
   {
        case 1:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 2:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 3:
            nFeat = IP_CONST_FEAT_MOBILITY;
        break;
        case 4:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 5:
            nFeat = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;
        break;
        case 6:
            nFeat = IP_CONST_FEAT_ALERTNESS;
        break;
        case 7:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 8:
            nFeat = IP_CONST_FEAT_AMBIDEXTROUS;
        break;
        case 9:
            nFeat = IP_CONST_FEAT_DODGE;
        break;
        case 10:
            nFeat = IP_CONST_FEAT_COMBAT_CASTING;
        break;
        case 11:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 12:
            nFeat = IP_CONST_FEAT_KNOCKDOWN;
        break;
        case 13:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 14:
            nFeat = IP_CONST_FEAT_POWERATTACK;
        break;
        case 15:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 16:
            nFeat = IP_CONST_FEAT_POINTBLANK;
        break;
        case 17:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 18:
            nFeat = IP_CONST_FEAT_WEAPFINESSE;
        break;
        case 19:
            nFeat = IP_CONST_FEAT_DISARM;
        break;
        case 20:
            nFeat = IP_CONST_FEAT_CLEAVE;
        break;

   }
   switch (nRandomAC)
   {
        case 1:
            nAC = 4;
        break;
        case 2:
            nAC = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAC = ItemPropertyACBonus(nAC);
   ipAddFeat = ItemPropertyBonusFeat(nFeat);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddRace = ItemPropertyACBonusVsRace(nRace,nRaceAC);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Helmet
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAC,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddFeat,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseHelmet);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRace,oItemBaseHelmet);
   MothRandomItemNameAndDescription(oItemBaseHelmet,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// GLOVES
//----------------------------------------------------------
//Makes random low-loot Gloves.
void MothRandomItemLowGloves(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseGloves;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a pair of unique Gloves";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAB;
   itemproperty ipAddDamage;
   itemproperty ipAddRegen;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAB;
   int nDamage;
   int nDamageType;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   oItemBaseGloves = CreateItemOnObject("nw_it_mglove004",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAB = Random(2)+1;
   int nRandomDamage = Random(10)+1;
   int nRandomDamageType = Random(10)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Gloves of ";
        break;
        case 2:
          sItemBase = "Knuckles of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_HIDE;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 1;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 1;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomDamage)
   {
        case 1:
            nDamage = IP_CONST_DAMAGEBONUS_1;
        break;
        case 2:
            nDamage = IP_CONST_DAMAGEBONUS_2;
        break;
        case 3:
            nDamage = IP_CONST_DAMAGEBONUS_3;
        break;
        case 4:
            nDamage = IP_CONST_DAMAGEBONUS_4;
        break;
        case 5:
            nDamage = IP_CONST_DAMAGEBONUS_1d4;
        break;
        case 6:
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        break;
        case 7:
            nDamage = IP_CONST_DAMAGEBONUS_1;
        break;
        case 8:
            nDamage = IP_CONST_DAMAGEBONUS_2;
        break;
        case 9:
            nDamage = IP_CONST_DAMAGEBONUS_3;
        break;
        case 10:
            nDamage = IP_CONST_DAMAGEBONUS_1d4;
        break;
   }
   switch (nRandomDamageType)
   {
        case 1:
            nDamageType = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 3:
            nDamageType = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
        break;
        case 5:
            nDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
        case 7:
            nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
        break;
        case 8:
            nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
        break;
        case 9:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 10:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
   }
   switch (nRandomAB)
   {
        case 1:
            nAB = 4;
        break;
        case 2:
            nAB = 3;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAB = ItemPropertyAttackBonus(nAB);
   ipAddDamage = ItemPropertyDamageBonus(nDamageType,nDamage);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Glove Special
   itemproperty iMonkOnly = ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK);
   AddItemProperty(DURATION_TYPE_PERMANENT,iMonkOnly,oItemBaseGloves);
   //Finalize the Gloves
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAB,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddDamage,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseGloves);
   MothRandomItemNameAndDescription(oItemBaseGloves,sBaseType,sItemBase,sPrefix);
}

//Makes random medium-loot Gloves.
void MothRandomItemMediumGloves(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseGloves;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a pair of unique Gloves";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAB;
   itemproperty ipAddDamage;
   itemproperty ipAddRegen;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAB;
   int nDamage;
   int nDamageType;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   oItemBaseGloves = CreateItemOnObject("nw_it_mglove004",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAB = Random(2)+1;
   int nRandomDamage = Random(10)+1;
   int nRandomDamageType = Random(10)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Gloves of ";
        break;
        case 2:
          sItemBase = "Knuckles of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_HIDE;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 2;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 3;
        break;
        case 4:
            nBaseRegen = 1;
        break;
   }
   switch (nRandomDamage)
   {
        case 1:
            nDamage = IP_CONST_DAMAGEBONUS_5;
        break;
        case 2:
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        break;
        case 3:
            nDamage = IP_CONST_DAMAGEBONUS_3;
        break;
        case 4:
            nDamage = IP_CONST_DAMAGEBONUS_4;
        break;
        case 5:
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
        break;
        case 6:
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        break;
        case 7:
            nDamage = IP_CONST_DAMAGEBONUS_4;
        break;
        case 8:
            nDamage = IP_CONST_DAMAGEBONUS_2;
        break;
        case 9:
            nDamage = IP_CONST_DAMAGEBONUS_3;
        break;
        case 10:
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
        break;
   }
   switch (nRandomDamageType)
   {
        case 1:
            nDamageType = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 3:
            nDamageType = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
        break;
        case 5:
            nDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
        case 7:
            nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
        break;
        case 8:
            nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
        break;
        case 9:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 10:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
   }
   switch (nRandomAB)
   {
        case 1:
            nAB = 4;
        break;
        case 2:
            nAB = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAB = ItemPropertyAttackBonus(nAB);
   ipAddDamage = ItemPropertyDamageBonus(nDamageType,nDamage);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Glove Special
   itemproperty iMonkOnly = ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK);
   AddItemProperty(DURATION_TYPE_PERMANENT,iMonkOnly,oItemBaseGloves);
   //Finalize the Gloves
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAB,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddDamage,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseGloves);
   MothRandomItemNameAndDescription(oItemBaseGloves,sBaseType,sItemBase,sPrefix);
}
//Makes random High-loot Gloves.
void MothRandomItemHighGloves(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseGloves;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a pair of unique Gloves";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddAB;
   itemproperty ipAddDamage;
   itemproperty ipAddRegen;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nAB;
   int nDamage;
   int nDamageType;
   int nBaseRegen;
   int nSkill;
   int nSkillBonus;
   oItemBaseGloves = CreateItemOnObject("nw_it_mglove004",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomAB = Random(2)+1;
   int nRandomDamage = Random(10)+1;
   int nRandomDamageType = Random(10)+1;
   int nRandomBaseRegen = Random(4)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Gloves of ";
        break;
        case 2:
          sItemBase = "Knuckles of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 10;
        break;
        case 5:
            nSkillBonus = 11;
        break;
        case 6:
            nSkillBonus = 12;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_ANIMAL_EMPATHY;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_SPOT;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_OPEN_LOCK;
        break;
        case 9:
            nSkill = SKILL_DISABLE_TRAP;
        break;
        case 10:
            nSkill = SKILL_HIDE;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomBaseRegen)
   {
        case 1:
            nBaseRegen = 2;
        break;
        case 2:
            nBaseRegen = 2;
        break;
        case 3:
            nBaseRegen = 3;
        break;
        case 4:
            nBaseRegen = 4;
        break;
   }
   switch (nRandomDamage)
   {
        case 1:
            nDamage = IP_CONST_DAMAGEBONUS_5;
        break;
        case 2:
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        break;
        case 3:
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
        break;
        case 4:
            nDamage = IP_CONST_DAMAGEBONUS_4;
        break;
        case 5:
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
        break;
        case 6:
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        break;
        case 7:
            nDamage = IP_CONST_DAMAGEBONUS_4;
        break;
        case 8:
            nDamage = IP_CONST_DAMAGEBONUS_1d10;
        break;
        case 9:
            nDamage = IP_CONST_DAMAGEBONUS_6;
        break;
        case 10:
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
        break;
   }
   switch (nRandomDamageType)
   {
        case 1:
            nDamageType = IP_CONST_DAMAGETYPE_ACID;
        break;
        case 2:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 3:
            nDamageType = IP_CONST_DAMAGETYPE_COLD;
        break;
        case 4:
            nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
        break;
        case 5:
            nDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
        break;
        case 6:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
        case 7:
            nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
        break;
        case 8:
            nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
        break;
        case 9:
            nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
        case 10:
            nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        break;
   }
   switch (nRandomAB)
   {
        case 1:
            nAB = 6;
        break;
        case 2:
            nAB = 5;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddAB = ItemPropertyAttackBonus(nAB);
   ipAddDamage = ItemPropertyDamageBonus(nDamageType,nDamage);
   ipAddRegen = ItemPropertyRegeneration(nBaseRegen);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Glove Special
   itemproperty iMonkOnly = ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK);
   AddItemProperty(DURATION_TYPE_PERMANENT,iMonkOnly,oItemBaseGloves);
   //Finalize the Gloves
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAB,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddDamage,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddRegen,oItemBaseGloves);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseGloves);
   MothRandomItemNameAndDescription(oItemBaseGloves,sBaseType,sItemBase,sPrefix);
}
//----------------------------------------------------------
// RINGS
//----------------------------------------------------------
//Makes random low-loot Rings.
void MothRandomItemLowRing(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseRing;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique ring";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddSave;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nSave;
   int nSaveType;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseRing = CreateItemOnObject("nw_it_mring009",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomSave = Random(3)+1;
   int nRandomSaveType = Random(3)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Ring of ";;
        break;
        case 2:
          sItemBase = "Band of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 1;
        break;
        case 2:
            nSkillBonus = 2;
        break;
        case 3:
            nSkillBonus = 3;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_HIDE;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_6;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_NATURES_BALANCE_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomSave)
   {
        case 1:
            nSave = 2;
        break;
        case 2:
            nSave = 3;
        break;
        case 3:
            nSave = 4;
        break;
   }
   switch (nRandomSaveType)
   {
        case 1:
            nSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 1;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddSave = ItemPropertyBonusSavingThrow(nSaveType,nSave);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ring
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseRing);
   MothRandomItemNameAndDescription(oItemBaseRing,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Rings.
void MothRandomItemMediumRing(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseRing;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique ring";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddSave;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nSave;
   int nSaveType;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseRing = CreateItemOnObject("nw_it_mring009",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomSave = Random(3)+1;
   int nRandomSaveType = Random(3)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Ring of ";;
        break;
        case 2:
          sItemBase = "Band of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 5;
        break;
        case 4:
            nSkillBonus = 4;
        break;
        case 5:
            nSkillBonus = 5;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_HIDE;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_6;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_NATURES_BALANCE_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomSave)
   {
        case 1:
            nSave = 3;
        break;
        case 2:
            nSave = 4;
        break;
        case 3:
            nSave = 5;
        break;
   }
   switch (nRandomSaveType)
   {
        case 1:
            nSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 2;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddSave = ItemPropertyBonusSavingThrow(nSaveType,nSave);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ring
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseRing);
   MothRandomItemNameAndDescription(oItemBaseRing,sBaseType,sItemBase,sPrefix);
}
//Makes random medium-loot Rings.
void MothRandomItemHighRing(string sTag)
{
   //Loot chest pool
   object oChest = GetObjectByTag(sTag);
   //Base Item
   object oItemBaseRing;
   //Strings
   string sItemBase;
   string sPrefix = "the ";
   string sBaseType = "a unique ring";
   //Item Properties
   itemproperty ipAddAbility;
   itemproperty ipAddSave;
   itemproperty ipAddSpellSlot;
   itemproperty ipAddSpell;
   itemproperty ipAddSkill;
   //Bonuses
   int nAbility;
   int nAbilityBonus;
   int nSave;
   int nSaveType;
   int nSpellSlotClass;
   int nSpellSlotLevel;
   int nSpell;
   int nSpellUses;
   int nSkill;
   int nSkillBonus;
   //Make Base Cloak
   oItemBaseRing = CreateItemOnObject("nw_it_mring009",oChest,1);
   //Local Switches
   int nRandomAbility = Random(6)+1;
   int nRandomAbilityBonus = Random(2)+1;
   int nRandomSave = Random(3)+1;
   int nRandomSaveType = Random(3)+1;
   int nRandomSpellSlotClass = Random(7)+1;
   int nRandomSpellSlotLevel = Random(9)+1;
   int nRandomSpell = Random(30)+1;
   int nRandomSpellUses = Random(2)+1;
   int nRandomSkill = Random(12)+1;
   int nRandomSkillBonus = Random(6)+1;
   int nItemBase = Random(2)+1;
   switch (nItemBase)
   {
        case 1:
          sItemBase = "Ring of ";;
        break;
        case 2:
          sItemBase = "Band of ";
        break;
   }
   switch (nRandomSkillBonus)
   {
        case 1:
            nSkillBonus = 7;
        break;
        case 2:
            nSkillBonus = 8;
        break;
        case 3:
            nSkillBonus = 9;
        break;
        case 4:
            nSkillBonus = 10;
        break;
        case 5:
            nSkillBonus = 6;
        break;
        case 6:
            nSkillBonus = 6;
        break;
   }
   switch (nRandomSkill)
   {
        case 1:
            nSkill = SKILL_CONCENTRATION;
        break;
        case 2:
            nSkill = SKILL_DISCIPLINE;
        break;
        case 3:
            nSkill = SKILL_SEARCH;
        break;
        case 4:
            nSkill = SKILL_HEAL;
        break;
        case 5:
            nSkill = SKILL_TAUNT;
        break;
        case 6:
            nSkill = SKILL_INTIMIDATE;
        break;
        case 7:
            nSkill = SKILL_LISTEN;
        break;
        case 8:
            nSkill = SKILL_HIDE;
        break;
        case 9:
            nSkill = SKILL_LORE;
        break;
        case 10:
            nSkill = SKILL_PERFORM;
        break;
        case 11:
            nSkill = SKILL_SET_TRAP;
        break;
        case 12:
            nSkill = SKILL_MOVE_SILENTLY;
        break;
   }
   switch (nRandomSpellUses)
   {
        case 1:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        break;
        case 2:
            nSpellUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        break;
   }
   switch (nRandomSpell)
   {
        case 1:
            nSpell = IP_CONST_CASTSPELL_BARKSKIN_6;
        break;
        case 2:
            nSpell = IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7;
        break;
        case 3:
            nSpell = IP_CONST_CASTSPELL_WAR_CRY_7;
        break;
        case 4:
            nSpell = IP_CONST_CASTSPELL_CAMOFLAGE_5;
        break;
        case 5:
            nSpell = IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
        case 6:
            nSpell = IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        break;
        case 7:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 8:
            nSpell = IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13;
        break;
        case 9:
            nSpell = IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        break;
        case 10:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        break;
        case 11:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        break;
        case 12:
            nSpell = IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        break;
        case 13:
            nSpell = IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        break;
        case 14:
            nSpell = IP_CONST_CASTSPELL_STONESKIN_7;
        break;
        case 15:
            nSpell = IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18;
        break;
        case 16:
            nSpell = IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        break;
        case 17:
            nSpell = IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        break;
        case 18:
            nSpell = IP_CONST_CASTSPELL_NATURES_BALANCE_15;
        break;
        case 19:
            nSpell = IP_CONST_CASTSPELL_TRUE_SEEING_9;
        break;
        case 20:
            nSpell = IP_CONST_CASTSPELL_RESTORATION_7;
        break;
        case 21:
            nSpell = IP_CONST_CASTSPELL_RESURRECTION_13;
        break;
        case 22:
            nSpell = IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        break;
        case 23:
            nSpell = IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        break;
        case 24:
            nSpell = IP_CONST_CASTSPELL_HEAL_11;
        break;
        case 25:
            nSpell = IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        break;
        case 26:
            nSpell = IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        break;
        case 27:
            nSpell = IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        break;
        case 28:
            nSpell = IP_CONST_CASTSPELL_RAISE_DEAD_9;
        break;
        case 29:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        break;
        case 30:
            nSpell = IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        break;
   }
   switch (nRandomSpellSlotClass)
   {
        case 1:
            nSpellSlotClass = IP_CONST_CLASS_BARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 6;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 5;
                break;
           }
        break;
        case 2:
            nSpellSlotClass = IP_CONST_CLASS_PALADIN;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 3:
            nSpellSlotClass = IP_CONST_CLASS_RANGER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 1;
                break;
                case 6:
                    nSpellSlotLevel = 2;
                break;
                case 7:
                    nSpellSlotLevel = 3;
                break;
                case 8:
                    nSpellSlotLevel = 4;
                break;
                case 9:
                    nSpellSlotLevel = 4;
                break;
           }
        break;
        case 4:
            nSpellSlotClass = IP_CONST_CLASS_CLERIC;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 5:
            nSpellSlotClass = IP_CONST_CLASS_DRUID;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 6:
            nSpellSlotClass = IP_CONST_CLASS_SORCERER;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
        case 7:
            nSpellSlotClass = IP_CONST_CLASS_WIZARD;
         switch (nRandomSpellSlotLevel)
           {
                case 1:
                    nSpellSlotLevel = 1;
                break;
                case 2:
                    nSpellSlotLevel = 1;
                break;
                case 3:
                    nSpellSlotLevel = 2;
                break;
                case 4:
                    nSpellSlotLevel = 4;
                break;
                case 5:
                    nSpellSlotLevel = 5;
                break;
                case 6:
                    nSpellSlotLevel = 6;
                break;
                case 7:
                    nSpellSlotLevel = 7;
                break;
                case 8:
                    nSpellSlotLevel = 8;
                break;
                case 9:
                    nSpellSlotLevel = 9;
                break;
           }
        break;
   }
   switch (nRandomSave)
   {
        case 1:
            nSave = 4;
        break;
        case 2:
            nSave = 5;
        break;
        case 3:
            nSave = 6;
        break;
   }
   switch (nRandomSaveType)
   {
        case 1:
            nSaveType = IP_CONST_SAVEBASETYPE_FORTITUDE;
        break;
        case 2:
            nSaveType = IP_CONST_SAVEBASETYPE_REFLEX;
        break;
        case 3:
            nSaveType = IP_CONST_SAVEBASETYPE_WILL;
        break;
   }
   switch (nRandomAbilityBonus)
   {
        case 1:
            nAbilityBonus = 3;
        break;
        case 2:
            nAbilityBonus = 4;
        break;
   }
   switch (nRandomAbility)
   {
        case 1:
            nAbility = IP_CONST_ABILITY_CHA;
        break;
        case 2:
            nAbility = IP_CONST_ABILITY_CON;
        break;
        case 3:
            nAbility = IP_CONST_ABILITY_DEX;
        break;
        case 4:
            nAbility = IP_CONST_ABILITY_INT;
        break;
        case 5:
            nAbility = IP_CONST_ABILITY_STR;
        break;
        case 6:
            nAbility = IP_CONST_ABILITY_WIS;
        break;
   }
   //Set the properties
   if(nRandomSpell ==24)
   {
     nSpellUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
   }
   ipAddAbility = ItemPropertyAbilityBonus(nAbility,nAbilityBonus);
   ipAddSave = ItemPropertyBonusSavingThrow(nSaveType,nSave);
   ipAddSpellSlot = ItemPropertyBonusLevelSpell(nSpellSlotClass,nSpellSlotLevel);
   ipAddSpell = ItemPropertyCastSpell(nSpell,nSpellUses);
   ipAddSkill = ItemPropertySkillBonus(nSkill,nSkillBonus);
   //Finalize the Ring
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddAbility,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSave,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpellSlot,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSpell,oItemBaseRing);
   AddItemProperty(DURATION_TYPE_PERMANENT,ipAddSkill,oItemBaseRing);
   MothRandomItemNameAndDescription(oItemBaseRing,sBaseType,sItemBase,sPrefix);
}
//Low items
void MothRandomItemLow(string sTag,
                    int MakeAmulet=FALSE,
                    int MakeArmor=FALSE,
                    int MakeBelt=FALSE,
                    int MakeBoots=FALSE,
                    int MakeBracer=FALSE,
                    int MakeCloak=FALSE,
                    int MakeHelmet=FALSE,
                    int MakeGloves=FALSE,
                    int MakeRing=FALSE,
                    int MakeShield=FALSE,
                    int MakeWMelee=FALSE,
                    int MakeWLauncher=FALSE,
                    int MakeWThrow=FALSE)
{
    if(MakeAmulet==TRUE){MothRandomItemLowAmulet(sTag);}
    if(MakeArmor==TRUE){MothRandomItemLowArmor(sTag);}
    if(MakeBelt==TRUE){MothRandomItemLowBelt(sTag);}
    if(MakeBoots==TRUE){MothRandomItemLowBoots(sTag);}
    if(MakeBracer==TRUE){MothRandomItemLowBracers(sTag);}
    if(MakeCloak==TRUE){MothRandomItemLowCloak(sTag);}
    if(MakeHelmet==TRUE){MothRandomItemLowHelmet(sTag);}
    if(MakeGloves==TRUE){MothRandomItemLowGloves(sTag);}
    if(MakeRing==TRUE){MothRandomItemLowRing(sTag);}
}
//Medium items
void MothRandomItemMedium(string sTag,
                    int MakeAmulet=FALSE,
                    int MakeArmor=FALSE,
                    int MakeBelt=FALSE,
                    int MakeBoots=FALSE,
                    int MakeBracer=FALSE,
                    int MakeCloak=FALSE,
                    int MakeHelmet=FALSE,
                    int MakeGloves=FALSE,
                    int MakeRing=FALSE,
                    int MakeShield=FALSE,
                    int MakeWMelee=FALSE,
                    int MakeWLauncher=FALSE,
                    int MakeWThrow=FALSE)
{
    if(MakeAmulet==TRUE){MothRandomItemMediumAmulet(sTag);}
    if(MakeArmor==TRUE){MothRandomItemMediumArmor(sTag);}
    if(MakeBelt==TRUE){MothRandomItemMediumBelt(sTag);}
    if(MakeBoots==TRUE){MothRandomItemMediumBoots(sTag);}
    if(MakeBracer==TRUE){MothRandomItemMediumBracers(sTag);}
    if(MakeCloak==TRUE){MothRandomItemMediumCloak(sTag);}
    if(MakeHelmet==TRUE){MothRandomItemMediumHelmet(sTag);}
    if(MakeGloves==TRUE){MothRandomItemMediumGloves(sTag);}
    if(MakeRing==TRUE){MothRandomItemMediumRing(sTag);}
}
//High items
void MothRandomItemHigh(string sTag,
                    int MakeAmulet=FALSE,
                    int MakeArmor=FALSE,
                    int MakeBelt=FALSE,
                    int MakeBoots=FALSE,
                    int MakeBracer=FALSE,
                    int MakeCloak=FALSE,
                    int MakeHelmet=FALSE,
                    int MakeGloves=FALSE,
                    int MakeRing=FALSE,
                    int MakeShield=FALSE,
                    int MakeWMelee=FALSE,
                    int MakeWLauncher=FALSE,
                    int MakeWThrow=FALSE)
{
    if(MakeAmulet==TRUE){MothRandomItemHighAmulet(sTag);}
    if(MakeArmor==TRUE){MothRandomItemHighArmor(sTag);}
    if(MakeBelt==TRUE){MothRandomItemHighBelt(sTag);}
    if(MakeBoots==TRUE){MothRandomItemHighBoots(sTag);}
    if(MakeBracer==TRUE){MothRandomItemHighBracers(sTag);}
    if(MakeCloak==TRUE){MothRandomItemHighCloak(sTag);}
    if(MakeHelmet==TRUE){MothRandomItemHighHelmet(sTag);}
    if(MakeGloves==TRUE){MothRandomItemHighGloves(sTag);}
    if(MakeRing==TRUE){MothRandomItemHighRing(sTag);}
}
//void main() {}


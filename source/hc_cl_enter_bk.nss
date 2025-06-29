//////Hardcore Client Entering
//Archaegeo 2002 Jun 24

// This script goes in OnClientEnter in Module Properties - Events
// It checks to see if they have a Death Amulet on them, and if so
// It sets thier player state to Dead and rekills them.

#include "hc_inc"
#include "hc_inc_on_enter"
#include "hc_text_enter"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_htf"


void HCRBoot(object oPC, string sReason)
{
    SendMessageToPC(oPC,sReason);
    DelayCommand(3.0,BootPC(oPC));
}

location GetSavedLocation(object oPC)
{
    location lLoc = GetPersistentLocation(oPC, "PV_START_LOCATION");

    if (GetAreaFromLocation(lLoc) == OBJECT_INVALID)
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 0);
    else
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 1);

    return lLoc;
}

void PWDB_PlaceCharacter(object oPC)
{
    location lStartPoint;
    object oClient = oPC;

    // Exit and do nothing if this isn't a player.
    if (!GetIsPC(oClient)) return;

     // First check and see if the player has a saved prior location.
    lStartPoint = GetSavedLocation(oClient);

    int iValidSpawn = GetLocalInt(oClient, "TMP_VALID_SPAWN");
    DeleteLocalInt(oClient, "TMP_VALID_SPAWN");

    // If the start is valid, move us there, else do nothing and let the game
    // use the standard start point.
    if (iValidSpawn == 1)
        AssignCommand(oClient, ActionJumpToLocation(lStartPoint));
}

void main()
{
  if(!preEvent()) return;
  object oPC = GetEnteringObject();
  SetPlotFlag(oPC,FALSE);
  int nPKT=GetLocalInt(oMod,"PKTRACKER");
  int nDM=GetIsDM(oPC);
  string sCDK=GetPCPublicCDKey(oPC);
  if(nPKT)
  {
    if(GetPersistentInt(oMod,"PKCOUNT"+sCDK)>nPKT)
    {
        SendMessageToAllDMs(sCDK+DMBOOTPK);
        HCRBoot(oPC,PCBOOTPK);
        postEvent();
        return;
    }
  }
  if(GetLocalInt(oMod,"SINGLECHARACTER") && !nDM)
  {
    string sRegChar=GetPersistentString(oMod,"SINGLECHARACTER"+sCDK);
    if(sRegChar != "" && sRegChar != GetName(oPC))
    {
        HCRBoot(oPC,SINGLEBOOT+sRegChar);
        postEvent();
        return;
    }
    else
    {
        SetPersistentString(oMod,"SINGLECHARACTER"+sCDK,GetName(oPC));
        SendMessageToPC(oPC,SINGLEREG);
    }
  }
  if(GetPersistentInt(oMod,"BANNED"+sCDK))
  {
    HCRBoot(oPC, BANNED);
    postEvent();
    return;
  }
  if(GetLocalInt(oMod,"LOCKED") && !nDM)
  {
    HCRBoot(oPC,LOCKED);
    postEvent();
    return;
  }
  if(GetLocalInt(oMod,"DMRESERVE"))
  {
    int nC;
    object oPlayers=GetFirstPC();
    if(!nDM)
    {
        while(GetIsObjectValid(oPlayers))
        {
            if(!GetIsDM(oPlayers)) nC++;
            oPlayers=GetNextPC();
        }
    }
    if(nC > GetLocalInt(oMod,"DMRESERVE") && nDM==FALSE)
    {
        HCRBoot(oPC,DMRES);
        postEvent();
        return;
    }
  }
  if(!GetLocalInt(oMod,"HCRREAD"))
  {
    SendMessageToPC(oPC,NOHCRENABLED);
    return;
  }
  int nGiveLevel=GetLocalInt(oMod,"GIVELEVEL");
  if(GetLocalInt(oMod,"STORESYSTEM"))
  {
    if(GetIsPC(oPC) && !(GetXP(oPC)) && !nDM)
    {
        string  STORE_NAME      = "NewbieMerchant";

//If you want everyone to have the same amount of starting gold, modify the
//lines below
//      int     STARTING_GOLD = 150;
        int     STARTING_GOLD=0;
        int     PLAYER_STRIPS   = TRUE;

// Giving PC its starting gold.
        if(nGiveLevel > 1 && STARTING_GOLD==0)
        {
            switch (nGiveLevel)
            {
                case 2:  STARTING_GOLD = 900; break;
                case 3:  STARTING_GOLD = 2700; break;
                case 4:  STARTING_GOLD = 5400; break;
                case 5:  STARTING_GOLD = 9000; break;
                case 6:  STARTING_GOLD = 13000; break;
                case 7:  STARTING_GOLD = 19000; break;
                case 8:  STARTING_GOLD = 27000; break;
                case 9:  STARTING_GOLD = 36000; break;
                case 10: STARTING_GOLD = 49000; break;
                case 11: STARTING_GOLD = 66000; break;
                case 12: STARTING_GOLD = 88000; break;
                case 13: STARTING_GOLD = 110000; break;
                case 14: STARTING_GOLD = 150000; break;
                case 15: STARTING_GOLD = 200000; break;
                case 16: STARTING_GOLD = 260000 ; break;
                case 17: STARTING_GOLD = 340000; break;
                case 18: STARTING_GOLD = 440000; break;
                case 19: STARTING_GOLD = 580000; break;
                case 20: STARTING_GOLD = 760000; break;
            }
        }
        if(!STARTING_GOLD)
        {
            if(GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)) STARTING_GOLD=d4(4)*10;
            else if(GetLevelByClass(CLASS_TYPE_BARD, oPC)) STARTING_GOLD=d4(4)*10;
            else if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC)) STARTING_GOLD=d4(5)*10;
            else if(GetLevelByClass(CLASS_TYPE_DRUID, oPC)) STARTING_GOLD=d4(2)*10;
            else if(GetLevelByClass(CLASS_TYPE_FIGHTER, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_MONK, oPC)) STARTING_GOLD=d4(5);
            else if(GetLevelByClass(CLASS_TYPE_PALADIN, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_RANGER, oPC)) STARTING_GOLD=d4(6)*10;
            else if(GetLevelByClass(CLASS_TYPE_ROGUE, oPC)) STARTING_GOLD=d4(5)*10;
            else if(GetLevelByClass(CLASS_TYPE_SORCERER, oPC)) STARTING_GOLD=d4(3)*10;
            else if(GetLevelByClass(CLASS_TYPE_WIZARD, oPC)) STARTING_GOLD=d4(3)*10;
            else STARTING_GOLD=d4(4)*10;
        }
        GiveGoldToCreature(oPC, STARTING_GOLD - GetGold(oPC));
        if (PLAYER_STRIPS)
        {

// Removing PC's equipment.

            object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
            oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
            if(GetIsObjectValid(oGear))
                DestroyObject(oGear);
        }

// Removing PC's inventory.

        object oStuff = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oStuff))
        {
            DestroyObject(oStuff);
            oStuff = GetNextItemInInventory(oPC);
        }

// Greet PC.

        DelayCommand(3.0, SendMessageToPC(oPC, NOGOLD + IntToString(STARTING_GOLD) + " gp."));
        DelayCommand(3.0, SendMessageToPC(oPC, HCRINTRO));

// Taking PC shopping.

    }
  }


  {
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_TRAP);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmune, oPC);
  }


  if(GetHitDice(oPC)< nGiveLevel &&
        nGiveLevel > 1)
  {
    SendMessageToPC(oPC, NEWLEVEL+
        IntToString(nGiveLevel));
    int nNewXP= (nGiveLevel * (nGiveLevel-1)) / 2 * 1000;
    DelayCommand(2.0,SetXP(oPC,nNewXP));
  }
    if(GetLevelByClass(CLASS_TYPE_RANGER,oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"TrackerTool"))==FALSE)
           CreateItemOnObject("trackertool", oPC);
// Give Paladins their tools that simulate missing abilities
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>1 &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"hc_palbadgecour"))==FALSE)
           CreateItemOnObject("paladinsbadgeofc", oPC);
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC,"hc_paladinsymb"))==FALSE)
           CreateItemOnObject("paladinsholysymb", oPC);
// Give PC's a Trap Tool in inventory
    if(GetLocalInt(oMod,"HCRTRAPS") && GetIsObjectValid(GetItemPossessedBy
        (oPC,"searchtool"))==FALSE)
           CreateItemOnObject("searchtool", oPC);
// Give PC's an EmoteWand if using the DMHelper set.
    if(!GetIsObjectValid(GetItemPossessedBy(oPC,"EmoteWand")))
         CreateItemOnObject("emotewand", oPC);

// Give PC DM's a wand version of the HCR helper
    if(sCDK != "" && sCDK==GetPersistentString(oMod,"PLAYERDM"))
    {
        if(GetIsObjectValid(GetItemPossessedBy(oPC,"HCRHelpwand"))==FALSE)
            CreateItemOnObject("HCRHelpwand", oPC);
    }
// Give DM's a HCR Helper in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"HCRHelper"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("HCRHelper", oPC);
// Give DM's a DMHelper in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"DMsHelper"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("DMsHelper", oPC);
// Give DM's a FXWand in inventory
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"WandOfFX"))==FALSE &&
       (nDM || (sCDK!="" && sCDK==GetPersistentString(oMod,"PLAYERDM"))))
           CreateItemOnObject("WandOfFX", oPC);
// Give new PC's some food.
    if(GetLocalInt(oMod,"FOODSYSTEM") || GetLocalInt(oMod,"HUNGERSYSTEM"))
    {
        if(!GetXP(oPC) && !nDM)
             CreateItemOnObject("FoodRation", oPC);
    }
// Give new PC's a bedroll for the rest system
    if(GetLocalInt(oMod,"BEDROLLSYSTEM"))
    {
        if(!GetXP(oPC) && !nDM)
            if(GetIsObjectValid(GetItemPossessedBy(oPC,"bedroll"))==FALSE)
                CreateItemOnObject("bedroll", oPC);
    }
    int nCurState=GPS(oPC);
    int nHP=GetPersistentInt(oMod,"LastHP"+GetName(oPC)+sCDK);
    int nCHP=GetCurrentHitPoints(oPC);
    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
    {
      if (nCurState==PWS_PLAYER_STATE_RESURRECTED ||
          nCurState==PWS_PLAYER_STATE_RESTRUE ||
          nCurState==PWS_PLAYER_STATE_RAISEDEAD)
      {
          if(GetItemPossessedBy(oPC,"fuguerobe1")!=OBJECT_INVALID)
              DestroyObject( GetItemPossessedBy(oPC,"fuguerobe1"));
          if(nCurState!=PWS_PLAYER_STATE_RESTRUE &&
             GetLocalInt(oMod,"REZPENALTY"))
                DelayCommand(5.0,hcRezPenalty(oPC));
          if(nCurState==PWS_PLAYER_STATE_RAISEDEAD)
          {
            effect eDam=EffectDamage(GetCurrentHitPoints(oPC)-1);
            if( !GetLocalInt(oMod,"REZPENALTY"))
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
          }
          SPS(oPC,PWS_PLAYER_STATE_ALIVE);
          //RemoveEffects(oPC);
          location lWhere=GetPersistentLocation(oMod,"RESLOC"+GetName(oPC)+sCDK);
          DelayCommand(5.0,AssignCommand(oPC,JumpToLocation(lWhere)));
          DeletePersistentLocation(oMod, "RESLOC"+GetName(oPC)+sCDK);
      }
      else if(GetItemPossessedBy(oPC,"fuguerobe1")!=OBJECT_INVALID)
      {
        DestroyObject( GetItemPossessedBy(oPC,"fuguerobe1"));
        if(GetLocalInt(oMod,"DEATHOVERREBOOT") &&
            nCurState==PWS_PLAYER_STATE_ALIVE)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
        }

      }
      else if(nCurState==PWS_PLAYER_STATE_ALIVE)
      {
        if(nHP && nCHP>nHP)
        {
            effect eDam=EffectDamage(nCHP-nHP);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
        }
      }
      else if(nCurState != PWS_PLAYER_STATE_ALIVE)
      {
        if(nCurState==PWS_PLAYER_STATE_DYING ||
           nCurState==PWS_PLAYER_STATE_STABLE ||
           nCurState==PWS_PLAYER_STATE_STABLEHEAL)
        {
            effect eDam=EffectDamage(abs(nHP)+nCHP);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
        }
        else if(nCurState==PWS_PLAYER_STATE_DEAD)
        {
            SetLocalInt(oPC,"LOGINDEATH",1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC));
        }
        else if(nCurState==PWS_PLAYER_STATE_DISABLED ||
                nCurState==PWS_PLAYER_STATE_RECOVERY)
        {
            effect eDam=EffectDamage(GetCurrentHitPoints(oPC)-1);
            DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
        }
      }
    }
    else if(GetLocalInt(oMod,"DEATHSYSTEM"))
    {
        SetLocalInt(oPC,"LOGINDEATH",1);
        effect eDeath = EffectDeath(FALSE, FALSE);
        if(nCurState == PWS_PLAYER_STATE_DEAD)
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
    }
    if(!GetLocalInt(oMod,"PRIORTHISREBOOT"+sCDK+GetName(oPC)))
    {
        if(nCurState!=PWS_PLAYER_STATE_DEAD)
            DelayCommand(5.0,PWDB_PlaceCharacter(oPC));
        SetLocalInt(oMod,"PRIORTHISREBOOT"+sCDK+GetName(oPC),1);
    }

    //InitPCHTFLevels(oPC);

    if(!(GetXP(oPC)))
        SetXP(oPC, 1);
    if(GetLocalInt(oMod,"PWEXP"))
    {
       // if(!DND_get_exp(oPC))
       //     SetUpExp(oPC, 0);
    }
    // Send a login message to all players if one exists
    if(GetLocalString(oMod,"LOGINMESSAGE") != "NONE")
        SendMessageToPC(oPC,GetLocalString(oMod,"LOGINMESSAGE"));

    if(GetLocalInt(oMod,"DECONENTER"))
    ExecuteScript("hc_strip_talents",oPC);

    postEvent();
}



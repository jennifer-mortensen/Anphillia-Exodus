//
#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_text_activate"
#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"
#include "anphrez_inc"
#include "anph_dropstuff"

int TRUE_RESS=3;
int RESS=2;
int RAISE=1;
int NONE=0;

void hc_act_pct_on_fire (object oPC, object oCorpse, object oFire, object oDeadPC)
{
    //Disabled
    /*
    location oFireLoc = GetLocation (oFire);
    CreateObject (OBJECT_TYPE_PLACEABLE, "ImpaledCorpse",
                  oFireLoc, TRUE);
    CreateObject (OBJECT_TYPE_PLACEABLE, "PyreFlame",
                  oFireLoc, TRUE);

    DestroyObject (oCorpse);

    SendMessageToPC (oDeadPC, "Your corpse has been set ablaze, there is no way out for you now");
    WriteTimestampedLogEntry(GetName(oPC) + " burned " + GetName(oDeadPC));
    AnphRez (oDeadPC, TRUE, oPC);
    // Force rez?
    */
}
int GetCharacterLevel (object oPC)
{
    int iLevel;

    iLevel = GetLevelByPosition (1, oPC);
    iLevel += GetLevelByPosition (2, oPC);
    iLevel += GetLevelByPosition (3, oPC);

    return (iLevel);
}
void MoveDC(object oDropped, object oUser)
{
    object oDC=GetLocalObject(oDropped,"DeathCorpse");
    object oOwner=GetLocalObject(oDropped,"Owner");
    string sName=GetLocalString(oDropped,"Name");
    string sCDK=GetLocalString(oDropped,"Key");
    string sFaction = GetLocalString(oDropped,"Faction");




// If a Death Corpse exits, move all the stuff from the old one to the new one
// at the new location
    object oDeadMan;
    object oDeathCorpse;
    oDeathCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                GetLocation(oUser));

    SetLocalString (oDeathCorpse, "Faction", sFaction);
    SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
    SetLocalObject(oMod,"PlayerCorpse"+sName+sCDK,oDeadMan);
    SetLocalObject(oDeathCorpse,"Owner",oOwner);
    SetLocalString(oDeathCorpse,"Name",sName);
    SetLocalString(oDeathCorpse,"Key",sCDK);
    AnphTransferThings (oDC, oDeathCorpse);
    DestroyObject (oDC, 1.0);
}
void main()
{
// If the item is a player corpse token, then see if they can get the poor
// slob resurrected.
    int casttype=NONE;
    object oUser=OBJECT_SELF;
    object oCleric=GetLocalObject(oUser,"CLERIC");
    object oItem=GetLocalObject(oUser,"ITEM");
    object oRespawner = AnphFindPlayerByKey (GetLocalString (oItem, "Name"),
                                             GetLocalString (oItem, "Key"));

    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"CLERIC");
    DeleteLocalObject(oUser,"DEADMAN");

    if (FindSubString(GetStringUpperCase(GetTag(oCleric)),"FIRE") >= 0)
    {
        hc_act_pct_on_fire (oUser, oItem, oCleric, oRespawner);
        return;
    }
    int iLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oCleric);
    int iPCLevel = GetCharacterLevel (oRespawner);

    if(!GetIsObjectValid(oRespawner))
    {
        SendMessageToPC(oUser, "<cþ¥ >Sorry, this player is no longer online, and as such cannot be raised right now.</c>");
        return;
    }

// Make sure the PC is online
    if(GetIsPC(oCleric)==TRUE)
    {
        SendMessageToPC(oUser, "<cþ¥ >Corpses may only be used on NPC clerics, or burned on camp fires.</c>");
        return;
    }
// Make sure the cleric is a NPC and at least level 10 (raise dead is a level
// 5 spell, requires level 10 to cast)
    if(iLevel < 9)
    {
        SendMessageToPC(oUser, "<cþ¥ >Corpses may only be used on powerful NPC clerics, or burned on camp fires.</c>");
        return;
    }
    int nAlign=GetLocalInt(oItem, "Alignment");

    int nGold=GetGold(oUser);
    int nGODSYSTEM;
    int nBaseCost=1;
    string sDeity=GetLocalString(oItem, "Deity");
// Find out how much, and see if they have that much gold.
    nGODSYSTEM=GetLocalInt(oMod,"GODSYSTEM");
    nBaseCost=0;
    int iRezAmount = 100 * iPCLevel + 100 + d20(3);
    if (iLevel >= 9 && nGold >= iRezAmount)
        casttype = RAISE;
    if (casttype == NONE)
    {
        SendMessageToPC(oUser,"<cþ¥ >"+NOTENOUGH+IntToString(iRezAmount)+" gps.</c>");
        return;
    }
// Charge em and raise the dead man
    AssignCommand(oCleric,TakeGoldFromCreature(iRezAmount, oUser, TRUE));
    SendMessageToPC(oUser, CLERICACCEPT);
    if(GetIsObjectValid(oRespawner))
    {
    if(GetTag(GetArea(oRespawner)) == "AxfellFuguePlane"||
       GetTag(GetArea(oRespawner)) == "CleavenFuguePlane"
       )
       {
            SetPlotFlag(oRespawner, FALSE);
            RemoveEffects(oRespawner);
            AssignCommand(oRespawner, ApplyEffectToObject(DURATION_TYPE_INSTANT,
                          EffectResurrection(),oRespawner));
            if (casttype >= RESS)
                AssignCommand(oRespawner,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                    EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner));
            else
            {
                effect eDam=EffectDamage(GetCurrentHitPoints(oRespawner)-1);
                if( !GetLocalInt(oMod,"REZPENALTY"))
                    AssignCommand(oRespawner,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        eDam,oRespawner));
            }
            DelayCommand (1.0, AssignCommand(oRespawner, JumpToObject (oUser)));
            DelayCommand (2.0, AssignCommand(oRespawner, JumpToObject (oUser)));
            DelayCommand (3.0, AssignCommand(oRespawner, JumpToObject (oCleric)));
            // If playing with REZPENALTY on (default) then take the level per the phb
            // Only take XP if not using a true ressurection
            if( GetLocalInt(oMod,"REZPENALTY") && casttype != TRUE_RESS)
                DelayCommand(5.0,hcRezPenalty (oRespawner));
       }
      else
      {
      SendMessageToPC(oUser,"<cþ¥ >Only Players in Fugue Plane can be resurrected!</c>");
      }
    }
    else
    {
        SendMessageToPC(oUser,NOTONLINE);
        SetPersistentLocation(oMod,"RESLOC"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), GetLocation(oCleric));
        if(casttype==TRUE_RESS)
            SetPersistentInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESTRUE);
        else if(casttype==RESS)
            SetPersistentInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RESURRECTED);
        else
            SetPersistentInt(oMod,"PlayerState"+
            GetLocalString(oItem,"Name")+
            GetLocalString(oItem,"Key"), PWS_PLAYER_STATE_RAISEDEAD);
    }
    DestroyObject(oItem);
}

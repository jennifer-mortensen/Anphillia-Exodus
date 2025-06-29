// Hardcore Death - Creates Death Amulet on player to prevent quit and return
//                  Also pops up Death GUI where respawn is now pray
// Archaegeo
// 2002 Jun 24

// This script sets the PlayerState to DEAD once they hit -10 hitpoits and
// displays one GUI if they have a deity, and another if they do not.
// Respawn buttor prays for ressurection on the one, and does nothing on other.

// REZPENALTY code by Jamos and Majoru

//#include "hc_inc_pwdb_func"

#include "hc_inc_on_death"
#include "hc_inc_gods"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_inc_timecheck"
#include "moth_inc"

#include "anph_inc"
#include "anph_dropstuff"

// Function to take equipped items from players
// function(thanks Jhenne)
void strip_equiped(object oPlayer, object oDeathCorpse, object oEquip)
{
    if(GetIsObjectValid(oEquip))
        AssignCommand(oDeathCorpse, ActionTakeItem(oEquip, oPlayer));
}

void main()
{
    if(!preEvent()) return;
    object oPlayer = GetLastPlayerDied();
    object oHenchman = GetHenchman(oPlayer);
    if (GetIsObjectValid(oHenchman)) RemoveHenchman(oPlayer, oHenchman);
    string sName=GetName(oPlayer);
    string sCDK=GetPCPublicCDKey(oPlayer);
    string sID=sName+sCDK;
    object oKiller=GetLastAttacker(oPlayer);
    location lDiedHere;
    object oDeathCorpse;
    string sFaction;

    if (GetItemPossessedBy(oPlayer, "axfellwarriorrin")!= OBJECT_INVALID)
    {
        sFaction = "Axfell";
    }
    if (GetItemPossessedBy(oPlayer, "cleavenmilitiari")!= OBJECT_INVALID)
    {
        sFaction = "Cleaven";
    }

    // Drop pack
    AnphDropStuff (oPlayer);


    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
    {
        SetPersistentInt (oMod, "LastRecCheck"+sID, 0);
        if (GPS(oPlayer) == PWS_PLAYER_STATE_ALIVE)
            DelayCommand(6.0, ExecuteScript("hc_bleeding", oPlayer));
        SPS(oPlayer, PWS_PLAYER_STATE_DEAD);

        oDeathCorpse = GetLocalObject(oMod,"DeathCorpse"+sID);

        if(GetIsObjectValid(oDeathCorpse) == FALSE)
        {
            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
            SetLocalObject(oDeathCorpse,"Owner",oPlayer);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalString(oDeathCorpse, "Faction", sFaction);
            SetLocalObject(oMod,"DeathCorpse"+sID,oDeathCorpse);
        }

// Now that they are DEAD, make a Player Corpse Token that others can use
// to drag their carcass to a cleric
        object oDeadMan;
        if(GetIsObjectValid(
            oDeadMan = GetLocalObject(oMod,"PlayerCorpse"+sID))==FALSE)
        {
            oDeadMan=CreateItemOnObject("PlayerCorpse", oDeathCorpse);
            //oDeadMan=CreateObject(OBJECT_TYPE_ITEM, "PlayerCorpse", lDiedHere);
        } else {
            SetLocalInt(oPlayer,"REDEATH",0);
        }
        SetLocalObject(oDeadMan,"Owner",oPlayer);
        SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
        SetLocalString(oDeadMan,"Name",sName);
        SetLocalString(oDeadMan,"Key",sCDK);
        SetLocalString (oDeadMan, "Faction", sFaction);
        SetLocalInt(oDeadMan,"Alignment",GetAlignmentGoodEvil(oPlayer));
        SetLocalString(oDeadMan,"Deity",GetDeity(oPlayer));
        SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
        SetLocalObject(oMod,"PlayerCorpse"+sID,oDeadMan);
    }

    string sCDKK=GetPCPublicCDKey(oKiller);
    if(GetLocalInt(oMod,"PKTRACKER"))
    {
        int nPartyMember;
        object oPM;
        object oMaster=GetMaster(oKiller);
        while(GetIsObjectValid(oMaster) && sCDKK=="")
        {
            sCDKK=GetPCPublicCDKey(oMaster);
            if(sCDKK !="")
            {
                oKiller=oMaster;
                break;
            }
            oMaster=GetMaster(oMaster);
        }
        oPM=GetFirstFactionMember(oPlayer);
        while(GetIsObjectValid(oPM))
        {
            if(oPM==oKiller)
            {
                nPartyMember=1;
                break;
            }
            oPM=GetNextFactionMember(oPlayer);
        }
        if(sCDKK!="" && !nPartyMember)
            SetPersistentInt(oMod,"PKCOUNT"+sCDKK,(GetPersistentInt(oMod,"PKCOUNT"+sCDKK)+1));
    }
    if(GetLocalInt(oMod,"TELLONPK") && sCDKK != "")
        SendMessageToAllDMs("**(PK): "+sName+" was PK'd by "+
            GetName(oKiller));

    AnphCheckPK (oPlayer, oKiller);


// IF using Deity pray system, check to see if they have a god, and if so, is
// that god listening.  (5% chance by default, can only be done once per character)
    int nRess;
    if((!GetLocalInt(oMod,"GODSYSTEM") || !(nRess=ress_check(oPlayer))) &&
        GetLocalInt(oMod,"LIMBO"))
    {
        SetLocalInt(oPlayer,"MOVING",1);
        string sLimboTag;

        // Get Faction's Fugue
        int iPlayerTeam = AnphGetPlayerTeamInt (oPlayer);
        sLimboTag = GetLocalString(oMod, "FACTION_0" + IntToString(iPlayerTeam) + "_FUGUE");

        //SendMessageToPC (oPlayer, "Player fugue tag:" + sLimboTag);

        object oLimbo = GetObjectByTag(sLimboTag);
        effect eParalyze = EffectParalyze();
        SetPersistentLocation(oMod,"DIED_HERE"+sID,lDiedHere);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectKnockdown(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer);
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, EffectMovementSpeedDecrease (100), oPlayer);

        //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(
        //    GetMaxHitPoints(oPlayer)), oPlayer);
        //MothRemoveEffects(oPlayer);
        // SetPlotFlag(oPlayer,TRUE);
        //DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, FALSE, 0, "Hit Respawn!"));
        AssignCommand(oPlayer, JumpToObject(oLimbo));
        SetLocalInt(oPlayer,"HESDEAD",1);

        //SetLocalInt(oPlayer,"LOGINDEATH",0);
        postEvent();
        return;
    }
    else if(!nRess && GetLocalInt(oMod,"DEATHSYSTEM"))
    {
        SendMessageToPC(oPlayer,"You have died. You must wait for help.");
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, FALSE, TRUE, 0, "You have no Deity, you must wait for help"));
    }
// If not using Death or Deity, then let them respawn normally.
    else if(!nRess)
    {
// If using the Loss of Level rez penalty, plug it in here if not using
// DEATH or GOD system (otherwise its handled elsewhere
        if( GetLocalInt(oMod,"REZPENALTY") )
            DelayCommand(5.0,hcRezPenalty(oPlayer));
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, "You may exit or respawn"));
    }
    SetLocalInt(oPlayer,"LOGINDEATH",0);

    postEvent();
}

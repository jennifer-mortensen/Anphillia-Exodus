#include "hc_inc_htf"
#include "hc_inc"
#include "_inc_const"
#include "moth_inc_effects"
#include "anph_inc"
#include "spawn_functions"
#include "_inc_subrace"
#include "tk_hips_inc"
#include "_inc_time"

void CreateCorpse (object oPlayer)
{
    object oPlayer = GetEnteringObject();
    string sName = GetName (oPlayer);
    string sCDK = GetPCPublicCDKey (oPlayer);
    string sID = sName + sCDK;
    string sFaction;
    location lDiedHere;
    object oTarget;
    lDiedHere = GetLocalLocation (oPlayer, "DeathLocation");
    if(!GetIsObjectValid(GetAreaFromLocation(lDiedHere)))
    {
        if (GetItemPossessedBy(oPlayer, "axfellwarriorrin")!= OBJECT_INVALID)
           {
                oTarget = GetWaypointByTag("mothdwpaxfell");
                lDiedHere = GetLocation(oTarget);
                sFaction = "Axfell";
           }
        if (GetItemPossessedBy(oPlayer, "cleavenmilitiari")!= OBJECT_INVALID)
           {
                oTarget = GetWaypointByTag("mothdwpcleave");
                lDiedHere = GetLocation(oTarget);
                sFaction = "Cleaven";
           }
    }else{
       if (GetItemPossessedBy(oPlayer, "axfellwarriorrin")!= OBJECT_INVALID)
           {
                sFaction = "Axfell";
           }
        if (GetItemPossessedBy(oPlayer, "cleavenmilitiari")!= OBJECT_INVALID)
           {
                sFaction = "Cleaven";
           }
    }
    WriteTimestampedLogEntry ("Creating corpse for player " +
                              sName);
    object oDeathCorpse = CreateObject (OBJECT_TYPE_PLACEABLE, "DeathCorpse", lDiedHere);
    object oDeadMan = CreateItemOnObject ("PlayerCorpse", oDeathCorpse);
    SetLocalObject (oDeathCorpse, "Owner", oPlayer);
    SetLocalString (oDeathCorpse, "Name", sName);
    SetLocalString (oDeathCorpse, "Key", sCDK);
    SetLocalObject (oDeathCorpse, "PlayerCorpse", oDeadMan);
    SetLocalString (oDeathCorpse, "Faction", sFaction);
    SetName(oDeathCorpse,""+sName+"'s Corpse ("+sFaction+")");
    SetLocalObject (oDeadMan, "Owner", oPlayer);
    SetLocalObject (oDeadMan, "DeathCorpse", oDeathCorpse);
    SetLocalString (oDeadMan, "Name", sName);
    SetLocalString (oDeadMan, "Key", sCDK);
    SetName(oDeadMan,sName);
    SetLocalInt (oDeadMan, "Alignment", GetAlignmentGoodEvil(oPlayer));
    SetLocalString (oDeadMan, "Deity", GetDeity (oPlayer));
    SetLocalString (oDeadMan, "Faction", sFaction);
    SetLocalObject (oMod, "PlayerCorpse" + sID, oDeadMan);
    SetLocalObject (oMod, "DeathCorpse" + sID, oDeathCorpse);
    WriteTimestampedLogEntry ("Corpse created for player " +
                              sName);
}
void main()
{
    object oPC = GetEnteringObject();
    ApplyEffectToObject (DURATION_TYPE_INSTANT,
                         EffectResurrection(), oPC);
    CreateCorpse (oPC);
    DelayCommand (5.0, DeleteLocalInt (oPC, "DiedButNotInFugue"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(
                        GetMaxHitPoints(oPC)), oPC);
    MothRemoveEffects(oPC);
    MothBonuses(oPC, FALSE);
    ExecuteScript("exe_appimmunes", oPC);
    SetPlotFlag(oPC, TRUE);

    if(!GetIsPC(oPC))
        return;

    //pawn_OnAreaEnter(); //NESS spawn control
    HandleLightBlindness(oPC); //Update subrace light blindness effects
    int nRoll = d100(GetTimeMillisecond() % 100); //Seed the RNG for better engine randomization results
    TK_HiPS_OnFeatChange(oPC); //Update HiPS status; necessary for rangers who only have HiPS in some areas.

    if(GetLocalInt(oPC, "REMOVE_PVP_FLAG") == -1)
    {
        SetLocalInt(oPC, "REMOVE_PVP_FLAG", GetSecondsSinceServerBoot() + PVP_FLAG_DURATION);
    }
}




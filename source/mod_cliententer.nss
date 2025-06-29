//J. Persinne, Feb. 11 2010; numerous revisions and optimizations made.

#include "hc_inc_on_enter"
#include "anph_level_inc"
#include "tk_hips_inc"
#include "moth_inc_effects"
#include "moth_inc"
#include "_inc_horse"
#include "_inc_const"

void RemoveSleepBlindness(object oPC)
{
    if(FADE_TO_BLACK_ON_REST == TRUE)
        FadeFromBlack(oPC);
    else
    {
        effect eBlindness = GetFirstEffect(oPC);
        int nTerminateLoop;
        while(GetIsEffectValid(eBlindness) && nTerminateLoop == FALSE)
        {
            if(GetEffectType(eBlindness) == EFFECT_TYPE_BLINDNESS)
            {
                RemoveEffect(oPC, eBlindness);
                nTerminateLoop = TRUE;
            }
            eBlindness = GetNextEffect(oPC);
        }
    }
    SetCommandable(TRUE, oPC);
}

void main()
{
    int nAppearance;
    object oMod = GetModule();
    object oPC = GetEnteringObject();
    string sName = GetName(oPC);
    string sPlayerName = GetPCPlayerName(oPC);
    int nCurrentHitPoints = GetCurrentHitPoints(oPC);
    int nHitPointsAtLastLogin = GetLocalInt(oMod, sPlayerName + sName + "CURRENT_HIT_POINTS");

    DeleteLocalInt(oPC, "INVENTORY_FULL");

    if(!GetLocalInt(oPC, "VARIABLES_INITIALIZED")) //Once per reboot functions.
    {
        ForceRest(oPC);
        ExecuteScript("exe_dbinitialize", oPC); //Initializes database variables; handled via an external script in order to avoid resource limit issues with including inc_db
        DelayCommand(1.0, ExecuteScript("exe_refimmunes", oPC)); //Apply immunities from items.
        SetLocalInt(oPC, "DEFAULT_PVP_STANCE", 1); //Handles whether the character is neutral or hostile to enemies.
        SetLocalInt(oPC, "CURRENT_PVP_STANCE", 1);
        SetLocalInt(oPC, "X1_AllowDrDris", TRUE); //Disable the RDD class.
        InitializeHorseSettings(oPC);
        MothSetIsPMCaster(oPC);
        MothSetFactionInt(oPC);
        MothBonuses(oPC);
        DelayCommand(6.0, MothGiveJournal(oPC));
        MothSetShifterLevels(oPC);
        SetPanelButtonFlash(oPC,PANEL_BUTTON_JOURNAL,FALSE);
        MothDislikeSecondaryFaction(oPC);
        MothSetDomain(oPC);

        nHitPointsAtLastLogin = nCurrentHitPoints; //Log in with full hit points on the first log in.

        if (!GetXP (oPC)) SetXP (oPC, 1); //Grant an experience point to new characters.

        if(GetLocalString(oMod, "LOGINMESSAGE") != "NONE")
            SendMessageToPC(oPC, GetLocalString(oMod, "LOGINMESSAGE"));

        SetLocalInt(oPC, "VARIABLES_INITIALIZED", TRUE);
    }

    RemoveSleepBlindness(oPC);
    ExecuteScript("exe_nwnxchatent", oPC); //NWNX Chat Handler
    ExecuteScript("exe_staffupd", oPC); //Update staff member variables.
    ExecuteScript("x3_mod_pre_enter",OBJECT_SELF); // Horse handling.
    DelayCommand(3.0, TK_HiPS_OnClientEnter(oPC));
    MothTimeLockCleaner(oPC);
    MothBanWandCheck(oPC,oMod);
    MothRestorePlotWeapon(oPC);
    MothRemovePolymorph(oPC);
    DelayCommand(8.0,MothUpdateHideFeats(oPC));
    zep_Dismount(oPC);
    RemoveRelics(oPC);
    DelayCommand(10.0, CheckPlayerTeam(oPC));

    if(nCurrentHitPoints > nHitPointsAtLastLogin) //Restore previous hit points.
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nCurrentHitPoints - nHitPointsAtLastLogin, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oPC);
    }

    nAppearance = GetLocalInt(oPC, "DEFAULT_APPEARANCE"); //Restore the character's appearance with each login.
    SetCreatureAppearanceType(oPC, nAppearance);

    DelayCommand(2.5, SendMessageToAllDMs("** Player " + sPlayerName + ", Char " + sName + ", CD-Key " + GetPCPublicCDKey(oPC) + " joined.\nXP: " +
        IntToString(GetXP(oPC)) + ". Gold: " + IntToString(GetGold(oPC))+ "."));

}

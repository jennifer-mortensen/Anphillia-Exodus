#include "x3_inc_horse"
#include "moth_inc_puzzle"
#include "_inc_subrace"
#include "_inc_time"
#include "_inc_const"
#include "_inc_db"

void ApplySleepEffects(object oPC);
int CancelRestIfMounted(object oPC);
void Cleanup(object oPC);
int GetIsTooSoonToRest(object oPC, int nSecondsBetweenRests);
void RemoveSleepBlindness(object oPC);
void CleanupSummons(object oPC);

void main()
{
    int SECONDS_BETWEEN_RESTS = 840;

    object oPC = GetLastPCRested();

    if(GetIsDM(oPC))
        return;

    int nLastRestType = GetLastRestEventType();
    int nFreeRest = GetLocalInt(GetArea(oPC), "FREE_REST_AREA");
    int nTime = GetSecondsSinceServerBoot();
    int nCancelRest;
    int nRestCount;

    switch(nLastRestType)
    {
        case REST_EVENTTYPE_REST_STARTED:
            nRestCount = GetLocalInt(oPC, "REST_COUNT");
            nRestCount++;
            SetLocalInt(oPC, "REST_COUNT", nRestCount);
            nCancelRest = CancelRestIfMounted(oPC);
            if(nCancelRest)
                return;
            if(nFreeRest == FALSE)
            {
                nCancelRest = GetIsTooSoonToRest(oPC, SECONDS_BETWEEN_RESTS);
                if(nCancelRest)
                    return;
                ApplySleepEffects(oPC);
            }
            else
            {
                DeleteLocalInt(oPC, "LAST_REST");
            }
            CleanupSummons(oPC);
            break;
        case REST_EVENTTYPE_REST_FINISHED:
            RefreshSubraceSpells(oPC);
            RemoveSleepBlindness(oPC);
            if(nFreeRest == FALSE)
                SetLocalInt(oPC, "LAST_REST", nTime);
            Cleanup(oPC);
            SavePCDatabaseVariables(oPC);
            ExportSingleCharacter(oPC);
            break;
        case REST_EVENTTYPE_REST_CANCELLED:
            if(GetLocalInt(oPC, "REST_CANCELLED_BY_SCRIPT") == FALSE)
            {
                SetLocalInt(oPC, "LAST_REST_CANCELLED", TRUE);
                if(nFreeRest == FALSE)
                    RemoveSleepBlindness(oPC);
            }
            else
            {
                DeleteLocalInt(oPC, "REST_CANCELLED_BY_SCRIPT");
                DeleteLocalInt(oPC, "LAST_REST_CANCELLED");
            }
    }
}

void ApplySleepEffects(object oPC)
{
    effect eVFXSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    int nRacialType = GetRacialType(oPC);
    int nTime = GetSecondsSinceServerBoot();

    if(nRacialType != RACIAL_TYPE_ELF || nRacialType != RACIAL_TYPE_HALFELF) //Elves and Half-Elves do not snore.
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFXSnore, oPC, 7.0);
        DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFXSnore, oPC, 7.0));
    }
    if(FADE_TO_BLACK_ON_REST == TRUE)
        FadeToBlack(oPC, FADE_SPEED_SLOW);
    else
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBlindness(), oPC);
    SetCommandable(FALSE, oPC);
    SetLocalInt(oPC, "LAST_REST", nTime);
}

int CancelRestIfMounted(object oPC)
{
    //Do not allow a mounted PC to rest.
    if(HorseGetIsMounted(oPC))
    {
        if(GetLocalInt(oPC, "X3_REST_CANCEL_MESSAGE_SENT")) //Cancel message already sent.
        {
            DeleteLocalInt(oPC,"X3_REST_CANCEL_MESSAGE_SENT");
        }
        else //Send cancel message.
        {
            FloatingTextStrRefOnCreature(112006, oPC, FALSE);
            SetLocalInt(oPC,"X3_REST_CANCEL_MESSAGE_SENT", TRUE);
        }
        AssignCommand(oPC, ClearAllActions(TRUE));
        SetLocalInt(oPC, "REST_CANCELLED_BY_SCRIPT", TRUE);
        return TRUE;
    }
    return FALSE;
}

void Cleanup(object oPC)
{
    MothResetCards(oPC);
    //MothSetShifterLevels(oPC);
    //MothSetRDDLevels(oPC);
    DeleteLocalInt(oPC,"ShifterHealSpell");
    DeleteLocalInt(oPC,"selfharm");
    DeleteLocalInt(oPC,"mothstonehold");
    DeleteLocalInt(oPC,"mothpdkblocksummon");
    DeleteLocalInt(oPC,"mothgenblocksummon");
    DeleteLocalInt(oPC, "MothInvisPurge");
    SetLocalInt(oPC, "FirstHorseCall", TRUE);
    DeleteLocalInt(oPC, "PDKHeroicTracking");
    DelayCommand(0.1,DeleteLocalInt(oPC,"BLOODBINDING"));
    DeleteLocalInt(oPC,"MothHadTriggeredRandom");
    DeleteLocalInt(oPC,"FocusDancer");
    DeleteLocalInt(oPC, "MothSpecDrain");
    DeleteLocalInt(oPC, "MothVampDom");
    DeleteLocalInt(oPC,"MothAuraOfCourage");
    DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE");
    DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE2");
    DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE3");
    DeleteLocalInt(oPC,"MOTHGREATFAITH");
    DeleteLocalInt(oPC,"MOTHIGNOREPAIN");
    DeleteLocalInt(oPC,"MOTHIPERFECTHEALTH");
    DeleteLocalInt(oPC,"MOTHTHREAD");
    DeleteLocalInt(oPC, "LAST_REST_CANCELLED");
    DeleteLocalInt(oPC, "REST_CANCELLED_BY_SCRIPT");
    if (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC) >= 11)
    {
        SetLocalInt(oPC,"MothChampStart",0);
    }
    if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC) >= 10)
    {
        SetLocalInt(oPC,"MothPDKStartFear",0);
        SetLocalInt(oPC,"MothPDKStartCourage",0);
        SetLocalInt(oPC,"MothPDKStartRally",0);
        SetLocalInt(oPC,"MothPDKStartStand",0);
        SetLocalInt(oPC,"MothPDKStartWrath",0);
    }

}

void CleanupSummons(object oPC)
{
    string sCDKEY = GetPCPublicCDKey(oPC);

    object oMount = HorseGetPaladinMount(oPC);
    if (!GetIsObjectValid(oMount))
        oMount=GetLocalObject(oPC, "oX3PaladinMount");

    if(GetLocalInt(oPC, "MOTHGREATOAK") == TRUE) //Destroy druid ent.
    {

        object oOak = GetObjectByTag(sCDKEY);
        if(GetRacialType(oOak) == RACIAL_TYPE_MAGICAL_BEAST)
        {
            DestroyObject(oOak);
        }
    }
    if (GetIsObjectValid(oMount)) //Destroy paladin mount.
    {
        if (oMount == oPC || !GetIsObjectValid(GetMaster(oMount)))
        {
            AssignCommand(oPC, HorseUnsummonPaladinMount());
        }
        else
        {
            AssignCommand(GetMaster(oMount), HorseUnsummonPaladinMount());
        }
    }

    DelayCommand(0.1,DeleteLocalInt(oPC,"MOTHGREATOAK"));
}

int GetIsTooSoonToRest(object oPC, int nSecondsBetweenRests)
{
    //object oMod = GetModule();
    int nTime = GetSecondsSinceServerBoot();
    int nLastRestCancelled = GetLocalInt(oPC, "LAST_REST_CANCELLED");
    int nLastRest = GetLocalInt(oPC, "LAST_REST");
    string sName = GetName(oPC);
    string sRestFailText = sName + " is not tired enough.";

    if((nTime - nLastRest) < 60 && nLastRestCancelled == TRUE) //It's been less than a minute since the last rest attempt.  Let the PC rest.
    {
        return FALSE;
    }

    if(nLastRest && ((nLastRest + nSecondsBetweenRests) > nTime))
    {
        AssignCommand(oPC, ClearAllActions());
        sRestFailText += " Try again in ";
        if(((nSecondsBetweenRests+nLastRest)-nTime)/FloatToInt(HoursToSeconds(1)) > 0)
            sRestFailText+=IntToString(((nSecondsBetweenRests+nLastRest)-nTime)/120) + " hours.";
        else if( (((nSecondsBetweenRests+nLastRest)-nTime)/120)/60 > 0)
            sRestFailText+=IntToString((((nSecondsBetweenRests+nLastRest)-nTime)/120)/60) + " minutes.";
        else
            sRestFailText+=IntToString((nSecondsBetweenRests+nLastRest)-nTime)+" seconds.";
        FloatingTextStringOnCreature("<cþ¥ >" + sRestFailText + "</c>", oPC, FALSE);
        SetLocalInt(oPC, "REST_CANCELLED_BY_SCRIPT", TRUE);
        return TRUE;
    }
    return FALSE;
}

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

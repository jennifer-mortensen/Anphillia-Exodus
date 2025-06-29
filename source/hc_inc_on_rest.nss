// PLACEHOLDER
#include "moth_inc"
#include "moth_inc_spells"
#include "zep_inc_phenos2"
#include "moth_inc_puzzle"
int preEvent()
{
    object oPC = GetLastPCRested();
    object oArea;
    object oHealer;
    object oMod = GetModule();
    int nwn_rest = 0;

    oHealer = GetNearestObjectByTag ("KaliaCain", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }

    oHealer = GetNearestObjectByTag ("ElrielDesifer", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }

    oHealer = GetNearestObjectByTag ("ClaraFenson", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }

    oHealer = GetNearestObjectByTag ("WanreDLloth", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }

    oHealer = GetNearestObjectByTag ("Wacoel", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }
    oHealer = GetNearestObjectByTag ("NiccaRest", oPC);
    if (GetIsObjectValid (oHealer))
    {
        if (GetCurrentHitPoints (oHealer) > 0)
            nwn_rest = 1;
    }

    if (nwn_rest) {
        // InitRestVariables();

        if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
        {
            if(!GetIsDM(oPC))
                SetLocalInt(oMod, ("LastRest" + GetName(oPC) + GetPCPublicCDKey(oPC)),0);
        MothResetCards(oPC);
        zep_Dismount(oPC);
        MothSetShifterLevels(oPC);
        MothSetRDDLevels(oPC);
        DeleteLocalInt(oPC,"RDDHealSpell");
        DeleteLocalInt(oPC,"ShifterHealSpell");
        DeleteLocalInt(oPC,"FocusDancer");
        DeleteLocalInt(oPC,"MothInvisPurge");
        DeleteLocalInt(oPC,"mothpdkblocksummon");
        DeleteLocalInt(oPC,"mothgenblocksummon");
        DeleteLocalInt(oPC,"selfharm");
        DeleteLocalInt(oPC,"mothstonehold");
        DeleteLocalInt(oPC, "MothSpecDrain");
        DeleteLocalInt(oPC, "MothVampDom");
        DeleteLocalInt(oPC,"MothHadTriggeredRandom");
        SetLocalInt(oPC, "FirstHorseCall",TRUE);
        DeleteLocalInt(oPC, "PDKHeroicTracking");
        DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE");
        DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE2");
        DeleteLocalInt(oPC,"MOTHFIGTHERCHARGE3");
        DeleteLocalInt(oPC,"MOTHGREATFAITH");
        if(GetLocalInt(oPC,"MOTHGREATOAK")==TRUE)
        {
          string sCDKEY = GetPCPublicCDKey(oPC);
          object oOak = GetObjectByTag(sCDKEY);
          if(GetRacialType(oOak) == RACIAL_TYPE_MAGICAL_BEAST)
            {
             DestroyObject(oOak);
            }
        }
        DelayCommand(0.1,DeleteLocalInt(oPC,"MOTHGREATOAK"));
        DeleteLocalInt(oPC,"MOTHIGNOREPAIN");
        DeleteLocalInt(oPC,"MOTHIPERFECTHEALTH");
        DeleteLocalInt(oPC,"MOTHTHREAD");
        if (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC) >= 11)
        {
        SetLocalInt(oPC,"MothChampStart",0);
        }
        if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC) >1)
        {
            DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC));
        }
        if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC) >= 10)
        {
        SetLocalInt(oPC,"MothPDKStartFear",0);
        SetLocalInt(oPC,"MothPDKStartCourage",0);
        SetLocalInt(oPC,"MothPDKStartRally",0);
        SetLocalInt(oPC,"MothPDKStartStand",0);
        SetLocalInt(oPC,"MothPDKStartWrath",0);
        }
        DeleteLocalInt(oPC,"MothAuraOfCourage");
        }
        int nLastRestType=GetLastRestEventType();

        return 0;
    }

    return 1;
}


void postEvent()
{
    return;
}
//void main() {}

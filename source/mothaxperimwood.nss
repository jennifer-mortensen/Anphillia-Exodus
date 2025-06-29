void main()
{
    if(GetLocalInt(OBJECT_SELF, "recentlytriggered"))
    {
    return;
    }
    object oTriggeringObj = GetEnteringObject();
    if (GetIsPossessedFamiliar(oTriggeringObj) == TRUE)
    {
        UnpossessFamiliar(GetMaster());
        UnpossessFamiliar(oTriggeringObj);
        return;
    }
    if (GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_EVIL)
    {
        return;
    }
    if(GetIsDM(oTriggeringObj) == TRUE)
    {
        return;
    }
    //J. Persinne; players can now evade the scouts.
    int nSuccessfulEvasion = FALSE;
    int nInStealth = GetActionMode(oTriggeringObj, ACTION_MODE_STEALTH);

    if(nInStealth && GetIsPC(oTriggeringObj) && GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_GOOD)
    {
        int nScoutSpot = 90 + d20();
        int nScoutListen = 90 + d20();
        int nPCHide = GetSkillRank(SKILL_HIDE, oTriggeringObj) + d20();
        int nPCMoveSilently = GetSkillRank(SKILL_MOVE_SILENTLY, oTriggeringObj) + d20();
        if(nPCHide > nScoutSpot && nPCMoveSilently > nScoutListen)
            nSuccessfulEvasion = TRUE;
    }

    if (GetIsPC(oTriggeringObj) == TRUE &&
             GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_GOOD &&
             nSuccessfulEvasion)
    {
        FloatingTextStringOnCreature("You have successfully evaded Axfell's scouts!", oTriggeringObj, FALSE); //J. Persinne; feedback message.
    }
    else if (GetIsPC(oTriggeringObj) == TRUE &&
             GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_GOOD)
    {
        FloatingTextStringOnCreature("You have failed to evade Axfell's scouts!", oTriggeringObj, FALSE); //J. Persinne; feedback message.
        object oPC = GetFirstPC();
        float fDelay = 45.0;
        while (GetIsObjectValid(oPC))
        {
            AssignCommand (oPC, PlaySound("as_an_wolfhowl1"));
            SendMessageToPC(oPC, "<c  þ>[Faction] Druids have sighted Cleavens in Axfell territories!</c>");
            oPC = GetNextPC();
        }
        SetLocalInt(OBJECT_SELF, "recentlytriggered", TRUE);
        DelayCommand(fDelay, DeleteLocalInt(OBJECT_SELF, "recentlytriggered"));
        return;
    }
    else return;
}

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
    if (GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_GOOD)
    {
        return;
    }
    if(GetIsDM(oTriggeringObj) == TRUE)
    {
        return;
    }
    if (GetIsPC(oTriggeringObj) == TRUE &&
             GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_EVIL)
    {
        FloatingTextStringOnCreature("You have failed to evade Cleaven's scouts!", oTriggeringObj, FALSE); //J. Persinne; feedback message.
        object oPC = GetFirstPC();
        float fDelay = 45.0;
        while (GetIsObjectValid(oPC))
        {
            AssignCommand (oPC, PlaySound("as_an_wolfhowl1"));
            SendMessageToPC(oPC, "<c  þ>[Faction] Scouts have sighted Axfell in Cleaven territories!</c>");
            oPC = GetNextPC();
        }
        SetLocalInt(OBJECT_SELF, "recentlytriggered", TRUE);
        DelayCommand(fDelay, DeleteLocalInt(OBJECT_SELF, "recentlytriggered"));
        return;
    }
    else return;
}

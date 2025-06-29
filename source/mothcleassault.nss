void main()
{
    if(GetLocalInt(OBJECT_SELF, "recentlytriggered"))
    {
    return;
    }
    object oTriggeringObj = GetEnteringObject();
    if(!GetIsPC(oTriggeringObj))
    {
    return;
    }
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
    if (GetAlignmentGoodEvil(oTriggeringObj) == ALIGNMENT_EVIL)
    {
        object oPC = GetFirstPC();
        float fDelay = 90.0;
        while (GetIsObjectValid(oPC))
        {
            AssignCommand (oPC, PlaySound("as_an_wolfhowl1"));
            SendMessageToPC(oPC, "<c  þ>[Faction] Axfells are assaulting Cleaven!</c>");
            oPC = GetNextPC();
        }
        SetLocalInt(OBJECT_SELF, "recentlytriggered", TRUE);
        DelayCommand(fDelay, DeleteLocalInt(OBJECT_SELF, "recentlytriggered"));
        return;
    }
    else return;
}

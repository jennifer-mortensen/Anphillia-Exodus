void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
        return;

    string sTag = GetTag(OBJECT_SELF);
    if(GetLocalInt(oPC, sTag) == 1)
        return;

    string sText = "<cðøþ>" + GetLocalString(OBJECT_SELF, "NARRATIVE_TEXT") + "</c>";
    SetLocalInt(oPC, sTag, TRUE);
    FloatingTextStringOnCreature(sText, oPC, FALSE);
}

void main()
{
    object oPC = GetPCSpeaker();
    ExecuteScript("x3_s3_palmount",oPC);
    SetLocalInt(oPC,"mothpdkblocksummon",TRUE);
}

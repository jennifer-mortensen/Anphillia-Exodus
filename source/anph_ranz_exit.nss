void main()
{
    object oPC = GetLastUsedBy ();
    object oTarget = GetObjectByTag ("AnphExitWaypt");
    SetLocalInt(oPC, "RanzPaid", 0);

    AssignCommand (oPC, ActionJumpToObject (oTarget));
}

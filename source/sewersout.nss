void main()
{
    object oPC;
    object oTarget;
    oPC = GetLastUsedBy();


        oTarget = GetObjectByTag("RanzSewersOut");

    AssignCommand(oPC,JumpToObject(oTarget));
}

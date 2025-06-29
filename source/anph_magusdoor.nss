void main()
{
    object oPC = GetLastUsedBy();
    object oTarget = GetWaypointByTag("ranzoutofmagus222");
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC,JumpToObject(oTarget));
}

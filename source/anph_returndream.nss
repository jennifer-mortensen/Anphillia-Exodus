void main()
{
   object oPC = GetLastUsedBy();
   object oTarget = GetObjectByTag("ChooseSideLocation");
    AssignCommand(oPC, JumpToObject(oTarget));
}

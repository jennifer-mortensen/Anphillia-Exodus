
void main()
{
    object oPC;

    oPC = GetLastUsedBy();


    object oDest = GetObjectByTag ("InsaneMageLairStart");
    AssignCommand(oPC, JumpToObject(oDest));
}

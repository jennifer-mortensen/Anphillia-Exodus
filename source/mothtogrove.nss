void main()
{
    object oUser = GetLastUsedBy();
    AssignCommand(oUser, ClearAllActions(TRUE));
    AssignCommand(oUser, JumpToObject(GetObjectByTag("MothToGrove")));
}

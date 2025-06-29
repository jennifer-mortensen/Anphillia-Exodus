
void main()
{
    object oPC;

    oPC = GetLastUsedBy();

    string Destination = GetLocalString(GetModule(), "InsanePortal");
    if (Destination == "")
    {
        Destination = "InsanePoint" + IntToString(d6());
        SetLocalString(GetModule(), "InsanePortal", Destination);
        DelayCommand(60.0, DeleteLocalString(GetModule(), "InsanePortal"));
    }
    object oDest = GetObjectByTag (Destination);
    AssignCommand(oPC, JumpToObject(oDest));
}

void main()
{
    object oPC = GetLastUsedBy ();
    string sName = GetName (oPC);

    FloatingTextStringOnCreature ("You bang the gong..", oPC);
    PlaySound ("as_cv_gongring3");

    int nGongBanged = GetLocalInt (oPC, "GongBanged");
    if (nGongBanged)
    {
        return;
    }
    SetLocalInt (oPC, "GongBanged", 1);
    DelayCommand (60.0, DeleteLocalInt (oPC, "GongBanged"));

    SendMessageToAllDMs (sName + " wants into ranzington!");
}

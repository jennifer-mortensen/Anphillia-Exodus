void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetObjectByTag("mothaxfellcrypt44");
    SetLocked(oDoor,FALSE);
    FloatingTextStringOnCreature("<cðøþ>*You hear a clicking sound!*</c>",oPC);
    DelayCommand(1.5,SetUseableFlag(OBJECT_SELF,FALSE));
}

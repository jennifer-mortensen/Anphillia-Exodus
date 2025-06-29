void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetObjectByTag("serisscatterdquestdoor2");
    effect eEffect = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eEffect2 = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    SetLocked(oDoor,FALSE);
    FloatingTextStringOnCreature("<cðøþ>*You hear a clicking sound!*</c>",oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oDoor);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect2,OBJECT_SELF,4.0);
    DelayCommand(1.5,SetUseableFlag(OBJECT_SELF,FALSE));
}

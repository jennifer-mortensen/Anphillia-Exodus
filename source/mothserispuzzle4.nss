void main()
{
    object oPC = GetLastUsedBy();
    object oDoor = GetObjectByTag("serisscatterdquestdoor4");
    effect eEffect = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eEffect2 = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    SetLocked(oDoor,FALSE);
    FloatingTextStringOnCreature("<cðøþ>*You hear a clicking sound followed by a ticking sound!*</c>",oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oDoor);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect2,OBJECT_SELF,4.0);
    DelayCommand(1.5,SetUseableFlag(OBJECT_SELF,FALSE));
}

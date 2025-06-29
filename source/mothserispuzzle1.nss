void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetObjectByTag("serisscatterdquestdoor1");
    object oBeamer = GetObjectByTag("serisbeamerone");
    effect eEffect = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eEffect2 = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    SetLocked(oDoor,FALSE);
    AssignCommand(oBeamer,ActionCastSpellAtObject(SPELL_SEARING_LIGHT,OBJECT_SELF,METAMAGIC_ANY,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
    FloatingTextStringOnCreature("<cðøþ>*You hear a clicking sound!*</c>",oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oDoor);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect2,OBJECT_SELF,4.0);
    DelayCommand(1.5,SetUseableFlag(OBJECT_SELF,FALSE));
    DelayCommand(1.6,DestroyObject(oBeamer));
}

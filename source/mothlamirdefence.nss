void main()
{
    object oEnter = GetEnteringObject();
    object oSentinel = GetObjectByTag("LamirSentinel");
    if (GetIsPC(oEnter)) return;
    if(GetRacialType(oEnter)==RACIAL_TYPE_UNDEAD)
    {
     if(!GetIsPC(oEnter))
     {
         effect eDam = EffectDamage(999+d20(3), DAMAGE_TYPE_DIVINE);
         effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
         if(!GetIsDead(oEnter))
         {
          AssignCommand(oSentinel,ActionCastSpellAtObject(SPELL_SEARING_LIGHT,oEnter,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
          DelayCommand(0.6,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnter));
          DelayCommand(0.6,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oEnter));
         }
     }
    }
}

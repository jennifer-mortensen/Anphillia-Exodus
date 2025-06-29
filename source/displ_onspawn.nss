void main()
{
   effect eConceal = EffectConcealment(50);
   effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
   effect eEffect = EffectLinkEffects(eConceal, eVis);
   DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, OBJECT_SELF));
}

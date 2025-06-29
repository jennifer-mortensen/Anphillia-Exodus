void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(80), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), OBJECT_SELF);

    DelayCommand(4.5,DestroyObject(OBJECT_SELF));
    DelayCommand(5.0,DestroyObject(OBJECT_SELF));
}

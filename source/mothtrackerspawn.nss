void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),
                        OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneGhost(),
                        OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED),
                        OBJECT_SELF);
}

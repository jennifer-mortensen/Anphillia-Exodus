int VFX_INVIS_CIRCLE_20M = 193;

void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAreaOfEffect(VFX_INVIS_CIRCLE_20M, "aur_acidresista", "", "aur_acidresistb")), OBJECT_SELF);
}

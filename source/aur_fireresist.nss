int VFX_INVIS_CIRCLE_20M = 193;

void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAreaOfEffect(VFX_INVIS_CIRCLE_20M, "aur_fireresista", "", "aur_fireresistb")), OBJECT_SELF);
}

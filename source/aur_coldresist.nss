int VFX_INVIS_CIRCLE_20M = 193;

void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAreaOfEffect(VFX_INVIS_CIRCLE_20M, "aur_coldresista", "", "aur_coldresistb")), OBJECT_SELF);
}

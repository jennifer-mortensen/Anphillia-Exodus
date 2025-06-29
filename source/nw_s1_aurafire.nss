#include "x0_i0_spells"
void main()
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_FIRE);
    int nDuration =10;
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(nDuration));
}

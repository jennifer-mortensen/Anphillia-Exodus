#include "x0_i0_spells"
void main()
{
    if (!GetHasFeat(FEAT_BARBARIAN_RAGE, OBJECT_SELF))
    {
        FloatingTextStringOnCreature("<cðøþ>*No more Rages left!*</c>",OBJECT_SELF,FALSE);
        return;
    }
    else
    {
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARBARIAN_RAGE);
        effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
        location lTarget = GetLocation(OBJECT_SELF);
        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        int nCharismaBonus = GetAbilityModifier(ABILITY_CONSTITUTION);
        if (nCharismaBonus>0)
        {
            int nDamage1 = IPGetDamageBonusConstantFromNumber(nCharismaBonus);
            effect eDamage1 = EffectDamageIncrease(nDamage1,DAMAGE_TYPE_PIERCING);
            effect eLink = EffectLinkEffects(eDamage1, eDur);
            eLink = ExtraordinaryEffect(eLink);
            RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCharismaBonus+5)));
            DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
        }
   }
}

#include "x0_i0_spells"
void main()
{
   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
    FloatingTextStringOnCreature("<cðæŒ>*No more Turn Undead uses!*</c>",OBJECT_SELF);
   }
   else
   {
        object oTarget = GetSpellTargetObject();
        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        if (nCharismaBonus>0)
        {
            int nDurationBonus;
            object oBGEpicSummon = GetLocalObject(OBJECT_SELF, "BLACKGUARD_EPIC_SUMMON");
            float fDistance = GetDistanceToObject(oBGEpicSummon);
            if(fDistance != -1.0 && fDistance <= 20.0) //J. Persinne; Blackguards now gain a +5 round duration bonus while they are near their epic summon.
            {
                nDurationBonus = 5;
            }
            int nDamage1 = IPGetDamageBonusConstantFromNumber(nCharismaBonus);
            effect eDamage1 = EffectDamageIncrease(nDamage1,DAMAGE_TYPE_DIVINE);
            effect eLink = EffectLinkEffects(eDamage1, eDur);
            eLink = SupernaturalEffect(eLink);
            RemoveEffectsFromSpell(oTarget, GetSpellId());
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_MIGHT, FALSE));
            DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCharismaBonus+2+nDurationBonus)));
            DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}




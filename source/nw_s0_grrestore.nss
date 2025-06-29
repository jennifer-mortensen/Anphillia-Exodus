#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_bigby"
#include "moth_inc_spell2"
int GetIsSupernaturalCurse(effect eEff);

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    MothRemoveBigby(oTarget);
    MothRemoveSupernaturalStun(oTarget);
    MothRemoveDurationSpells(oTarget);
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PETRIFY ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED ||
            GetEffectType(eBad) == EFFECT_TYPE_MISS_CHANCE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE)
        {
            if(GetIsSupernaturalCurse(eBad)==FALSE && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    MothRemoveSupernaturalPermanentAbilityDecrease(oTarget);
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        effect eHeal = EffectHeal(250);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));
    MothRemovePetrify(oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    string sTag = GetTag(oCreator);
    if(sTag == "MothSubraceApplier" || sTag == "LIGHT_BLINDNESS_APPLIER")
        return TRUE;
    return FALSE;
}

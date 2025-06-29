#include "x0_i0_spells"
#include "moth_inc_spells"
#include "moth_inc_spell2"
#include "moth_inc_bigby"
int GetIsSupernaturalCurse(effect eEff);

void main()
{
    if(MothGetIsDisabled(OBJECT_SELF)){return;}
    int iTimer = GetLocalInt(OBJECT_SELF, "MOTHIPERFECTHEALTH");
    if (iTimer >= 1)
    {
    FloatingTextStringOnCreature("<cðøþ>*No focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    iTimer++;
    SetLocalInt(OBJECT_SELF, "MOTHIPERFECTHEALTH", iTimer);
    object oTarget = OBJECT_SELF;
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
            GetEffectType(eBad) == EFFECT_TYPE_TURNED ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED ||
            GetEffectType(eBad) == EFFECT_TYPE_MISS_CHANCE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
            if(GetIsSupernaturalCurse(eBad)==FALSE && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    MothRemoveSupernaturalPermanentAbilityDecrease(oTarget);
    effect eHeal = EffectHeal(GetHitDice(oTarget)*2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 838, FALSE));
    MothRemovePetrify(oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    if(GetTag(oCreator) == "MothSubraceApplier")
        return TRUE;
    return FALSE;
}

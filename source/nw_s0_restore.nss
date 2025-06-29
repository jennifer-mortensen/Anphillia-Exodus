#include "NW_I0_SPELLS"
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

    int iTimer = GetLocalInt(OBJECT_SELF, "MOTHRESTGARG");
    if (iTimer == TRUE)
    {
        FloatingTextStringOnCreature("<c ее>*No Restoration Focus!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
    }
    if (iTimer == FALSE)
    {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Restoration Focus is lost!</c>"));
        SetLocalInt(OBJECT_SELF, "MOTHRESTGARG", TRUE);
        DelayCommand(18.0, DeleteLocalInt(OBJECT_SELF, "MOTHRESTGARG"));
        DelayCommand(18.0, FloatingTextStringOnCreature("<c ее>*Restoration Focus Regained!*</c>",OBJECT_SELF,FALSE));
    }

    object oTarget = GetSpellTargetObject();
    MothRemoveBigby(oTarget);
    MothRemoveSupernaturalStun(oTarget);
    MothRemoveDurationSpells(oTarget);
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nHeal2 = d8(2)+16+nDuration;
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
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_MISS_CHANCE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE)
        {
            if(GetIsSupernaturalCurse(eBad)==FALSE && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        effect eHeal = EffectHeal(nHeal2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

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

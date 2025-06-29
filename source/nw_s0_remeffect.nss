#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_effects"
int GetIsSupernaturalCurse(effect eEff);
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nSpellID = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    if(nSpellID == SPELL_REMOVE_BLINDNESS_AND_DEAFNESS)
    {
        ExecuteScript("nw_s0_rmvblddef",OBJECT_SELF);
    }
    else if(nSpellID == SPELL_REMOVE_CURSE)
    {
       RemoveEffectsFromSpell(oTarget, 644);
       RemoveEffectsFromSpell(oTarget, SPELL_BESTOW_CURSE);
    }
    else if(nSpellID == SPELL_REMOVE_DISEASE || nSpellID == SPELLABILITY_REMOVE_DISEASE)
    {
       if(nSpellID == SPELL_REMOVE_DISEASE)
       {
          MothRemoveDisease(oTarget);
       }
       else if(nSpellID == SPELLABILITY_REMOVE_DISEASE)
       {
            effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
            int nHeal = GetHitDice(OBJECT_SELF);
            int nHeal2 = d8(4)+10+nHeal;
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
                    GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    if(GetIsSupernaturalCurse(eBad)==FALSE && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                        RemoveEffect(oTarget, eBad);
                }
                eBad = GetNextEffect(oTarget);
            }
            if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
                effect eHeal = EffectHeal(nHeal2);
                MothRemoveDisease(oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            }
       }
    }
    else if(nSpellID == SPELL_NEUTRALIZE_POISON)
    {
     effect eBad = GetFirstEffect(oTarget);
     while(GetIsEffectValid(eBad))
     {
        if (GetEffectType(eBad) == EFFECT_TYPE_POISON &&
            GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE
        )
        {
            if(GetIsSupernaturalCurse(eBad)==FALSE)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
     }
    }
    RemoveSpecificEffect(EFFECT_TYPE_POISON,oTarget);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    string sTag = GetTag(oCreator);
    if(sTag == "MothSubraceApplier" || sTag == "LIGHT_BLINDNESS_APPLIER")
        return TRUE;
    return FALSE;
}

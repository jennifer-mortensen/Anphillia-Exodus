//J. Persinne, 5/16/09; this spell now works again.

#include "x2_inc_spellhook"

int GetIsSupernaturalCurse(effect eEff);

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nType;
    effect eRemove = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_CURSE, FALSE));
    while(GetIsEffectValid(eRemove))
    {
        if(GetEffectType(eRemove) == EFFECT_TYPE_CURSE && !GetIsSupernaturalCurse(eRemove))
        {
            RemoveEffect(oTarget, eRemove);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        GetNextEffect(oTarget);
    }
}

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    string sTag = GetTag(oCreator);
    if(sTag == "MothSubraceApplier" || sTag == "LIGHT_BLINDNESS_APPLIER")
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
#include "x2_inc_spellhook"
int GetIsSupernaturalCurse(effect eEff);

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_DISEASE)
        {
            if(GetIsSupernaturalCurse(eBad)==FALSE && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_DISEASE, FALSE));

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

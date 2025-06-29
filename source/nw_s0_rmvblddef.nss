int GetIsSupernaturalCurse(effect eEff);
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eFear;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) || GetIsReactionTypeNeutral(oTarget))
        {
            eFear = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eFear))
            {
                if (GetEffectType(eFear) == EFFECT_TYPE_BLINDNESS ||
                    GetEffectType(eFear) == EFFECT_TYPE_DEAF)
                {
                    RemoveEffect(oTarget, eFear);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
                eFear = GetNextEffect(oTarget);
            }
       }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
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

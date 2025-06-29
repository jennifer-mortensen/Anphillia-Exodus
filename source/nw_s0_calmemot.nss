#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    effect eImpact1 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    location lLocation = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLocation);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) || GetIsReactionTypeNeutral(oTarget))
        {
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            MothApplyMindBlank(oTarget, GetSpellId(), GetRandomDelay());
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
    }
}


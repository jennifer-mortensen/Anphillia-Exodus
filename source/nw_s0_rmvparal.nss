#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nType;
    effect eParal;
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    int nCnt = 0;
    int nRemove = MothGetCasterLevel(OBJECT_SELF) / 3;
    nRemove += 1;
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget) && nCnt <= nRemove)
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) || GetIsReactionTypeNeutral(oTarget))
        {
            fDelay = GetRandomDelay();
            eParal = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eParal))
            {
               if (GetEffectType(eParal) == EFFECT_TYPE_PARALYZE||
                   GetEffectType(eParal) == EFFECT_TYPE_STUNNED||
                   GetEffectType(eParal) == EFFECT_TYPE_DAZED
               )
                {
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_PARALYSIS, FALSE));
                    RemoveEffect(oTarget, eParal);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    nCnt++;
                }
                eParal = GetNextEffect(oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eFear;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, 8, SAVING_THROW_TYPE_FEAR);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eLink = EffectLinkEffects(eMind, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration*2;
    }
    location lSpell = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/25;
    TLVFXPillar(VFX_FNF_LOS_HOLY_30,lSpell, 1, fDelay1, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20,lSpell, 1, fDelay1+0.4, 6.0f, 2.0f);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while (GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget))
        {
            fDelay = GetRandomDelay();
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_FEAR, FALSE));
            eFear = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eFear))
            {
                if (GetEffectType(eFear) == EFFECT_TYPE_FRIGHTENED)
                {
                    RemoveEffect(oTarget, eFear);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
                eFear = GetNextEffect(oTarget);
            }
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}


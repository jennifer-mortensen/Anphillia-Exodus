#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    if(GetIsObjectValid(oScroll))
    {
    return;
    }
    object oTarget;
    effect eVis1 = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DOOM);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eAttack = EffectAttackDecrease(2);
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    location lLoc = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lLoc, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_LOS_NORMAL_30,lLoc, 1, fDelay1, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lLoc, 1, fDelay1-0.3, 4.0f, 1.5f);
    TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lLoc, 1, fDelay1-0.7, 2.0f, 1.0f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc,TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
             SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 449, TRUE));
             if (!MyResistSpell(OBJECT_SELF, oTarget) )
             {
              fDelay = GetRandomDelay(0.3, 0.8);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(2)));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE);
    }
}


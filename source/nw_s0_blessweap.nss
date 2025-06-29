//stormwalker
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
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
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(oTarget);
    effect eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oTarget, BODY_NODE_CHEST);
    effect eHaste1 = EffectHaste();
    effect eHaste2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,nDuration);
    effect eHaste = EffectLinkEffects(eHaste1,eHaste2);
    effect eConcealment = EffectConcealment(20+nDuration,MISS_CHANCE_TYPE_VS_RANGED);
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur1 = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    eLink = EffectLinkEffects(eLink, eConcealment);
    int nMetaMagic = GetMetaMagicFeat();
    SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    if(MothGetIsFortAlly(oTarget))
    {
        TLVFXPillar(VFX_IMP_LIGHTNING_M,GetLocation(oTarget), 1, 0.0f, 0.0f);
        MothApplyStormwalker(oTarget,eLink,eVis,nDuration,GetSpellId());
        object oSummon2 = GetFirstObjectInArea();
        while(GetIsObjectValid(oSummon2))
        {
          if(MothGetIsAssociate(oSummon2) && GetMaster(oSummon2) == oTarget)
            {
            SignalEvent(oSummon2, EventSpellCastAt(oTarget, GetSpellId(), FALSE));
            MothApplyStormwalkerAlly(oSummon2,eBeam,eLink,eVis,nDuration,GetSpellId());
            }
           oSummon2 = GetNextObjectInArea();
        }
    }
}




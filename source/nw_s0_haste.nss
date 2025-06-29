#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
#include "x2_inc_toollib"
#include "_inc_const"

void ApplyHaste(object oTarget, int nDuration);

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    object oScroll = GetSpellCastItem();
    effect eHaste = EffectHaste();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
    int nTravelDomain = GetHasFeat(FEAT_TRAVEL_DOMAIN_POWER, OBJECT_SELF);
    //If RDD Warlock
    /*if(oTarget == OBJECT_SELF &&
       GetAppearanceType(OBJECT_SELF) == 1032||
       GetAppearanceType(OBJECT_SELF) == 1033
    )
    {
      int nRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
      if(nRDD>nDuration)
          {
           nDuration=nRDD;
          }
      eLink = ExtraordinaryEffect(eLink);
    }*/
    if(nPM>nDuration)
      {
       nDuration=nPM;
      }
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }

    //J. Persinne; uncomment this section if you need an insta-kill spell for testing.
    //if(oTarget != OBJECT_SELF && DEBUG_MODE == TRUE)
    //{
    //    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(9999), oTarget);
    //}

    if(!(nCleric == GetHitDice(OBJECT_SELF) && nTravelDomain && oScroll == OBJECT_INVALID))
    {
        if(MothGetIsFortAlly(oTarget) && MothHasteCheck(oTarget)==FALSE)
        {
            ApplyHaste(oTarget, nDuration);
        }
    }
    else //Mass Haste effect for pure level 40 clerics with the travel domain.
    {
        int nCount;
        location lSpell = GetLocation(oTarget);
        effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
        float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
        TLVFXPillar(VFX_FNF_LOS_NORMAL_30,lSpell, 1, fDelay1, 6.0f, 2.0f);
        TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lSpell, 1, fDelay1+0.4, 6.0f, 2.0f);
        DelayCommand(0.1,TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, 0.0f, 1.2f));
        DelayCommand(0.2,TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, 0.0f, 0.9f));
        DelayCommand(0.3,TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, 0.0f, 0.3f));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSpell);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
        while(GetIsObjectValid(oTarget) && nCount != nDuration)
        {
            if(MothGetIsFortAlly(oTarget) && MothHasteCheck(oTarget)==FALSE)
            {
                ApplyHaste(oTarget, nDuration);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
                nCount++;
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
        }
    }
}

void ApplyHaste(object oTarget, int nDuration)
{
    effect eHaste = EffectHaste();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
    MothPreHaste(oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+5));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eHaste = EffectHaste();
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
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
    }*/
    if(nPM>nDuration)
      {
       nDuration=nPM;
      }
    int nCount;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    location lSpell = GetSpellTargetLocation();
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
            if(GetAppearanceType(oTarget) == 1032||
               GetAppearanceType(oTarget) == 1033)
            {
             eLink = ExtraordinaryEffect(eLink);
            }
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            MothPreHaste(oTarget);
            fDelay = GetRandomDelay(0.0, 1.0);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HASTE, FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+10)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            nCount++;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}



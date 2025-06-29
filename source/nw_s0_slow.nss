#include "x2_inc_toollib"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eSlow = EffectSlow();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eSlow, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    if(nPM>nDuration)
      {
       nDuration=nPM;
      }
    int nLevel = nDuration;
    int nCount = 0;
    location lSpell = GetSpellTargetLocation();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_HOWL_ODD,lSpell, 2, fDelay1, 5.0f, 1.5f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact,lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while(GetIsObjectValid(oTarget) && nCount < nLevel)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLOW));
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                nCount++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}


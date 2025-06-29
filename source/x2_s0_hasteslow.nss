#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (d100() > 33)
    {
        object oTarget = GetSpellTargetObject();
        effect eHaste = EffectHaste();
        effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eHaste, eDur);

        int nDuration = MothGetCasterLevel(OBJECT_SELF);
        int nPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
        if(nPM>nDuration)
          {
           nDuration=nPM;
          }
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    else
    {
        object oTarget1 = GetSpellTargetObject();
        effect eSlow = EffectSlow();
        effect eDur1 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink1 = EffectLinkEffects(eSlow, eDur1);
        effect eVis1 = EffectVisualEffect(VFX_IMP_SLOW);
        effect eImpact1 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
        int nDuration1 = MothGetCasterLevel(OBJECT_SELF);
        SignalEvent(oTarget1, EventSpellCastAt(OBJECT_SELF, SPELL_SLOW, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink1, oTarget1, RoundsToSeconds(nDuration1));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget1);
    }
}



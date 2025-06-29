#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    int nPureDruid = FALSE;
    if(MothGetIsPureClass(CLASS_TYPE_DRUID,OBJECT_SELF))
      {
       nPureDruid = TRUE;
      }
    if(GetIsObjectValid(oScroll))
      {
        nPureDruid = FALSE;
      }
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eHP = EffectTemporaryHitpoints(nDuration);
    if(GetRacialType(oTarget)==RACIAL_TYPE_ANIMAL ||
       GetRacialType(oTarget)==RACIAL_TYPE_DRAGON)
      {
       if(nPureDruid == TRUE)
       {
        eHP = EffectTemporaryHitpoints(nDuration*2);
       }
      }
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHP, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VIRTUE, FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}


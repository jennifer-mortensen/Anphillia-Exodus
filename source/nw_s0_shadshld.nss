#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    if(GetSpellId()==598)//if Harper Spell
    {
     nDuration = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF);
    }
    int nMetaMagic = GetMetaMagicFeat();
    //If Epic Drider
    if(GetAppearanceType(OBJECT_SELF) == 1211
       || GetAppearanceType(OBJECT_SELF) == 1213
       || GetAppearanceType(OBJECT_SELF) == 131
       || GetAppearanceType(OBJECT_SELF) == 133
       )
    {
        nDuration *= 2;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration *= 2;
    }
    effect eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_THREE);
    effect eAC = EffectACIncrease(5, AC_NATURAL_BONUS);
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_WARD);
    effect eShadow = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eSpell = EffectSpellLevelAbsorption(9, 0, SPELL_SCHOOL_NECROMANCY);
    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
    effect eImmNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eStone, eAC);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eShadow);
    eLink = EffectLinkEffects(eLink, eImmDeath);
    eLink = EffectLinkEffects(eLink, eImmNeg);
    eLink = EffectLinkEffects(eLink, eDur);
    if(GetIsObjectValid(oScroll))
    {
      int nDice = d100();
      if(nDice>33)
      {
       eLink = EffectLinkEffects(eLink, eSpell);
      }
    }
    else
    {
    eLink = EffectLinkEffects(eLink, eSpell);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHADOW_SHIELD, FALSE));
    oTarget = OBJECT_SELF;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}


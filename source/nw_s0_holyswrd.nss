#include "NW_I0_SPELLS"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
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
    object oTarget = OBJECT_SELF;
    int nDuration = MothGetCasterLevel(oTarget);
    int nLevel = nDuration;
    effect eVis1 = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eVis = EffectLinkEffects(eVis1, eVis2);
    int nMetaMagic = GetMetaMagicFeat();
    effect eArmor1 = EffectSpellImmunity(SPELL_GREASE);
    effect eArmor2 = EffectSpellImmunity(SPELL_ENTANGLE);

    effect eArmor3 = EffectSpellImmunity(SPELL_WEB);
    effect eArmor4 = EffectSpellImmunity(SPELL_SPIKE_GROWTH);

    effect eArmor5 = EffectSpellImmunity(SPELL_VINE_MINE);
    effect eArmor6 = EffectSpellImmunity(SPELL_VINE_MINE_ENTANGLE);
    effect eArmor7 = EffectSpellImmunity(SPELL_VINE_MINE_HAMPER_MOVEMENT);

    effect eArmor8 = EffectSpellImmunity(SPELL_CREEPING_DOOM);

    effect eArmor = EffectLinkEffects(eArmor1,eArmor2);
    if(nDuration>20)
      {
       eArmor = EffectLinkEffects(eArmor,eArmor3);
       eArmor = EffectLinkEffects(eArmor,eArmor4);
      }
    if(nDuration>30)
      {
        eArmor = EffectLinkEffects(eArmor,eArmor3);
        eArmor = EffectLinkEffects(eArmor,eArmor4);
        eArmor = EffectLinkEffects(eArmor,eArmor5);
        eArmor = EffectLinkEffects(eArmor,eArmor6);
        eArmor = EffectLinkEffects(eArmor,eArmor7);
      }
    if(nDuration>39)
      {
        eArmor = EffectLinkEffects(eArmor,eArmor3);
        eArmor = EffectLinkEffects(eArmor,eArmor4);
        eArmor = EffectLinkEffects(eArmor,eArmor5);
        eArmor = EffectLinkEffects(eArmor,eArmor6);
        eArmor = EffectLinkEffects(eArmor,eArmor7);
        eArmor = EffectLinkEffects(eArmor,eArmor8);
      }
    effect eDur1 = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    effect eLink = EffectLinkEffects(eArmor, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    DeleteLocalInt(oTarget,"MOTHGOLEMWALKINT");
    TLVFXPillar(VFX_IMP_KNOCK,GetLocation(oTarget),1,0.1,0.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*2));
    SetLocalInt(oTarget,"MOTHGOLEMWALKINT",nLevel);
}


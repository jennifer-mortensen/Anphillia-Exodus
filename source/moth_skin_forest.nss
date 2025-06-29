#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis1 = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eImmune;
    effect eSpellImmune;
    effect eSpellImmune2;
    int nImmune;
    int nSpellImmune;
    int nSpellImmune2;
    object oScroll = GetSpellCastItem();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    if(GetIsObjectValid(oScroll))
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell from an Item.</c>");
     return;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if(nSpell == 572)
    {
      nImmune = IMMUNITY_TYPE_BLINDNESS;
      nSpellImmune = SPELL_SEARING_LIGHT;
      nSpellImmune2 = SPELL_WORD_OF_FAITH;
    }
    else if (nSpell == 573)
    {
      nImmune = IMMUNITY_TYPE_DEAFNESS;
      nSpellImmune = SPELL_PHANTASMAL_KILLER;
      nSpellImmune2 = SPELL_VAMPIRIC_TOUCH;
    }
    else if (nSpell == 574)
    {
      nImmune = IMMUNITY_TYPE_PARALYSIS;
      nSpellImmune = SPELL_FLESH_TO_STONE;
      nSpellImmune2 = 581; //Cockatrices Touch
    }
    else if (nSpell == 575)
    {
      nImmune = IMMUNITY_TYPE_POISON;
      nSpellImmune = SPELL_ISAACS_LESSER_MISSILE_STORM;
      nSpellImmune2 = SPELL_MAGIC_MISSILE;
    }
    else if (nSpell == 576)
    {
      nImmune = IMMUNITY_TYPE_MIND_SPELLS;
      nSpellImmune = SPELL_COMBUST;
      nSpellImmune2 = SPELL_MELFS_ACID_ARROW;
    }
    eImmune = EffectImmunity(nImmune);
    eSpellImmune = EffectSpellImmunity(nSpellImmune);
    eSpellImmune2 = EffectSpellImmunity(nSpellImmune2);
    effect eLink = EffectLinkEffects(eImmune,eSpellImmune);
    eLink = EffectLinkEffects(eLink,eSpellImmune2);
    RemoveEffectsFromSpell(oTarget, 572);
    RemoveEffectsFromSpell(oTarget, 573);
    RemoveEffectsFromSpell(oTarget, 574);
    RemoveEffectsFromSpell(oTarget, 575);
    RemoveEffectsFromSpell(oTarget, 576);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}


#include "moth_inc"
void RemoveEffectsFromSpell(object oTarget, int SpellID)
{
  effect eLook = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eLook)) {
    if (GetEffectSpellId(eLook) == SpellID)
      RemoveEffect(oTarget, eLook);
    eLook = GetNextEffect(oTarget);
  }
}
void main()
{
    int nDuration = MothGetCasterLevel(OBJECT_SELF)+10;
    int nBonus = d12(1);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nBonus = 12;
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nBonus = nBonus + (nBonus/2);
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_ALL);
    effect eHP = EffectTemporaryHitpoints(nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    object oTarget = GetSpellTargetObject();
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AID, FALSE));
    if(MothAllowSelfAid(oTarget,OBJECT_SELF))
    {
        RemoveEffectsFromSpell(oTarget,SPELL_AID);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(nDuration));
    }
    else
    {
       SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an ally!</c>");
    }
}


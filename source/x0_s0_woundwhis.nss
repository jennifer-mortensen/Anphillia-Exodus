/*void RemoveEffectsFromSpell1(object oTarget, int SpellID)
{
  effect eLook = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eLook)) {
    if (GetEffectSpellId(eLook) == SpellID)
      RemoveEffect(oTarget, eLook);
    eLook = GetNextEffect(oTarget);
  }
} */
#include "x2_inc_spellhook"
#include "_inc_spells"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nDuration;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(d6(1) + nBonus, 0, DAMAGE_TYPE_SONIC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 441, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    //RemoveEffectsFromSpell1(OBJECT_SELF,SPELL_WOUNDING_WHISPERS);
    RemoveSpellDamageShields();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

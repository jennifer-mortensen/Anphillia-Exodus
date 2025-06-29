#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "_inc_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDuration2 = MothGetCasterLevel(OBJECT_SELF)+4;
    int nDamage = nDuration;
    if(nDamage > 20)
    {
        nDamage = 20;
    }
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 40);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 40);
    effect eLink = EffectLinkEffects(eShield, eCold);
    eLink = EffectLinkEffects(eLink, eFire);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ELEMENTAL_SHIELD, FALSE));
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
         RemoveSpellEffects(GetSpellId(), OBJECT_SELF, oTarget);
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration2 = nDuration2 *2;
    }
    RemoveSpellDamageShields();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration2));
}


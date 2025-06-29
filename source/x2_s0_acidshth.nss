#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "_inc_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(448);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDuration2 = MothGetCasterLevel(OBJECT_SELF)+4;
    int nDamage = nDuration;
    if(nDamage > 20)
    {
        nDamage = 20;
    }
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d8, DAMAGE_TYPE_ACID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration2 = nDuration2 *2;
    }
    //RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveSpellDamageShields();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration2));
}


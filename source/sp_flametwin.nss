//twin fire
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eLinka = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eLinkb = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eLinkc = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eLink2 = EffectLinkEffects(eLinka, eLinkb);
    eLink2 = EffectLinkEffects(eLink2, eLinkc);
    effect eVis = EffectVisualEffect(445);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    effect eVis3 = EffectVisualEffect(VFX_DUR_AURA_PULSE_YELLOW_WHITE);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDuration2 = MothGetCasterLevel(OBJECT_SELF)*3;
    int nDamage = nDuration;
    if(nDamage > 20)
    {
        nDamage = 20;
    }
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    //effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d8, DAMAGE_TYPE_POSITIVE); //J. Persinne; damage shield component removed.
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAttack = EffectAttackIncrease(4);
    effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_FIRE);
    effect eLink = EffectLinkEffects(eDur, eVis);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eVis3);
    eLink = EffectLinkEffects(eLink, eAttack);
    eLink = EffectLinkEffects(eLink, eDmg);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration2 = nDuration2 *2;
    }
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration2+5));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink2, oTarget);
}

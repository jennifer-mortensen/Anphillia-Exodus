#include "nw_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nAmount = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = nAmount;
    object oTarget = GetSpellTargetObject();
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_STONESKIN, FALSE));
    if (nAmount > 15)
    {
        nAmount = 15;
    }
    int nDamage = nAmount * 10;
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    effect eVis2 = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect eStone = EffectDamageReduction(20, DAMAGE_POWER_PLUS_FIVE, nDamage);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    //object oScroll = GetSpellCastItem();

    if(GetHasFeat(FEAT_EARTH_DOMAIN_POWER,OBJECT_SELF))
    {
        eStone = EffectDamageReduction(20, DAMAGE_POWER_PLUS_SIX, nDamage *3 /2);
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Your Domain increases the spelleffect.</c>");
    }

    effect eLink = EffectLinkEffects(eVis, eStone);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, SPELL_GREATER_STONESKIN);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}

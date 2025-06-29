#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eStone;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    object oTarget = GetSpellTargetObject();
    int nAmount = MothGetCasterLevel(OBJECT_SELF) * 10;
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_STONESKIN, FALSE));
    if (nAmount > 100)
    {
        nAmount = 100;
    }
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_FIVE, nAmount);
    object oScroll = GetSpellCastItem();

    if(GetAppearanceType(OBJECT_SELF) == 370) //Epic Medusa
    {
        eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_SIX, 75);
    }
    else if(GetHasFeat(FEAT_EARTH_DOMAIN_POWER,OBJECT_SELF))
    {
        eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_SIX, nAmount *3 /2);
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Your Domain increases the spelleffect.</c>");
    }

    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "_inc_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(oTarget)+4;
    int nCasterLvl = MothGetCasterLevel(oTarget)/2;
    if (GetAppearanceType(OBJECT_SELF) == 65)
    {
    nCasterLvl = GetHitDice(OBJECT_SELF)/2;
    nDuration = GetHitDice(OBJECT_SELF)+4;
    }
    /*if(nCasterLvl > 5)
    {
        nCasterLvl = 5;
    }*/
    int nMetaMagic = GetMetaMagicFeat();
    int nDamageBase = nCasterLvl / 4;
    int nDI = 2 + nCasterLvl / 5;
    effect eShield = EffectDamageShield(nDamageBase, DAMAGE_BONUS_1d8, DAMAGE_TYPE_NEGATIVE);
    effect eDur = EffectVisualEffect(463);
    effect eDI = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nDI);
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eDI);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    //RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveSpellDamageShields();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}


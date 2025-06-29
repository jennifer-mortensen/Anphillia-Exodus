#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nImmunity;
    nImmunity = 10 + (nDuration / 4);
    if(nDuration == GetHitDice(OBJECT_SELF))
        nImmunity += 5;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_INSPIRE_COURAGE);
    effect eNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nImmunity);
    effect eLevel = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nImmunity);
    effect eAbil = EffectImmunity(IMMUNITY_TYPE_SLOW);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    effect eLink = EffectLinkEffects(eNeg, eLevel);
    eLink = EffectLinkEffects(eLink, eAbil);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration)));
}


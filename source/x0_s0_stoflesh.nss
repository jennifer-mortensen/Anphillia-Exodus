#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nBonusProcent = nDuration/4;
    effect eVis = EffectVisualEffect(476);
    effect eDur = EffectVisualEffect(VFX_DUR_BUBBLES);
    effect ePenalty = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING,2+nBonusProcent);
    effect ePenalty2 = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,2+nBonusProcent);
    effect eLink = EffectLinkEffects(ePenalty, ePenalty2);
    eLink = EffectLinkEffects(eLink, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if(MothGetIsFortAlly(oTarget))
    {
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(),FALSE));
    MothRemovePetrify(oTarget);
    return;
    }
    else
    {
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
     if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF))
       {
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,0.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
       }

    }
}




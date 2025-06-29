#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eSave;
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEAD_COLD);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect eDur = EffectVisualEffect(628);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLvl/2;
    nDuration = nDuration*2;
    int nBonus = nCasterLvl / 8;
    if(nBonus<1){nBonus==1;}
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    eSave = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 1+nBonus);
    effect eLink = EffectLinkEffects(eSave, eDur);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    DelayCommand(0.1,TLVFXPillar(VFX_IMP_PULSE_COLD,GetLocation(oTarget), 1, 0.0f, 1.2f));
    DelayCommand(0.2,TLVFXPillar(VFX_IMP_PULSE_COLD,GetLocation(oTarget), 1, 0.0f, 1.0f));
    DelayCommand(0.3,TLVFXPillar(VFX_IMP_PULSE_COLD,GetLocation(oTarget), 1, 0.0f, 0.8f));
    DelayCommand(0.4,TLVFXPillar(VFX_IMP_PULSE_COLD,GetLocation(oTarget), 1, 0.0f, 0.6f));
    DelayCommand(0.6,TLVFXPillar(VFX_IMP_PULSE_COLD,GetLocation(oTarget), 1, 0.0f, 0.4f));
    DelayCommand(0.8f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(6+nDuration)));
    DelayCommand(0.8f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
    DelayCommand(0.8f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
}


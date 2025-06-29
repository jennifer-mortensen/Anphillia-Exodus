#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if(MothGetIsDisabled(OBJECT_SELF)){return;}
    effect eLinka = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eLinkb = EffectVisualEffect(VFX_IMP_PDK_FINAL_STAND);
    effect eLinkc = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eLink2 = EffectLinkEffects(eLinka, eLinkb);
    eLink2 = EffectLinkEffects(eLink2, eLinkc);
    effect eVisa = EffectVisualEffect(228);
    effect eVisb = EffectVisualEffect(227);
    effect eVis = EffectLinkEffects(eVisa, eVisb);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_RED);
    effect eVis3 = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_BLACK);
    int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN,OBJECT_SELF);
    int nDuration = nLevel;
    int nDuration2 = nLevel*2;
    int nDamage = nDuration/2;
    int nAC = nDamage/10 + 1;
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d10, DAMAGE_TYPE_SLASHING);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC = EffectACIncrease(nAC);
    effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_NEGATIVE);
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eVis3);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDmg);
    eLink = ExtraordinaryEffect(eLink);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration2)));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink2, oTarget));
}

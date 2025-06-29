#include "x2_inc_toollib"
#include "moth_inc_craftin"
#include "moth_inc_spells"
void main()
{
    if(MothGetIsDisabled(OBJECT_SELF)){return;}
    int iTimer = GetLocalInt(OBJECT_SELF, "MOTHIGNOREPAIN");
    int nDuration = GetHitDice(OBJECT_SELF);
    int nUses = 1+nDuration/10;
    if (iTimer >= nUses)
    {
    FloatingTextStringOnCreature("<cðøþ>*No focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    iTimer++;
    SetLocalInt(OBJECT_SELF, "MOTHIGNOREPAIN", iTimer);
    int nBonusProcent = nDuration/5;
    object oTarget = OBJECT_SELF;
    effect eBonus1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,1+nBonusProcent);
    effect eBonus2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,1+nBonusProcent);
    effect eBonus3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,1+nBonusProcent);
    effect eBonus = EffectLinkEffects(eBonus1,eBonus2);
    eBonus = EffectLinkEffects(eBonus,eBonus3);
    effect eVisa = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eVisb = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis = EffectLinkEffects(eVisa,eVisb);
    effect eDur1 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_FLIES);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    effect eLink = EffectLinkEffects(eBonus, eDur);
    eLink = ExtraordinaryEffect(eLink);
    nDuration = nDuration/2;
    DelayCommand(0.1,TLVFXPillar(VFX_IMP_HOLY_AID,GetLocation(oTarget), 2, 0.0f, 0.8f));
    DelayCommand(0.2,TLVFXPillar(VFX_IMP_STARBURST_GREEN,GetLocation(oTarget), 1, 0.0f, 0.7f));
    DelayCommand(0.3,TLVFXPillar(VFX_IMP_DUST_EXPLOSION,GetLocation(oTarget), 1, 0.0f, 0.6f));
    DelayCommand(0.4,TLVFXPillar(VFX_IMP_STARBURST_RED,GetLocation(oTarget), 1, 0.0f, 0.5f));
    DelayCommand(0.5,TLVFXPillar(VFX_IMP_NIGHTMARE_HEAD_HIT,GetLocation(oTarget), 1, 0.0f, 0.4f));
    DelayCommand(0.9,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(5+nDuration)));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
}

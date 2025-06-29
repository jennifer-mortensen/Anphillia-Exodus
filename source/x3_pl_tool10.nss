#include "moth_inc_spells"
void main()
{
    object oUser = OBJECT_SELF;
    if(MothGetIsDisabled(oUser)){return;}
    int nLevel = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oUser);
    int nAB = nLevel/10;
    effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_POSITIVE);
    effect eAB = EffectAttackIncrease(1+nAB);
    effect eLink = EffectLinkEffects(eDamage,eAB);
    eLink = ExtraordinaryEffect(eLink);
    effect eVisual1 = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eVisual2 = EffectVisualEffect(VFX_IMP_STARBURST_GREEN);
    effect eVisual3 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eVisual4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eVisual = EffectLinkEffects(eVisual1,eVisual2);
    eVisual = EffectLinkEffects(eVisual,eVisual3);
    eVisual = EffectLinkEffects(eVisual,eVisual4);
    int iTimer = GetLocalInt(oUser, "MOTHTHREAD");
    if (iTimer >= 1)
    {
    FloatingTextStringOnCreature("<cðøþ>*No focus!*</c>",oUser,FALSE);
    SendMessageToPC(oUser, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    iTimer++;
    SetLocalInt(oUser, "MOTHTHREAD", iTimer);
    RemoveEffectsFromSpell(oUser, GetSpellId());
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oUser, TurnsToSeconds(nLevel)));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oUser));
}

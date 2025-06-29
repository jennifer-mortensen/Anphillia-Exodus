#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPlayer = OBJECT_SELF;
    object oTarget;
    effect ePosVis1 = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect ePosVis2 = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect ePosVis = EffectLinkEffects(ePosVis1, ePosVis2);
    effect ePosSelf = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect ePosLoc = EffectVisualEffect(VFX_FNF_FIRESTORM);
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPlayer);
    int nBonus = DAMAGE_BONUS_1d4;
    float fRadius = 6.0;
    int nDuration = 10 + nCasterLvl;
    if (nCasterLvl <= 6)
    {
    nBonus = DAMAGE_BONUS_1d6;
    fRadius = 8.0;
    }
    else if (nCasterLvl <= 7)
    {
    nBonus = DAMAGE_BONUS_1d8;
    fRadius = 10.0;
    }
    else if (nCasterLvl <= 10)
    {
    nBonus = DAMAGE_BONUS_1d10;
    fRadius = 12.0;
    }
    else if (nCasterLvl <= 15)
    {
    nBonus = DAMAGE_BONUS_1d12;
    fRadius = 14.0;
    }
    else if (nCasterLvl <= 20)
    {
    nBonus = DAMAGE_BONUS_2d6;
    fRadius = 18.0;
    }
    else if (nCasterLvl <= 25)
    {
    nBonus = DAMAGE_BONUS_2d10;
    fRadius = 20.0;
    }
    else if (nCasterLvl <= 29)
    {
    nBonus = DAMAGE_BONUS_2d10;
    fRadius = 22.0;
    }
    else if (nCasterLvl == 30)
    {
    nBonus = DAMAGE_BONUS_2d12;
    fRadius = 26.0;
    nDuration = nDuration+10;
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosSelf, OBJECT_SELF);
    DelayCommand(0.1,TLVFXPillar(VFX_IMP_PULSE_FIRE,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(0.5,TLVFXPillar(VFX_IMP_PULSE_FIRE,GetLocation(OBJECT_SELF), 1, 0.0f, 4.0f));
    DelayCommand(1.1,TLVFXPillar(VFX_IMP_PULSE_FIRE,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(1.5,TLVFXPillar(VFX_IMP_PULSE_FIRE,GetLocation(OBJECT_SELF), 1, 0.0f, 2.0f));
    DelayCommand(2.0,TLVFXPillar(VFX_IMP_PULSE_FIRE,GetLocation(OBJECT_SELF), 1, 0.0f, 1.0f));
    DelayCommand(1.8,ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosLoc, OBJECT_SELF));
    effect eBonAttack = EffectDamageIncrease(nBonus,DAMAGE_TYPE_FIRE);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==TRUE)
        {
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget));
            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonAttack, oTarget,RoundsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(OBJECT_SELF));
    }
}






#include "x2_inc_spellhook"
#include "moth_inc_spell2"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nCasterLvl = nDuration;
    int nBonus;
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eVis = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    if (nCasterLvl <= 19){nBonus = 1;}
    else if (nCasterLvl <= 39){nBonus = 2;}
    else {nBonus = 3;}
    effect eAttack = EffectAttackIncrease(nBonus);
    effect eLink = EffectLinkEffects(eAttack, eParal);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    location lSpell = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_LOS_HOLY_10,lSpell, 1, fDelay1, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20,lSpell, 1, fDelay1+0.4, 6.0f, 2.0f);
    DelayCommand(0.1,TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lSpell, 1, 0.0f, 1.2f));
    DelayCommand(0.2,TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, 0.0f, 0.9f));
    DelayCommand(0.3,TLVFXPillar(VFX_FNF_LOS_NORMAL_30,lSpell, 1, 0.0f, 0.3f));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSpell);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(fDelay1,MothSetFreedom(oTarget));
            DelayCommand(fDelay1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}

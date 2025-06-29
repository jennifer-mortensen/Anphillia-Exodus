#include "NW_I0_SPELLS"
#include "x2_inc_shifter"
#include "x2_inc_toollib"
void main()
{
    int nHD = GetHitDice(OBJECT_SELF);
    int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+3;
    int nDuration = 1 + (nHD/4);
    effect eVis1 = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DOOM);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eAttack = EffectAttackDecrease(3);
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, 3, SAVING_THROW_TYPE_ALL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_ODD);
    float fDelay;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    TLVFXPillar(VFX_FNF_LOS_NORMAL_30,GetLocation(OBJECT_SELF), 1, 0.0, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_NORMAL_20,GetLocation(OBJECT_SELF), 1, 0.0, 6.0f, 2.0f);
    DelayCommand(0.1,TLVFXPillar(VFX_FNF_LOS_NORMAL_30,GetLocation(OBJECT_SELF), 1, 0.0f, 1.2f));
    DelayCommand(0.2,TLVFXPillar(VFX_FNF_LOS_NORMAL_20,GetLocation(OBJECT_SELF), 1, 0.0f, 0.9f));
    DelayCommand(0.3,TLVFXPillar(VFX_FNF_HOWL_WAR_CRY_FEMALE,GetLocation(OBJECT_SELF), 1, 0.0f, 0.3f));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 14.0, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
            fDelay = GetDistanceToObject(oTarget)/10;
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_DOOM));
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 14.0, GetLocation(OBJECT_SELF));
    }
}

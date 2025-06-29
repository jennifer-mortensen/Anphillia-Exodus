#include "X0_I0_SPELLS"
void main()
{

    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }
    if(GetTag(OBJECT_SELF)=="Phaser"){ExecuteScript("mothphaserray",OBJECT_SELF);return;}
    int nHD = GetHitDice(OBJECT_SELF);
    int nDuration = 1 + (nHD / 3);
    int nDC = 10 + (nHD/2);
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eGaze = EffectCharmed();
    effect eVis = EffectVisualEffect(VFX_IMP_CHARM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVisDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eLink = EffectLinkEffects(eDur, eVisDur);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
            nDuration = GetScaledDuration(nDuration, oTarget);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_CHARM));
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
            {
                eGaze = GetScaledEffect(eGaze, oTarget);
                eLink = EffectLinkEffects(eLink, eGaze);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }
}



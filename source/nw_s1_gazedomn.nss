#include "X0_I0_SPELLS"

void main()
{


    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }


    //Declare major variables
    int nHD ;
    int nDuration;
    int nDC;
    // shifter
    nHD = GetHitDice(OBJECT_SELF);
    nDuration = 1 + (nHD / 3);
    nDC = 10 + (nHD/2);

    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eGaze = EffectDominated();
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVisDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);

    effect eLink = EffectLinkEffects(eDur, eVisDur);

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
            nDuration = GetScaledDuration(nDuration , oTarget);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_DOMINATE));
            //Determine effect delay
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(GetIsEnemy(oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                    eGaze = GetScaledEffect(eGaze, oTarget);
                    eLink = EffectLinkEffects(eLink, eGaze);

                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }
}


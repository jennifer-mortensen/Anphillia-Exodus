#include "X0_I0_SPELLS"

void main()
{
    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }


    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDuration = 1 + (nHD / 3);
    int nDC = 10 + (nHD/2);
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eGaze = EffectDeath();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
            if(GetAlignmentLawChaos(oTarget) == ALIGNMENT_CHAOTIC)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_DESTROY_LAW));
                //Determine effect delay
                float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                if(!/*WillSave*/MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    //Apply the VFX impact and effects
                    //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGaze, oTarget));
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }
}


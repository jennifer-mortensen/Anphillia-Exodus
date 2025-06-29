#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    //Declare major variables
    int nRounds;
    int nDC = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,GetAreaOfEffectCreator())+21;
    effect eStun = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    effect eFind;
    object oTarget;
    object oCreator;
    float fDelay;
    //Get the first object in the persistant area
    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,SPELL_DARKNESS));
            //Make a Fort Save
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget,nDC, SAVING_THROW_TYPE_NONE))
            {
                if (GetIsImmune(oTarget, IMMUNITY_TYPE_BLINDNESS) == FALSE)
                {
                    nRounds = 2;
                    fDelay = GetRandomDelay(0.75, 1.75);
                    //Apply the VFX impact and linked effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nRounds)));
                }
            }
    }
}

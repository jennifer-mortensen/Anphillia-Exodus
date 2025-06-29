#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    int nDamage;
    float fDelay;
    //Calculate the damage
    nDamage = d20(4)+15;
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eCone;
    effect eVis1 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 19.0, lTargetLocation, TRUE);
    //Get first target in spell area
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_CONE_DISEASE));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            eCone = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_TWENTY);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCone, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 18.0, lTargetLocation, TRUE);
    }
}


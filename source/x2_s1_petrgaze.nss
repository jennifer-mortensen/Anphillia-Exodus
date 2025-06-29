#include "x0_i0_spells"
#include "x2_inc_shifter"
#include "x2_inc_spellhook"
void main()
{
    //if (ShifterDecrementGWildShapeSpellUsesLeft() <1 )
    //{
    //    FloatingTextStrRefOnCreature(83576, OBJECT_SELF);
    //    return;
    //}
    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }
    int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+1;
    float fDelay;
    object oTarget = GetSpellTargetObject();
    int nHitDice = MothGetCasterLevel(OBJECT_SELF);
    int nSpellID = GetSpellId();
    object oSelf = OBJECT_SELF;
    location lFinalTarget = GetSpellTargetLocation();
    vector vFinalPosition;
    if ( lFinalTarget == GetLocation(OBJECT_SELF) )
    {
        vector lTargetPosition = GetPositionFromLocation(lFinalTarget);
        vFinalPosition.x = lTargetPosition.x +  cos(GetFacing(OBJECT_SELF));
        vFinalPosition.y = lTargetPosition.y +  sin(GetFacing(OBJECT_SELF));
        lFinalTarget = Location(GetAreaFromLocation(lFinalTarget),vFinalPosition,GetFacingFromLocation(lFinalTarget));
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
            DelayCommand(fDelay,MothPetrify(OBJECT_SELF,oTarget, nHitDice, nSpellID, nDC));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, TRUE);
    }
}



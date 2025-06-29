#include "x0_i0_spells"
#include "x2_inc_shifter"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHitDice = GetHitDice(OBJECT_SELF);


    location lTargetLocation = GetSpellTargetLocation();

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget)==FALSE)
        {
        float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+1;
        int nSpellID = GetSpellId();
        object oSelf = OBJECT_SELF;
        DelayCommand(fDelay,MothPetrify(OBJECT_SELF,oTarget, nHitDice, nSpellID, nDC));
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    }
}


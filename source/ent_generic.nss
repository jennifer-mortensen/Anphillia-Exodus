#include "spawn_functions"
#include "_inc_subrace"
#include "tk_hips_inc"
#include "_inc_time"
#include "_inc_const"
void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
        return;

    Spawn_OnAreaEnter(); //NESS spawn control
    HandleLightBlindness(oPC); //Update subrace light blindness effects
    int nRoll = d100(GetTimeMillisecond() % 100); //Seed the RNG for better engine randomization results
    if(GetLevelByClass(CLASS_TYPE_RANGER, oPC) >= 35) //Update HiPS status for rangers.
    {
        int nNaturalArea = GetIsAreaNatural(OBJECT_SELF);
        if(nNaturalArea != GetLocalInt(oPC, "CURRENT_IS_NATURAL_AREA_TYPE"))
        {
            TK_HiPS_OnFeatChange(oPC);
            SetLocalInt(oPC, "CURRENT_IS_NATURAL_AREA_TYPE", nNaturalArea);
        }
    }
    if(GetLocalInt(oPC, "REMOVE_PVP_FLAG") == -1)
    {
        SetLocalInt(oPC, "REMOVE_PVP_FLAG", GetSecondsSinceServerBoot() + PVP_FLAG_DURATION);
    }
}

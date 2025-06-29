#include "spawn_functions"
#include "_inc_subrace"
#include "tk_hips_inc"

void main()
{
    object oPC = OBJECT_SELF;
    if(!GetIsPC(oPC))
        return;

    Spawn_OnAreaEnter(); //NESS spawn control
    HandleLightBlindness(oPC); //Update subrace light blindness effects
    int nRoll = d100(GetTimeMillisecond() % 100); //Seed the RNG for better engine randomization results
    TK_HiPS_OnFeatChange(oPC); //Update HiPS status; necessary for rangers who only have HiPS in some areas.
}

#include "spawn_functions"
#include "_inc_subrace"
#include "tk_hips_inc"
#include "_inc_gen"
#include "anph_inc"
void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
        return;

    Spawn_OnAreaEnter(); //NESS spawn control
    HandleLightBlindness(oPC); //Update subrace light blindness effects
    int nRoll = d100(GetTimeMillisecond() % 100); //Seed the RNG for better engine randomization results

    if(GetLocalInt(OBJECT_SELF, "EXPLORE_AREA") == 1)
        ExploreAreaForPlayer(OBJECT_SELF, oPC, TRUE);

    if(GetLevelByClass(CLASS_TYPE_RANGER, oPC) >= 35) //Update HiPS status for rangers.
    {
        int nNaturalArea = GetIsAreaNatural(OBJECT_SELF);
        if(nNaturalArea != GetLocalInt(oPC, "CURRENT_IS_NATURAL_AREA_TYPE"))
        {
            TK_HiPS_OnFeatChange(oPC);
            SetLocalInt(oPC, "CURRENT_IS_NATURAL_AREA_TYPE", nNaturalArea);
        }
    }
    if(GetIsOfFaction(oPC, FACTION_CLEAVEN) && GetLocalInt(oPC, "REMOVE_PVP_FLAG") != -1)
    {
        SetLocalInt(oPC, "CURRENT_PVP_STANCE", 2);
        SetLocalInt(oPC, "REMOVE_PVP_FLAG", -1);
        CheckPlayerTeam(oPC);
    }
}

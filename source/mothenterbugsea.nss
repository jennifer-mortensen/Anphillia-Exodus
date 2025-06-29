#include "spawn_main"
#include "_inc_subrace"
#include "_inc_time"
#include "_inc_const"
#include "tk_hips_inc"

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
object oTake1 = GetItemPossessedBy(oPC,"mothtelebugbear");
Spawn_OnAreaEnter(); //NESS spawn control
HandleLightBlindness(oPC); //Update subrace light blindness effects
int nRoll = d100(GetTimeMillisecond() % 100); //Seed the RNG for better engine randomization results
if(!GetIsObjectValid(oTake1))
  {
    CreateItemOnObject("mothtelebugbear", oPC);
    SendMessageToPC(oPC,"<cþ¥ >A magical Teleporter appear in your backpack!</c>");
  }

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

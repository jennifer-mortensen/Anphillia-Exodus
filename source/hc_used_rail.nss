// hc_used_campfire
// Archaegeo 2002
// Campfire kumbiya time
void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
ActionStartConversation(oPC, "hc_hinchrail");
}
/*
#include "zep_inc_phenos2"
void main()
{
    object oPC=GetLastUsedBy();
    zep_Dismount(oPC);
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,120.0));
}

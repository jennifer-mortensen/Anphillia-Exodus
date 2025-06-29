#include "hc_inc"

#include "anph_db_inc"
#include "anph_xp_inc"


void main()
{
    object oDM = GetLastSpeaker ();
    object oPC;

    oPC = GetLocalObject (oDM, "xpwand_target");

    if (GetIsPC (oPC))
    {
        SendMessageToPC (oPC, "Your efforts have been rewarded!");
        GiveXPToCreature (oPC, 250);
    }

}

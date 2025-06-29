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
        SendMessageToPC (oPC, "Thank you for roleplaying!");
        GiveXPToCreature (oPC, 250);
    }
}

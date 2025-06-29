#include "hc_inc"

#include "anph_db_inc"
#include "anph_xp_inc"

void main()
{
    int i = 1;
    object oDM = GetLastSpeaker ();
    float fDistance = 6.0;
    object oPC;

    while (TRUE)
    {
        oPC = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR,
                                         PLAYER_CHAR_IS_PC, oDM, i);
        i++;
        if (!GetIsObjectValid (oPC))
        {
            return;
        } else if (GetDistanceBetween (oPC, oDM) > fDistance)
        {
            return;
        } else
        {
            SendMessageToPC (oPC, "Your efforts have been rewarded!");
            GiveXPToCreature (oPC, 100);
        }
    }

}

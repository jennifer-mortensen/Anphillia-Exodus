#include "hc_inc"

#include "anph_db_inc"
#include "anph_xp_inc"

void main()
{
    // Get config variables
    if (GetLocalInt(oMod, "ANPH_ROLEPLAY_XP") == FALSE)
       return;
    int iTicks = GetLocalInt(oMod, "ANPH_ROLEPLAY_INTERVAL");
    int iBaseXP = GetLocalInt(oMod, "ANPH_ROLEPLAY_BASEXP");

    int iVal;
    iVal = GetLocalInt (OBJECT_SELF, "count");
    iVal++;
    location lLastLoc;
    location lLoc;
    int nLevel;


    // As it is now, 5 ticks is about 2 minutes.
    if (iVal == 2)
    if (iVal == iTicks)
    {
        iVal = 0;
        object oPC = GetFirstPC();
        while (GetIsObjectValid (oPC) == TRUE)
        {
            lLoc = GetLocation (oPC);

            if (GetLocalInt (oPC, "HasKilledMonster"))
            {
                SetLocalInt (oPC, "HasKilledMonster", 0);
            } else
            {
                lLastLoc = GetLocalLocation (oPC, "LastIdleXPLocation");
                if (lLoc != lLastLoc)
                {
                    nLevel = GetExperienceLevel (oPC);
                    GiveXPToCreature (oPC, iBaseXP/* + Random (10) + (nLevel * 2)*/);
                    if (!GetLocalInt (oPC, "SentRPMessage"))
                    {
                        SetLocalInt (oPC, "SentRPMessage", 1);
                        SendMessageToPC (oPC, "Thank you for role playing!");
                    }
                }
            }
            SetLocalLocation (oPC, "LastIdleXPLocation", lLoc);

            oPC = GetNextPC();
        }

    }

    SetLocalInt (OBJECT_SELF, "count", iVal);

}

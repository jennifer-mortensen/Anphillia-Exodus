#include "hc_inc"
#include "anph_inc"
#include "zep_inc_phenos2"
#include "anph_db_inc"
#include "anph_xp_inc"
#include "_inc_subdual"
#include "_inc_death"

void CheckPlayerBleed (object oPC)
{

        zep_Dismount(oPC);
        if ( (GetCurrentHitPoints (oPC) <= 0) &&
             (GetCurrentHitPoints (oPC) >= -10) )
        {
            if (d20(2) <= (7 + GetAbilityModifier (ABILITY_CONSTITUTION, oPC)) )
            {
                int iHitpoints = GetCurrentHitPoints (oPC);
                int iHeal = abs (iHitpoints) + 1;
                effect eHeal = EffectHeal (iHeal);

                SendMessageToPC (oPC, "You have recovered from your wounds.");

                ApplyEffectToObject (DURATION_TYPE_INSTANT, eHeal, oPC);

            } else if (GetLocalInt(oPC, "DelayBleed") == 1)
            {
                if (d4() == 1)
                    SetLocalInt(oPC, "DelayBleed", 0);
            } else
            {
                effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
                ApplyEffectToObject (DURATION_TYPE_INSTANT, eDamage, oPC);
                SendMessageToPC (oPC, "You slip closer to death..");
                int which = d6();
                switch (which)
                {
                    case 1:
                        PlayVoiceChat (VOICE_CHAT_PAIN1, oPC);
                    break;
                    case 2:
                        PlayVoiceChat (VOICE_CHAT_PAIN2, oPC);
                    break;
                    case 3:
                        PlayVoiceChat (VOICE_CHAT_PAIN3, oPC);
                    break;
                    case 4:
                        PlayVoiceChat (VOICE_CHAT_HEALME, oPC);
                    break;
                    case 5:
                        PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPC);
                    break;
                    case 6:
                        PlayVoiceChat (VOICE_CHAT_HELP, oPC);
                    break;
                }

                // remember hitpoints instantly to prevent cheating
                string sName = GetName (oPC);
                string sPlayerName = GetPCPlayerName (oPC);
                //string sCDK = GetPCPublicCDKey (oPC);

                // Set hit points for PC so we can remember
                // them on join.
                SetLocalInt (oMod, sName + sPlayerName + "RHP",
                             1);
                SetLocalInt (oMod, sName + sPlayerName + "CHP",
                             GetCurrentHitPoints (oPC));
            }
            DelayCommand(12.0, CheckPlayerBleed(oPC));
        }

}

void main()
{
    if (CheckSubdual(GetLastPlayerDying())) return; //J. Persinne; subdual mode added.

    object oPC = GetLastPlayerDying();
    object oHostile = GetLastHostileActor(oPC);

    DropGold(oPC);

    if (GetIsObjectValid(GetMaster(oHostile)))
    {
        oHostile = GetMaster(oHostile);
    }

    if (!GetIsPC (oHostile))
    {
        int nLevel = GetHitDice (oPC);
        int nXPVal = GetLocalInt (oHostile, "MyXPValue");

        SetLocalInt (oHostile, "MyXPValue", nXPVal + 50 + nLevel * 10);
    }

    SetLocalObject(oPC, "LastHostileActor", oHostile);
    if ((GetIsPC(oHostile) ||
         GetIsPC(GetMaster(oHostile)) ||
         !GetIsObjectValid(oHostile) ||
         GetName(oHostile) == ""
        )
       )
    {
       if (AnphGetPlayerTeam(oPC) != AnphGetPlayerTeam(oHostile))
       {
          SetLocalInt(oPC, "PvPDeath", 1);
       }
       else if (AnphGetPlayerTeam(oPC) != AnphGetPlayerTeam(GetMaster(oHostile)))
       {
          if (GetIsPC(GetMaster(oHostile)))
          {
             SetLocalInt(oPC, "PvPDeath", 1);
          }
       }
    }

    // DEBUG
    // SendMessageToAllDMs("Last Hostile Actor identified as: " + GetName(GetLastHostileActor(oPC)) + ".");

    object oFam = GetAssociate (ASSOCIATE_TYPE_FAMILIAR, oPC);
    if (GetIsObjectValid (oFam))
    {
        RemoveSummonedAssociate (oPC, oFam);
    }

    // Start bleeding
    DelayCommand(12.0, CheckPlayerBleed(oPC));
}

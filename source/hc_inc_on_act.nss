// PLACEHOLDER

#include "ats_inc_activate"
#include "anph_inc"
#include "jhr_i0_pipe"
#include "hc_inc_track"
int preEvent()
{
    ATS_CheckActivatedItem(GetItemActivator(), GetItemActivated(),
                    GetItemActivatedTarget(), GetItemActivatedTargetLocation());

    ExecuteScript ("dmfxew_activate", OBJECT_SELF);

    object oItem=GetItemActivated();
    object oUser=GetItemActivator();
    object oOther=GetItemActivatedTarget();
    string sItemTag=GetTag(oItem);
    object oPC;
    int STR, DEX, CON, INT, WIS, CHA;
    string Message;
    vector vAdv;

    if (sItemTag == "TroutOfSlappage")
    {
        FloatingTextStringOnCreature("* " + GetName(oUser) + " slaps " + GetName(oOther) + " around a bit with a large trout", oUser, FALSE);
    }
    else if (sItemTag == "WandOfFriends")
    {
        oPC = GetFirstPC ();
        while (GetIsObjectValid (oPC))
        {
            SetPCLike (oUser, oPC);
            SetPCLike (oPC, oUser);
            oPC = GetNextPC ();
        }
    } else if (sItemTag == "jhr_bp_pipe")
    {
        SmokePipe(oUser);
    } else if (sItemTag == "WandOfEnemies")
    {
        oPC = GetFirstPC ();
        while (GetIsObjectValid (oPC))
        {
            SetPCDislike (oUser, oPC);
            SetPCDislike (oPC, oUser);
            oPC = GetNextPC ();
        }
    } else if (sItemTag == "WandOfAxfell")
    {
        oPC = GetFirstPC ();
        string sTeam;
        while (GetIsObjectValid (oPC))
        {
            sTeam = AnphGetPlayerTeam (oPC);
            if (sTeam == "Cleaven")
            {
                SetPCDislike (oUser, oPC);
                SetPCDislike (oPC, oUser);
            } else {
                SetPCLike (oUser, oPC);
                SetPCLike (oPC, oUser);
            }
            oPC = GetNextPC ();
        }
    } else if (sItemTag == "WandOfCleaven")
    {
        oPC = GetFirstPC ();
        string sTeam;
        while (GetIsObjectValid (oPC))
        {
            sTeam = AnphGetPlayerTeam (oPC);
            if (sTeam == "Axfell")
            {
                SetPCDislike (oUser, oPC);
                SetPCDislike (oPC, oUser);
            } else {
                SetPCLike (oUser, oPC);
                SetPCLike (oPC, oUser);
            }
            oPC = GetNextPC ();
        }
    } else if (sItemTag == GetLocalString(oMod, "FACTION_01_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_02_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_03_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_04_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_05_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_06_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_07_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_08_HORN") ||
               sItemTag == GetLocalString(oMod, "FACTION_09_HORN")
              )
    {
        AnphSendWarningCall (oUser);
    }else if (sItemTag == "Drowmessager")
    {
        AnphCryDrow(oUser);
    }else if (sItemTag == "ballofsaving")
    {
      //WriteTimestampedLogEntry ("Ball of Save used.");
        WriteTimestampedLogEntry ("Ball Saving all characters...");
        ExportAllCharacters ();
        WriteTimestampedLogEntry ("Ball Saving Complete.");
        SendMessageToPC (oUser, "Character saved.");
    }
    else if (GetTag(GetItemActivated()) == "BlessWand")
    {
        SetLocalObject(GetItemActivator(), "BlessTarget", GetItemActivatedTarget());
        SetLocalLocation(GetItemActivator(), "BlessLocation", GetItemActivatedTargetLocation());
        // DEBUG SendMessageToAllDMs("Activated by: " + ObjectToString(GetItemActivator()));
        AssignCommand(GetItemActivator(), ActionStartConversation(GetItemActivator(), "wa_bless", TRUE));
    }
    else if (sItemTag == "FaerieFire")
    {
        effect eFaerie = EffectACDecrease(1);
        eFaerie = EffectLinkEffects(eFaerie, EffectSkillDecrease(SKILL_HIDE, 5));
        eFaerie = EffectLinkEffects(eFaerie, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE));
        eFaerie = EffectLinkEffects(eFaerie, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_5));
        effect EffectOn = GetFirstEffect(oOther);
        while (GetIsEffectValid(EffectOn))
        {
            if (GetEffectType(EffectOn) == EFFECT_TYPE_CONCEALMENT ||
                GetEffectType(EffectOn) == EFFECT_TYPE_INVISIBILITY)
                RemoveEffect(oOther, EffectOn);
            EffectOn = GetNextEffect(oOther);
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFaerie, oOther, TurnsToSeconds(GetHitDice(oUser)));

    }
    else if (sItemTag == "WandofAFK")
    {
        AssignCommand(oUser,ActionStartConversation(OBJECT_SELF, "afk_wand", TRUE));
    }
    else if (sItemTag == "FixSelector")
    {
        SetLocalObject(GetModule(), "CreatureToBeFixed", oOther);
    }
    else if (sItemTag == "ExamTool")
    {
        STR = GetAbilityScore(oOther, ABILITY_STRENGTH);
        DEX = GetAbilityScore(oOther, ABILITY_DEXTERITY);
        CON = GetAbilityScore(oOther, ABILITY_CONSTITUTION);
        INT = GetAbilityScore(oOther, ABILITY_INTELLIGENCE);
        WIS = GetAbilityScore(oOther, ABILITY_WISDOM);
        CHA = GetAbilityScore(oOther, ABILITY_CHARISMA);

        switch (STR)
        {
            case 1:
            case 2:
            case 3:
                Message = "Can barely lift his legs. ";
                break;
            case 4:
            case 5:
            case 6:
                Message = "Seriously lacks some strength. ";
                break;
            case 7:
            case 8:
            case 9:
                Message = "Seems to be below avarage in strength. ";
                break;
            case 10:
            case 11:
            case 12:
                Message = "";
                break;
            case 13:
            case 14:
            case 16:
                Message = "Stronger than avarage human. ";
                break;
            case 17:
            case 18:
            case 19:
                Message = "Very strong. ";
                break;
            case 20:
            case 21:
            case 22:
                Message = "One of most powerful beings on Toril. ";
                break;
            default:
                Message = "Could propably lift giant easily. ";
                break;
        }
        switch (DEX)
        {
            case 1:
            case 2:
            case 3:
                Message += "Can't walk properly, always stumbling to own legs. ";
                break;
            case 4:
            case 5:
            case 6:
                Message += "Hard to run without stumbling. ";
                break;
            case 7:
            case 8:
            case 9:
                Message += "A bit clumsy. ";
                break;
            case 10:
            case 11:
                Message += "";
                break;
            case 12:
            case 13:
                Message += "More agile than avarage human. ";
                break;
            case 14:
            case 15:
                Message += "dex 14-15";
                break;
            case 16:
            case 17:
                Message += "Very agile. ";
                break;
            case 18:
            case 19:
                Message += "Moves with absolute precision. ";
                break;
            case 20:
            case 21:
                Message += "Extremely agile. ";
                break;
            default:
                Message += "Moves like a wind, without any mistakes. ";
                break;
        }
        switch (CON)
        {
            case 1:
            case 2:
            case 3:
                Message += "If would fall, would probably die. ";
                break;
            case 4:
            case 5:
            case 6:
                Message += "Wouldn't be able to stand any blow. ";
                break;
            case 7:
            case 8:
            case 9:
                Message += "A bit weak. ";
                break;
            case 10:
            case 11:
                Message += "";
                break;
            case 12:
            case 13:
                Message += "Seems to care about physical condition. ";
                break;
            case 14:
            case 15:
                Message += "Very healthy looking. ";
                break;
            case 16:
            case 17:
                Message += "Seems to be in top condition. ";
                break;
            case 18:
            case 19:
                Message += ". ";
                break;
            case 20:
            case 21:
                Message += ". ";
                break;
            default:
                Message += ". ";
                break;
        }






    }



    return 1;
}

void postEvent()
{
    return;
}

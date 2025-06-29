#include "_inc_xp"
#include "_inc_const"
#include "_inc_summons"
#include "anph_inc"
#include "_inc_db"
#include "_inc_time"
#include "_inc_staff"
#include "_inc_items"

void EmoteAction(object oPC, int nEmote, float fDuration = 1000.0, float fSpeed = 1.0);

void main()
{
    float LOOPING_ANIMATION_DURATION = 1000.0;  //Length for emotes to run.
    int MAXIMUM_COMMAND_LENGTH = 15; //This must be equal to the length of the largest command.

    //Declare variables.
    int nVolume = GetPCChatVolume();
    int nCurrentSpecialAbilityUses;
    int nCommandLength;
    string sText = GetPCChatMessage();
    string sChatCommand;
    string sFirstCharacter = GetStringLeft(sText, 1);
    object oPC = GetPCChatSpeaker();
    object oChannelMember;
    object oPlayer;
    int i;

    if(sFirstCharacter == "/")
    {
        if(GetIsStaffMember(oPC)) //J. Persinne; staff chat channels handled in fb_chat.
        {
            string sQuotes = GetName(GetObjectByTag("QUOTATION_HOLDER"));
            if(GetStringLeft(sText, 3) == "/x " || GetStringLeft(sText, 5) == "/xt " + sQuotes || GetStringLeft(sText, 6) == "/xtp " + sQuotes)
            {
                if(!GetIsDMPossessed(oPC) && !GetIsPossessedFamiliar(oPC))
                    return;
                else
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot use staff commands while possessing a familiar or NPC.</c>");
                    SetPCChatMessage("");
                    return;
                }
            }
        }
    }
    if(nVolume == TALKVOLUME_PARTY && sFirstCharacter != "/")
    {
        sText = "<cÀÀÀ>"+sText+"";
        SetPCChatMessage(sText);
    }
    if(nVolume == TALKVOLUME_WHISPER && sFirstCharacter != "/")
    {

        if(GetIsDM(oPC)==TRUE){return;}
        string sName = GetName(oPC);
        FloatingTextStringOnCreature("<c ¥¥>*"+sName+" Whispers*</c>",oPC,TRUE);
    }
    if(nVolume == TALKVOLUME_SHOUT && sFirstCharacter != "/") //J. Persinne; no longer necessary.  We handle the shout channel in fb_chat.
    {
        if(GetIsDM(oPC)==TRUE){return;}
        //string sName = GetName(oPC);
        //SetPCChatVolume(TALKVOLUME_TALK);
        //FloatingTextStringOnCreature("<cþ¥ >*"+sName+" Shouts*</c>",oPC,TRUE);
        //sText = "<cþ¥ >"+sText+"";
        if(GetIsPossessedFamiliar(oPC))
        {
            SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot shout while possessing a familiar.</c>");
            SetPCChatMessage("");
        }
    }
    if(sFirstCharacter != "/" || GetStringLength(sText) <= 1) //All commands start with a slash and are longer than one character.
        return;
    //Check for OOC commands first as these do not have a definite string length.
    if(GetStringLeft(sText, 2) == "//")
    {
        sText = "<cØp“>" + sText + "</c>";
        SetPCChatMessage(sText);
        return;
    }
    else if(GetStringLeft(sText, 4) == "/ooc")
    {
        sText = GetStringRight(sText, GetStringLength(sText) - 5);
        sText = "<cØp“>// " + sText + "</c>";
        SetPCChatMessage(sText);
        return;
    }
    else if(GetStringLeft(sText, 8) == "/setdesc")
    {
        sText = GetStringRight(sText, GetStringLength(sText) - 9);
        SetDescription(oPC, sText);
        SendMessageToPC(oPC, "<c¥¥¥>[Server] New description set.");
        SetPCChatMessage("");
        return;
    }
    else if(GetStringLeft(sText, 11) == "/appenddesc")
    {
        sText = GetStringRight(sText, GetStringLength(sText) - 12);
        SetDescription(oPC, GetDescription(oPC) + sText);
        SendMessageToPC(oPC, "<c¥¥¥>[Server] Description appended.");
        SetPCChatMessage("");
        return;
    }

    SetPCChatMessage(""); //The PC entered a command but it wasn't an ooc chat command; we don't want them to output text.
    //The following commands have a definite string length.  We'll search through ONLY the commands that meet the right length criteria via a switch.
    sChatCommand = GetStringLeft(sText, MAXIMUM_COMMAND_LENGTH + 1);
    //Snip off white space.
    while(GetStringRight(sChatCommand, 1) == " ")
    {
        sChatCommand = GetStringLeft(sChatCommand, GetStringLength(sChatCommand) - 1);
    }
    sChatCommand = GetStringLowerCase(GetStringRight(sChatCommand, GetStringLength(sChatCommand) - 1)); //Snip off the slash, and ignore case.
    nCommandLength = GetStringLength(sChatCommand);
    //Find and execute the appropriate command.
    switch(nCommandLength)
    {
        case 15:
            //Commands with a length of 15 characters.
            if(sChatCommand == "dragonchromatic")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_CHROMATIC);
                return;
            }
            else if(sChatCommand == "totalexperience")
            {
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Experience Points Total: " + IntToString(GetXP(oPC) + GetVirtualXP(oPC)) + "</c>");
                return;
            }
            break;
        case 14:
            //Commands with a length of 14 characters.
            if(sChatCommand == "dragonmetallic")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_METALLIC);
                return;
            }
            else if(sChatCommand == "reinforcements")
            {
                AnphSendWarningCall1(oPC);
                return;
            }
        case 12:
            //Commands with a length of 12 characters.
            if(sChatCommand == "dragonbronze")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BRONZE);
                return;
            }
            else if(sChatCommand == "dragoncopper")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_COPPER);
                return;
            }
            else if(sChatCommand == "dragonrandom")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_RANDOM);
                return;
            }
            else if(sChatCommand == "dragonsilver")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_SILVER);
                return;
            }
            else if(sChatCommand == "edkchromatic")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_CHROMATIC);
                return;
            }
            else if(sChatCommand == "staffchannel" && GetIsStaffMember(oPC))
            {
                if(GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot use that command while possessing a familiar or NPC.");
                }
                else if(GetLocalInt(oPC, "STAFF_CHANNEL_ENABLED") == TRUE)
                {
                    DeleteLocalInt(oPC, "STAFF_CHANNEL_ENABLED");
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You have left the staff channel.");
                    oChannelMember = GetFirstPC();
                    while(oChannelMember != OBJECT_INVALID)
                    {
                        if(GetLocalInt(oChannelMember, "STAFF_CHANNEL_ENABLED") == TRUE && oChannelMember != oPC)
                        {
                            SendMessageToPC(oChannelMember, "<cÍ]]>" + GetName(oPC) + " (" + GetLocalString(oPC, "STAFF_MEMBER") + ") has left the staff channel.</c>");
                        }
                        oChannelMember = GetNextPC();
                    }
                }
                else
                {
                    SetLocalInt(oPC, "STAFF_CHANNEL_ENABLED", TRUE);
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You have joined the staff channel.");
                    oChannelMember = GetFirstPC();
                    while(oChannelMember != OBJECT_INVALID)
                    {
                        if(GetLocalInt(oChannelMember, "STAFF_CHANNEL_ENABLED") == TRUE && oChannelMember != oPC)
                        {
                            SendMessageToPC(oChannelMember, "<cÍ]]>" + GetName(oPC) + " (" + GetLocalString(oPC, "STAFF_MEMBER") + ") has joined the staff channel.</c>");
                        }
                        oChannelMember = GetNextPC();
                    }
                }
                return;
            }
            else if(sChatCommand == "undeadrandom")
            {
                SetSummonType(oPC, SUMMON_GROUP_UNDEAD, UNDEAD_SUMMON_TYPE_RANDOM);
                return;
            }
            break;
        case 11:
            //Commands with a length of 11 characters.
            if(sChatCommand == "dragonblack")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BLACK);
                return;
            }
            else if(sChatCommand == "dragonwhite")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_WHITE);
                return;
            }
            else if(sChatCommand == "edkmetallic")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_METALLIC);
                return;
            }
            else if(sChatCommand == "newlinedesc")
            {
                SetDescription(oPC, GetDescription(oPC) + "\n");
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Blank line appended to description.");
                return;
            }
            break;
        case 10:
            //Commands with a length of 10 characters.
            /*if(sChatCommand == "placeables" && DEBUG_MODE == TRUE)
            {
                SendMessageToPC(oPC, "<cØp“>--Searching For Placeables--</c>");
                //object oArea1 = GetArea(oPC);
                int j = 1;
                object oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, j);
                while(GetIsObjectValid(oPlaceable))
                {
                    if(GetObjectType(oPlaceable) == OBJECT_TYPE_PLACEABLE)
                    {
                        SendMessageToPC(oPC, "Placeable Found; " + "Name: " + GetName(oPlaceable) + "; Tag: " + GetTag(oPlaceable) + "; Blueprint: " + GetResRef(oPlaceable));
                    }
                    j++;
                    oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, j);
                }
                SendMessageToPC(oPC, "<cØp“>--Search Finished--</c>");
                return;
            }*/
            if(sChatCommand == "dragonblue")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BLUE);
                return;
            }
            else if(sChatCommand == "dragongold")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_GOLD);
                return;
            }
            else if(sChatCommand == "expedition")
            {
                AnphSendExpeditionCall(oPC);
                return;
            }
            else if(sChatCommand == "experience")
            {
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Experience Points Total: " + IntToString(GetXP(oPC) + GetVirtualXP(oPC)) + "</c>");
                return;
            }
            else if(sChatCommand == "immunities")
            {
                int nAcidImmunity = GetLocalInt(oPC, "ACID_IMMUNITY");
                int nBludgeoningImmunity = GetLocalInt(oPC, "BLUDGEONING_IMMUNITY");
                int nColdImmunity = GetLocalInt(oPC, "COLD_IMMUNITY");
                int nDivineImmunity = GetLocalInt(oPC, "DIVINE_IMMUNITY");
                int nElectricalImmunity = GetLocalInt(oPC, "ELECTRICAL_IMMUNITY");
                int nFireImmunity = GetLocalInt(oPC, "FIRE_IMMUNITY");
                int nMagicalImmunity = GetLocalInt(oPC, "MAGICAL_IMMUNITY");
                int nNegativeImmunity = GetLocalInt(oPC, "NEGATIVE_IMMUNITY");
                int nPiercingImmunity = GetLocalInt(oPC, "PIERCING_IMMUNITY");
                int nPositiveImmunity = GetLocalInt(oPC, "POSITIVE_IMMUNITY");
                int nSlashingImmunity = GetLocalInt(oPC, "SLASHING_IMMUNITY");
                int nSonicImmunity = GetLocalInt(oPC, "SONIC_IMMUNITY");

                if(nAcidImmunity > DAMAGE_IMMUNITY_CAP)
                    nAcidImmunity = DAMAGE_IMMUNITY_CAP;
                if(nBludgeoningImmunity > DAMAGE_IMMUNITY_CAP)
                    nBludgeoningImmunity = DAMAGE_IMMUNITY_CAP;
                if(nColdImmunity > DAMAGE_IMMUNITY_CAP)
                    nColdImmunity = DAMAGE_IMMUNITY_CAP;
                if(nDivineImmunity > DAMAGE_IMMUNITY_CAP)
                    nDivineImmunity = DAMAGE_IMMUNITY_CAP;
                if(nElectricalImmunity > DAMAGE_IMMUNITY_CAP)
                    nElectricalImmunity = DAMAGE_IMMUNITY_CAP;
                if(nFireImmunity > DAMAGE_IMMUNITY_CAP)
                    nFireImmunity = DAMAGE_IMMUNITY_CAP;
                if(nMagicalImmunity > DAMAGE_IMMUNITY_CAP)
                    nMagicalImmunity = DAMAGE_IMMUNITY_CAP;
                if(nNegativeImmunity > DAMAGE_IMMUNITY_CAP)
                    nNegativeImmunity = DAMAGE_IMMUNITY_CAP;
                if(nPiercingImmunity > DAMAGE_IMMUNITY_CAP)
                    nPiercingImmunity = DAMAGE_IMMUNITY_CAP;
                if(nPositiveImmunity > DAMAGE_IMMUNITY_CAP)
                    nPositiveImmunity = DAMAGE_IMMUNITY_CAP;
                if(nSlashingImmunity > DAMAGE_IMMUNITY_CAP)
                    nSlashingImmunity = DAMAGE_IMMUNITY_CAP;
                if(nSonicImmunity > DAMAGE_IMMUNITY_CAP)
                    nSonicImmunity = DAMAGE_IMMUNITY_CAP;

                SendMessageToPC(oPC, "<cþ  >Your immunities are as follows:</c>");
                SendMessageToPC(oPC, "   <c »þ>Acid Immunity = +" + IntToString(nAcidImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Bludgeoning Immunity = +" + IntToString(nBludgeoningImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Cold Immunity = +" + IntToString(nColdImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Divine Immunity = +" + IntToString(nDivineImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Electrical Immunity = +" + IntToString(nElectricalImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Fire Immunity = +" + IntToString(nFireImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Magical Immunity = +" + IntToString(nMagicalImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Negative Energy Immunity = +" + IntToString(nNegativeImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Piercing Immunity = +" + IntToString(nPiercingImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Positive Energy Immunity = +" + IntToString(nPositiveImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Slashing Immunity = +" + IntToString(nSlashingImmunity) + "%</c>");
                SendMessageToPC(oPC, "   <c »þ>Sonic Immunity = +" + IntToString(nSonicImmunity) + "%</c>");
                return;
            }
            else if(sChatCommand == "strawberry")
            {
                int nStrawberryFlavored = GetLocalInt(oPC, "IS_STRAWBERRY_FLAVORED");
                effect eStrawberryFlavor;

                if(!nStrawberryFlavored)
                {
                    eStrawberryFlavor = SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLOW_RED));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStrawberryFlavor, oPC);
                    SetLocalInt(oPC, "IS_STRAWBERRY_FLAVORED", TRUE);
                }
                else
                {
                    eStrawberryFlavor = GetFirstEffect(oPC);
                    while(GetIsEffectValid(eStrawberryFlavor))
                    {
                        if(GetEffectType(eStrawberryFlavor) == EFFECT_TYPE_VISUALEFFECT && GetEffectSubType(eStrawberryFlavor) == SUBTYPE_SUPERNATURAL)
                            RemoveEffect(oPC, eStrawberryFlavor);
                        eStrawberryFlavor = GetNextEffect(oPC);
                    }
                    DeleteLocalInt(oPC, "IS_STRAWBERRY_FLAVORED");
                }
                return;
            }
            else if(sChatCommand == "undeadevil")
            {
                SetSummonType(oPC, SUMMON_GROUP_UNDEAD, UNDEAD_SUMMON_TYPE_EVIL);
                return;
            }
            else if(sChatCommand == "undeadgood")
            {
                SetSummonType(oPC, SUMMON_GROUP_UNDEAD, UNDEAD_SUMMON_TYPE_GOOD);
                return;
            }
            break;
        case 9:
            //Commands with a length of 9 characters.
            /*if(sChatCommand == "creatures" && DEBUG_MODE == TRUE)
            {
                SendMessageToPC(oPC, "<cØp“>--Searching For Creatures--</c>");
                int i = 1;
                object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, i);
                while(GetIsObjectValid(oCreature))
                {
                    if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
                    {
                        SendMessageToPC(oPC, "Creature Found; " + "Name: " + GetName(oCreature) + "; Tag: " + GetTag(oCreature) + "; Blueprint: " + GetResRef(oCreature));
                    }
                    i++;
                    oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, i);
                }
                SendMessageToPC(oPC, "<cØp“>--Search Finished--</c>");
                return;
            }*/
            if(sChatCommand == "dmchannel" && GetIsStaffMember(oPC) && !GetIsDM(oPC))
            {
                if(GetIsPossessedFamiliar(oPC))
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot use that command while possessing a familiar.");
                }
                else if(GetLocalInt(oPC, "DM_CHANNEL_ENABLED") == TRUE)
                {
                    DeleteLocalInt(oPC, "DM_CHANNEL_ENABLED");
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You have left the DM channel.");
                    oChannelMember = GetFirstPC();
                    while(oChannelMember != OBJECT_INVALID)
                    {
                        if((GetLocalInt(oChannelMember, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oChannelMember)) && oChannelMember != oPC)
                        {
                            SendMessageToPC(oChannelMember, "<c#ßþ>" + GetName(oPC) + " (" + GetLocalString(oPC, "STAFF_MEMBER") + ") has left the DM channel.</c>");
                        }
                        oChannelMember = GetNextPC();
                    }
                }
                else
                {
                    SetLocalInt(oPC, "DM_CHANNEL_ENABLED", TRUE);
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You have joined the DM channel.");
                    oChannelMember = GetFirstPC();
                    while(oChannelMember != OBJECT_INVALID)
                    {
                        if((GetLocalInt(oChannelMember, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oChannelMember)) && oChannelMember != oPC)
                        {
                            SendMessageToPC(oChannelMember, "<c#ßþ>" + GetName(oPC) + " (" + GetLocalString(oPC, "STAFF_MEMBER") + ") has joined the DM channel.</c>");
                        }
                        oChannelMember = GetNextPC();
                    }
                }
                return;
            }
            else if(sChatCommand == "dragonred")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_RED);
                return;
            }
            else if(sChatCommand == "edkbronze")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BRONZE);
                return;
            }
            else if(sChatCommand == "edkcopper")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_COPPER);
                return;
            }
            else if(sChatCommand == "edkrandom")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_RANDOM);
                return;
            }
            else if(sChatCommand == "edksilver")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_SILVER);
                return;
            }
            break;
        case 8:
            //Commands with a length of 8 characters.
            if(sChatCommand == "allclear")
            {
                AnphSendWarningCall2(oPC);
                return;
            }
            else if(sChatCommand == "automine")
            {
                if(GetLocalInt(oPC, "MOTHAUTOMINE"))
                {
                    DeleteLocalInt(oPC, "MOTHAUTOMINE");
                    FloatingTextStringOnCreature("<cðøþ>*ATS Automining Deactivated!*</c>", oPC, FALSE);
                    return;
                }
                if(GetLocalInt(oPC, "MOTHAUTOMINE") == FALSE)
                {
                    SetLocalInt(oPC, "MOTHAUTOMINE", TRUE);
                    FloatingTextStringOnCreature("<cðøþ>*ATS Automining Activated!*</c>", oPC, FALSE);
                    return;
                }
            }
            else if(sChatCommand == "conjure1")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE1, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "conjure2")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE2, LOOPING_ANIMATION_DURATION);
                return;
            }
            /*else if(sChatCommand == "darkness") //Subrace special darkness spell.
            {
                nCurrentSpecialAbilityUses = GetLocalInt(oPC, "CURRENT_DARKNESS_CASTINGS");
                if(nCurrentSpecialAbilityUses > 0)
                {
                    SetLocalInt(oPC, "DARKNESS_CAST_VIA_SUBRACE", TRUE); //Read by the darkness script; this will ensure that darkness is cast at the PC's ECL-adjusted character level.
                    DelayCommand(6.0, DeleteLocalInt(oPC, "DARKNESS_CAST_VIA_SUBRACE"));
                    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_DARKNESS, OBJECT_SELF, METAMAGIC_ANY, TRUE));
                    nCurrentSpecialAbilityUses--;
                    SetLocalInt(oPC, "CURRENT_DARKNESS_CASTINGS", nCurrentSpecialAbilityUses);
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You now have " + IntToString(nCurrentSpecialAbilityUses) + " use(s) of darkness left.");
                }
                else
                {
                    if(GetLocalInt(oPC, "DARKNESS_CASTINGS_PER_DAY") > 0)
                    {
                        FloatingTextStringOnCreature("<cþŒ >*You must rest in order to replenish your darkness spell(s).*</c>", oPC, FALSE);
                    }
                    else
                    {
                        SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot cast darkness from the chat console.</c>");
                    }
                }
                return;
            } */ //Subraces now cast racial spells via player tools.
            else if(sChatCommand == "edkblack")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BLACK);
                return;
            }
            else if(sChatCommand == "edkwhite")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_WHITE);
                return;
            }
            else if(sChatCommand == "fallback")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_DEAD_BACK, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "meditate")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_MEDITATE, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "threaten")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_TALK_FORCEFUL, LOOPING_ANIMATION_DURATION);
                return;
            }
            /*else if(sChatCommand == "viewhide" && DEBUG_MODE == 1)
            {
                CopyItem(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), oPC);
                return;
            }*/
            break;
        case 7:
            //Commands with a length of 7 characters.
            if(sChatCommand == "conjure")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE1, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "dmtools" && GetIsDM(oPC))
            {
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "DMsHelper")))
                    CreateItemOnObject("DMsHelper", oPC);
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "WandOfFX")))
                    CreateItemOnObject("wandoffx", oPC);
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "XPWand")))
                    CreateItemOnObject("xpwand", oPC);
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "ATS_D_DMSW_N_NON")))
                    CreateItemOnObject("ats_d_dmsw_n_non", oPC);
                return;
            }
            else if(sChatCommand == "edkblue")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_BLUE);
                return;
            }
            else if(sChatCommand == "edkgold")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_GOLD);
                return;
            }
            else if(sChatCommand == "enemies")
            {
                AnphSendWarningCall0(oPC);
                return;
            }
            else if(sChatCommand == "players")
            {
                oPlayer = GetFirstPC();
                while(GetIsObjectValid(oPlayer))
                {
                    if(!GetIsDM(oPlayer))
                        i++;
                    oPlayer = GetNextPC();
                }
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Current Player Total: " + IntToString(i) + "</c>");
                return;
            }
            else if(sChatCommand == "salute")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_SALUTE);
                return;
            }
            else if(sChatCommand == "scratch")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
                return;
            }
            else if(sChatCommand == "subdual")
            {
                int nSubdual = GetLocalInt(oPC, "SUBDUAL");
                int nAreaType = GetLocalInt(GetArea(oPC), "ARENA_AREA");
                if(nAreaType == 1)
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot leave Sparring Mode while in the arena.</c>");
                }
                else
                {
                    nSubdual++;
                    if(nSubdual > 2)
                        nSubdual = 0;
                    SetLocalInt(oPC, "SUBDUAL", nSubdual);
                    switch(nSubdual)
                    {
                        case 0:
                            FloatingTextStringOnCreature("<cþŒ >*Full Damage Mode Activated*</c>", oPC, FALSE);
                            SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now in Full Damage Mode.</c>");
                            break;
                        case 1:
                            FloatingTextStringOnCreature("<cþŒ >*Subdual Mode Activated*</c>", oPC, FALSE);
                            SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now in Subdual Mode.</c>");
                            break;
                        case 2:
                            FloatingTextStringOnCreature("<cþŒ >*Sparring Mode Activated*</c>", oPC, FALSE);
                            SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now in Sparring Mode.</c>");
                            break;
                    }
                }
                return;
            }
            else if(sChatCommand == "suicide")
            {
                if(GetTag(GetArea(oPC)) == "AxfellFuguePlane" || GetTag(GetArea(oPC)) == "CleavenFuguePlane" || GetTag(GetArea(oPC)) == "ADream_ud")
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] Despite your best efforts, you seem incapable of dying. Perhaps you would have more luck if you were alive.</c>");
                }
                else
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You die. How tragic.</c>");
                    SetLocalInt(oPC, "PvPDeath", 2);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(oPC) * 2 + 100), oPC);
                }
                return;
            }
            else if(sChatCommand == "totalxp")
            {
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Experience Points Total: " + IntToString(GetXP(oPC) + GetVirtualXP(oPC)) + "</c>");
                return;
            }
            else if(sChatCommand == "worship")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_WORSHIP, LOOPING_ANIMATION_DURATION);
                return;
            }
            break;
        case 6:
            //Commands with a length of 6 characters.
            if(sChatCommand == "cheer1")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_VICTORY1);
                return;
            }
            else if(sChatCommand == "cheer2")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_VICTORY2);
                return;
            }
            else if(sChatCommand == "cheer3")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_VICTORY3);
                return;
            }
            else if(sChatCommand == "edkred")
            {
                SetSummonType(oPC, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_RED);
                return;
            }
            else if(sChatCommand == "middle")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_GET_MID, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "xwhois" && GetIsStaffMember(oPC))
            {
                oChannelMember = GetFirstPC();
                SendMessageToPC(oPC, "Current Staff Channel Viewers:");

                int nStaffMembersFound;
                int nDMMembersFound;

                while(GetIsObjectValid(oChannelMember))
                {
                    if(GetLocalInt(oChannelMember, "STAFF_CHANNEL_ENABLED") == TRUE)
                    {
                        SendMessageToPC(oPC, "<cÍ]]>--" + GetName(oChannelMember) + " (" + GetLocalString(oChannelMember, "STAFF_MEMBER") + ")</c>");
                        nStaffMembersFound++;
                    }
                    oChannelMember = GetNextPC();
                }

                if(nStaffMembersFound == 0)
                {
                    SendMessageToPC(oPC, "<cÍ]]>--(None)</c>");
                }

                oChannelMember = GetFirstPC();
                SendMessageToPC(oPC, "Current DM Channel Viewers:");

                while(GetIsObjectValid(oChannelMember))
                {
                    if(GetLocalInt(oChannelMember, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oChannelMember))
                    {
                        SendMessageToPC(oPC, "<c#ßþ>--" + GetName(oChannelMember) + " (" + GetLocalString(oChannelMember, "STAFF_MEMBER") + ")</c>");
                        nDMMembersFound++;
                    }
                    oChannelMember = GetNextPC();
                }

                if(nDMMembersFound == 0)
                {
                    SendMessageToPC(oPC, "<c ¿þ>--(None)</c>");
                }

                return;
            }
            break;
        case 5:
            //Commands with a length of 5 characters.
            /*if(sChatCommand == "buffs" && DEBUG_MODE == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_STRENGTH, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_DEXTERITY, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_CONSTITUTION, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_INTELLIGENCE, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_WISDOM, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_CHARISMA, 12)), oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectHaste()), oPC);
                return;
            }*/
            if(sChatCommand == "cast1")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE1, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "cast2")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE2, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "cheer")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_VICTORY1);
                return;
            }
            /*else if(sChatCommand == "light") //Subrace special light spell.
            {
                nCurrentSpecialAbilityUses = GetLocalInt(oPC, "CURRENT_LIGHT_CASTINGS");
                if(nCurrentSpecialAbilityUses > 0)
                {
                    SetLocalInt(oPC, "LIGHT_CAST_VIA_SUBRACE", TRUE); //Read by the light script; this will ensure that light is cast at the PC's ECL-adjusted character level.
                    DelayCommand(6.0, DeleteLocalInt(oPC, "LIGHT_CAST_VIA_SUBRACE"));
                    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_LIGHT, OBJECT_SELF, METAMAGIC_ANY, TRUE));
                    nCurrentSpecialAbilityUses--;
                    SetLocalInt(oPC, "CURRENT_LIGHT_CASTINGS", nCurrentSpecialAbilityUses);
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You now have " + IntToString(nCurrentSpecialAbilityUses) + " use(s) of light left.</c>");
                }
                else
                {
                    if(GetLocalInt(oPC, "LIGHT_CASTINGS_PER_DAY") > 0)
                    {
                        FloatingTextStringOnCreature("<cþŒ >*You must rest in order to replenish your light spell(s).*</c>", oPC, FALSE);
                    }
                    else
                    {
                        SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot cast light from the chat console.</c>");
                    }
                }
                return;
            }*/ //Subraces now cast racial spells via player tools.
            else if(sChatCommand == "drink")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_DRINK);
                return;
            }
            else if(sChatCommand == "dodge")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_DODGE_SIDE);
                return;
            }
            else if(sChatCommand == "drunk")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_PAUSE_DRUNK, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "greet")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_GREETING);
                return;
            }
            else if(sChatCommand == "kneel")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_MEDITATE, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "laugh")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_TALK_LAUGHING, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "plead")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_TALK_PLEADING, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "spasm")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_SPASM, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "taunt")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_TAUNT);
                return;
            }
            break;
        case 4:
            //Commands with a length of 4 characters.
            /*if(sChatCommand == "fire" && DEBUG_MODE == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(100, DAMAGE_TYPE_FIRE), oPC);
                return;
            }*/
            if(sChatCommand == "cast")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_CONJURE1, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "duck")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_DODGE_DUCK);
                return;
            }
            else if(sChatCommand == "fall")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_DEAD_FRONT, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "hunt")
            {
                AnphSendExpeditionCall(oPC);
                return;
            }
            else if(sChatCommand == "look")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_LOOK_FAR, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "pray")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_MEDITATE, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "read")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_READ);
                return;
            }
            else if(sChatCommand == "save")
            {
                if(GetAppearanceType(oPC) > 6)
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot save your character while polymorphed.");
                }
                else
                {
                    SavePCDatabaseVariables(oPC);
                    ExportSingleCharacter(oPC);
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] Your character has been saved.");
                }
                return;
            }
            else if(sChatCommand == "wave")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_GREETING);
                return;
            }
            else if(sChatCommand == "yawn")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_PAUSE_BORED);
                return;
            }
            break;
        case 3:
            //Commands with a length of 3 characters.
            if(sChatCommand == "beg")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_TALK_PLEADING, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "bow")
            {
                EmoteAction(oPC, ANIMATION_FIREFORGET_BOW);
                return;
            }
            else if(sChatCommand == "die")
            {
                if(GetTag(GetArea(oPC)) == "AxfellFuguePlane" || GetTag(GetArea(oPC)) == "CleavenFuguePlane"  || GetTag(GetArea(oPC)) == "ADream_ud")
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] Despite your best efforts, you seem incapable of dying. Perhaps you would have more luck if you were alive.</c>");
                }
                else
                {
                    SendMessageToPC(oPC, "<c¥¥¥>[Server] You die. How tragic.</c>");
                    SetLocalInt(oPC, "PvPDeath", 2);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(oPC) * 2 + 100), oPC);
                }
                return;
            }
            else if(sChatCommand == "exp")
            {
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Experience Points Total: " + IntToString(GetXP(oPC) + GetVirtualXP(oPC)) + "</c>");
                return;
            }
            else if(sChatCommand == "low")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_GET_LOW, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "mid")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_GET_MID, LOOPING_ANIMATION_DURATION);
                return;
            }
            else if(sChatCommand == "pvp")
            {
                int nDefaultPvPStance = GetLocalInt(oPC, "DEFAULT_PVP_STANCE");
                int nCurrentPvPStance = GetLocalInt(oPC, "CURRENT_PVP_STANCE");
                switch (nDefaultPvPStance)
                {
                    case 0:
                        return;
                    case 1:
                        SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now hostile to all members of the opposing faction.</c>");
                        SetLocalInt(oPC, "DEFAULT_PVP_STANCE", 2);
                        SetLocalInt(oPC, "CURRENT_PVP_STANCE", 2);
                        if(nCurrentPvPStance == 1)
                            CheckPlayerTeam(oPC);
                        break;
                    case 2:
                        SendMessageToPC(oPC, "<c¥¥¥>[Server] You will be set neutral to all members of the opposing faction, while in neutral territory, after a short period of time.</c>");
                        if(GetLocalInt(oPC, "REMOVE_PVP_FLAG") != -1)
                            SetLocalInt(oPC, "REMOVE_PVP_FLAG", GetSecondsSinceServerBoot() + PVP_FLAG_DURATION);
                        SetLocalInt(oPC, "DEFAULT_PVP_STANCE", 1);
                        break;
                }
                return;
            }
            else if(sChatCommand == "sit")
            {
                EmoteAction(oPC, ANIMATION_LOOPING_SIT_CROSS, LOOPING_ANIMATION_DURATION);
                return;
            }
            break;
        case 2:
            //Commands with a length of 2 characters.
            if(sChatCommand == "xp")
            {
                SendMessageToPC(oPC, "<c¥¥¥>[Server] Experience Points Total: " + IntToString(GetXP(oPC) + GetVirtualXP(oPC)) + "</c>");
                return;
            }
            break;
    }
    //If we've gotten this far, the PC input a command, but it wasn't a valid one.
    SendMessageToPC(oPC, "<c¥¥¥>[Server] That command was not valid.");
}

void EmoteAction(object oPC, int nEmote, float fDuration = 0.0, float fSpeed = 1.0)
{
    AssignCommand(oPC, ActionPlayAnimation(nEmote, fSpeed, fDuration));
}

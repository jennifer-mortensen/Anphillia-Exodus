#include "fb_inc_chat"
#include "_inc_staff"

#include "NW_I0_GENERIC"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

const string FB_CONSOLE_PREFIX = "-"; // Change this to the prefix used for your console commands

int GetIsPossessingNPC(object oPC)
{
    vector vPosition = GetPosition(oPC);
    if(GetIsDM(oPC) && vPosition.x == 0.0 && vPosition.y == 0.0 && vPosition.z == 0.0)
        return TRUE;
    return FALSE;
}

int GetIsPossessingFamiliar(object oPC)
{
    object oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if(!GetIsObjectValid(oAssociate))
        return FALSE;
    if(GetIsPossessedFamiliar(oAssociate))
        return TRUE;
    return FALSE;
}

void fbParseEmotes(object oSpeaker, string sString)
{
    if (FindSubString(sString, "*kneels*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 3600.0));
    }
    else if (FindSubString(sString, "*threatens*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
    }
    else if (FindSubString(sString, "*taunts*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
    }
    else if (FindSubString(sString, "*worships*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 3600.0));
    }
    else if (FindSubString(sString, "*cheers*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
    }
    else if (FindSubString(sString, "*laughs*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0));
        PlayVoiceChat(VOICE_CHAT_LAUGH, oSpeaker);
    }
    else if (FindSubString(sString, "*falls*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 3600.0));
    }
    else if (FindSubString(sString, "*lies*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3600.0));
    }
    else if (FindSubString(sString, "*reads*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_READ));
    }
    else if (FindSubString(sString, "*sits*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 3600.0));
    }
    else if (FindSubString(sString, "*waves*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_GREETING));
    }
    else if (FindSubString(sString, "*bows*") != -1)
    {
        AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_BOW));
    }
}
void main()
{
    object oSpeaker = OBJECT_SELF;
    string sSpeaker = GetName(oSpeaker);
    string sChatTarget;
    object oPC;
    object oChatRelay = GetObjectByTag("MODULE_CHAT_RELAY");

    // Get the text
    string sRaw = fbCHGetRawString();             // Raw data used internally
    int nChannel = fbCHGetChannel(sRaw);          // The channel used (DM channels handled seperately)
    int nVolume = TALKVOLUME_TALK;                // The volume (set later on)
    object oTellTarget = fbCHGetTellTarget(sRaw); // The target of a tell
    string sString = fbCHGetStringFrom(sRaw, 12); // The actual text spoken
    string sQuotes = GetName(GetObjectByTag("QUOTATION_HOLDER"));;

    // Other variables needed later on
    object oModule = GetModule();
    object oArea = GetArea(oSpeaker);

    int nSubString;

    //J. Persinne; Staff Channel and Staff Tell Handling
    if(GetStringLeft(sString, 3) == "/x ")
    {
        fbCHSuppress();
        if(!GetIsStaffMember(oSpeaker))
            return;
        if(GetLocalInt(oSpeaker, "STAFF_CHANNEL_ENABLED") == FALSE)
        {
            SendMessageToPC(oSpeaker, "<c¥¥¥>[Server] You have joined the staff channel.");
            SetLocalInt(oSpeaker, "STAFF_CHANNEL_ENABLED", TRUE);
            oPC = GetFirstPC();
            while(oPC != OBJECT_INVALID)
            {
                if(GetLocalInt(oPC, "STAFF_CHANNEL_ENABLED") == TRUE && oPC != oSpeaker)
                {
                    SendMessageToPC(oPC, "<cÍ]]>" + GetName(oSpeaker) + " (" + GetLocalString(oSpeaker, "STAFF_MEMBER") + ") has joined the staff channel.</c>");
                }
                oPC = GetNextPC();
            }
        }
        sString = GetStringRight(sString, GetStringLength(sString) - 3);
        string sStaffMember = GetLocalString(oSpeaker, "STAFF_MEMBER");
        SetName(oChatRelay, sStaffMember);
        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {
            if(GetLocalInt(oPC, "STAFF_CHANNEL_ENABLED") == TRUE)
            {
                if(!GetIsPossessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                    fbCHSpeakString(oChatRelay, "<cÍ]]>[Staff] " + sString + "</c>", CHAT_CHANNEL_PRIVATE, oPC);
                else
                    //SendMessageToPC(oPC, "<c ¿þ>" + GetLocalString(oSpeaker, "STAFF_MEMBER") + ": </c><cÍ]]>[Staff] " + sString + "</c>");
                    return;
            }
            oPC = GetNextPC();
        }
        return;
    }
    else if(GetStringLeft(sString, 5) == "/xt " + sQuotes)
    {
        fbCHSuppress();
        if(!GetIsStaffMember(oSpeaker))
            return;
        sString = GetStringRight(sString, GetStringLength(sString) - 5);
        nSubString = FindSubString(sString, sQuotes);
        if(nSubString == -1)
        {
            SendMessageToPC(oSpeaker, "<c¥¥¥>[Server] That command was not valid.");
            return;
        }
        sChatTarget = GetStringLeft(sString, nSubString);
        sString = GetStringRight(sString, GetStringLength(sString) - GetStringLength(sChatTarget) - 2);
        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {
            if(GetName(oPC) == sChatTarget)
            {
                if(GetIsPossessingFamiliar(oPC) || GetIsPossessingFamiliar(oSpeaker) || GetIsPossessingNPC(oPC) || GetIsPossessingNPC(oSpeaker))
                {
                    SendMessageToPC(oSpeaker, "<c¥¥¥>[Server] Send message failed; either you or the target were possessing a familiar or NPC.</c>");
                }
                else
                {
                    SetName(oChatRelay, "[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER"));
                //if(!GetIsPosessingNPC(oSpeaker) && !GetIsPossessingFamiliar(oSpeaker))
                    fbCHSpeakString(oChatRelay, "{Sent to Character: " + sChatTarget + "} " + sString, CHAT_CHANNEL_PRIVATE, oSpeaker);
                //else
                //    SendMessageToPC(oPC, "<c ¿þ>[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER") + ": </c><c#þ#>[Tell] {Sent to Character: " + sChatTarget + "} " + sString + "</c>");
                //if(!GetIsPosessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                    fbCHSpeakString(oChatRelay, sString, CHAT_CHANNEL_PRIVATE, oPC);
                //else
                //    SendMessageToPC(oPC, "<c ¿þ>[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER") + ": </c><c#þ#>[Tell] " + sString + "</c>");
                }
                return;
            }
            oPC = GetNextPC();
        }
        SendMessageToPC(oSpeaker, "Player not found.");
        return;
    }
    else if(GetStringLeft(sString, 6) == "/xtp " + sQuotes)
    {
        fbCHSuppress();
        if(!GetIsStaffMember(oSpeaker))
            return;
        sString = GetStringRight(sString, GetStringLength(sString) - 6);
        nSubString = FindSubString(sString, sQuotes);
        if(nSubString == -1)
        {
            SendMessageToPC(oSpeaker, "<c¥¥¥>[Server] That command was not valid.");
            return;
        }
        sChatTarget = GetStringLeft(sString, nSubString);
        sString = GetStringRight(sString, GetStringLength(sString) - GetStringLength(sChatTarget) - 2);
        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {
            if(GetPCPlayerName(oPC) == sChatTarget)
            {
                if(GetIsPossessingFamiliar(oPC) || GetIsPossessingFamiliar(oSpeaker) || GetIsPossessingNPC(oPC) || GetIsPossessingNPC(oSpeaker))
                {
                    SendMessageToPC(oSpeaker, "<c¥¥¥>[Server] Send message failed; either you or the target were possessing a familiar or NPC.</c>");
                }
                else
                {
                    SetName(oChatRelay, "[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER"));
                //if(!GetIsPosessingNPC(oSpeaker) && !GetIsPossessingFamiliar(oSpeaker))
                    fbCHSpeakString(oChatRelay, "{Sent to Player: " + sChatTarget + "} " + sString, CHAT_CHANNEL_PRIVATE, oSpeaker);
                //else
                 //   SendMessageToPC(oPC, "<c ¿þ>[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER") + ": </c><c#þ#>[Tell] {Sent to Player: " + sChatTarget + "} " + sString + "</c>");
                //if(!GetIsPosessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                    fbCHSpeakString(oChatRelay, sString, CHAT_CHANNEL_PRIVATE, oPC);
                //else
                //    SendMessageToPC(oPC, "<c ¿þ>[DM] " + GetLocalString(oSpeaker, "STAFF_MEMBER") + ": </c><c#þ#>[Tell] " + sString + "</c>");
                }
                return;
            }
            oPC = GetNextPC();
        }
        SendMessageToPC(oSpeaker, "Player not found.");
        return;
    }
    //---End Staff Channel and Staff Tell Handling
    // Individual channels
    switch (nChannel)
    {
        case CHAT_CHANNEL_TALK:
            nVolume = TALKVOLUME_TALK;
            //if (GetIsDead(oSpeaker))
            //{
            //    fbCHSuppress(); // If the PC is dead, they can't talk obviously. You may comment this bit out (same with whisper).
            //    return;
            //}
            WriteTimestampedLogEntry("["+sSpeaker+"][Channel:Talk]"+sString);
            break;

        case CHAT_CHANNEL_SHOUT:
            nVolume = TALKVOLUME_SHOUT;
            fbCHSuppress();
            WriteTimestampedLogEntry("["+sSpeaker+"][Channel:Shout(BLOCKED)]"+sString);
            //J. Persinne; we've turned this into an area-wide chat channel.  Search through to get all other PCs in the area, and relay the message...
            SetName(oChatRelay, sSpeaker);
            oPC = GetFirstPC();
            while(GetIsObjectValid(oPC))
            {
                if(oArea == GetArea(oPC) || GetIsDM(oPC))
                {
                    if(!GetIsPossessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                        fbCHSpeakString(oChatRelay, "<cþ¥ >[Shout] " + sString + "</c>", CHAT_CHANNEL_PRIVATE, oPC);
                        //SendMessageToPC(oPC, "<c ¿þ>" + sSpeaker + ": </c><cþ¥ >[Shout] " + sString + "</c>");
                }
                oPC = GetNextPC();
            }
            return;
        case CHAT_CHANNEL_WHISPER:
            nVolume = TALKVOLUME_WHISPER;
            //if (GetIsDead(oSpeaker))
            //{
            //    fbCHSuppress();
            //    return;
            //}
            WriteTimestampedLogEntry("["+sSpeaker+"][Channel:Whisper]"+sString);
            break;

        case CHAT_CHANNEL_PRIVATE:
            //WriteTimestampedLogEntry("["+sSpeaker+"][Channel:Tell]"+sString);
            return;

        // Block the party channel (but allow use of console commands through it)
        case CHAT_CHANNEL_PARTY:
            WriteTimestampedLogEntry("["+sSpeaker+"][Channel:Party]"+sString);
            if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX)
                break;
            //fbCHSuppress();
            return;

        // Continue the script if it's a console command, otherwise end it.
        case CHAT_CHANNEL_DM:
            WriteTimestampedLogEntry("["+sSpeaker+"][Channel:DM]"+sString);
            //if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX)
            //    break;
            SetName(oChatRelay, sSpeaker); //J. Persinne; relay DM messages to staff members.
            oPC = GetFirstPC();
            while(GetIsObjectValid(oPC))
            {
                if(GetLocalInt(oPC, "DM_CHANNEL_ENABLED") == TRUE)
                {
                    if(!GetIsPossessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                        fbCHSpeakString(oChatRelay, "<c#ßþ>[DM] " + sString + "</c>", CHAT_CHANNEL_PRIVATE, oPC);
                        //SendMessageToPC(oPC, "<c ¿þ>" + sSpeaker + ": </c><c#ßþ>[DM] " + sString + "</c>");
                }
                oPC = GetNextPC();
            }
            return;

        // DM channels
        case CHAT_CHANNEL_DM_TALK:
            nVolume = TALKVOLUME_TALK;
            WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:Talk]"+sString);
            break;

        case CHAT_CHANNEL_DM_SHOUT:
            nVolume = TALKVOLUME_SHOUT;
            WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:Shout]"+sString);
            if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX)
                break;
            return;

        case CHAT_CHANNEL_DM_WHISPER:
            nVolume = TALKVOLUME_WHISPER;
            WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:Whisper]"+sString);
            break;

        case CHAT_CHANNEL_DM_PRIVATE:
            //WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:Tell]"+sString);
            if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX)
                break;
            return;

        case CHAT_CHANNEL_DM_PARTY:
            WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:Party]"+sString);
            if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX)
                break;
            return;

        case CHAT_CHANNEL_DM_DM:
            WriteTimestampedLogEntry("[DM:"+sSpeaker+"][Channel:DM]"+sString);
            SetName(oChatRelay, sSpeaker); //J. Persinne; relay DM messages to staff members.
            oPC = GetFirstPC();
            while(GetIsObjectValid(oPC))
            {
                if(GetLocalInt(oPC, "DM_CHANNEL_ENABLED") == TRUE)
                {
                    if(!GetIsPossessingNPC(oPC) && !GetIsPossessingFamiliar(oPC))
                        fbCHSpeakString(oChatRelay, "<c#ßþ>[DM] " + sString + "</c>", CHAT_CHANNEL_PRIVATE, oPC);
                        //SendMessageToPC(oPC, "<c ¿þ>" + sSpeaker + ": </c><c#ßþ>[DM] " + sString + "</c>");
                }
                oPC = GetNextPC();
            }
            return;
        default:
            return;
    }

    // Send a message to all DMs. The message will NOT be sent if:
    // - The module integer "FB_OVERRIDE_CHAT" is set.
    // - The area integer "FB_OVERRIDE_CHAT" is set on the area.
    // This is probably the only part of the GS script that's still in-tact here!
    //if (!GetLocalInt(oModule, "FB_OVERRIDE_CHAT") &&
    //    !GetLocalInt(oArea, "FB_OVERRIDE_CHAT"))
    //    SendMessageToAllDMs("<cVs·>[" + GetName(GetArea(oSpeaker)) + "] " +
    //                        "<cþôh>" + sSpeaker + ": " +
    //                        "<cÆ±˜>" + sString);

    //if (GetIsDead(oSpeaker)) return; // Disallow use of the console or emotes for dead PCs

    return;

    // Console set up
    int nConsole = FALSE;
    //if (GetStringLeft(sString, 1) == FB_CONSOLE_PREFIX) nConsole = TRUE;

    // Emotes
    if (FindSubString(sString, "*") != -1 && !nConsole)
    {
        fbParseEmotes(oSpeaker, sString);
    }

    if (nConsole)
    {
        fbCHSuppress();
        if (sString == "") // Provide instructions
        {
            //.. insert your code here
            return;
        }

        // player commands
        if (!GetIsDM(oSpeaker))
        {
            //.. insert your code here
        }

        // DM commands
        else
        {
            //.. insert your code here
        }
    }
}

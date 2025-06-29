//////

string CAMPAIGN_NAME = "AnphilliaCNR";

void
AnphCampaignSyncPlayer (object oPC)
{
    int i;
    int iVal;
    float fVal;
    string sVal;
    string sVarName;
    location lLoc;


    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oPC, "__SET_INT__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oPC, "__SET_INT__" + IntToString (i));
            iVal = GetLocalInt (oPC, sVarName);
            SetCampaignInt (CAMPAIGN_NAME, sVarName, iVal, oPC);
            //SendMessageToAllDMs ("Sync player int " + sVarName);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oPC, "__SET_FLOAT__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oPC, "__SET_FLOAT__" + IntToString (i));
            fVal = GetLocalFloat (oPC, sVarName);
            SetCampaignFloat (CAMPAIGN_NAME, sVarName, fVal, oPC);
            //SendMessageToAllDMs ("Sync player float " + sVarName);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oPC, "__SET_STRING__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oPC, "__SET_STRING__" + IntToString (i));
            sVal = GetLocalString (oPC, sVarName);
            SetCampaignString (CAMPAIGN_NAME, sVarName, sVal, oPC);
            //SendMessageToAllDMs ("Sync player float " + sVarName);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oPC, "__SET_LOC__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oPC, "__SET_LOC__" + IntToString (i));
            lLoc = GetLocalLocation (oPC, sVarName);
            SetCampaignLocation (CAMPAIGN_NAME, sVarName, lLoc, oPC);
            //SendMessageToAllDMs ("Sync player location " + sVarName);
        } else {
            break;
        }
    }
}

void
AnphCampaignSyncPlayers ()
{
    object oPC;
    int i;
    string sVarName;
    oPC = GetFirstPC ();

    while (GetIsObjectValid (oPC))
    {
        AnphCampaignSyncPlayer (oPC);
        oPC = GetNextPC ();
    }
}

void
AnphCampaignSyncGlobal ()
{
    int i;
    int iVal;
    float fVal;
    string sVal;
    object oObject;
    string sVarName;
    location lLoc;

    oObject = GetObjectByTag ("AnphCampaign");
    if (!GetIsObjectValid (oObject))
        return;

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oObject, "__SET_INT__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oObject, "__SET_INT__" + IntToString (i));
            iVal = GetLocalInt (oObject, sVarName);
            SetCampaignInt (CAMPAIGN_NAME, sVarName, iVal);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oObject, "__SET_FLOAT__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oObject, "__SET_FLOAT__" + IntToString (i));
            fVal = GetLocalFloat (oObject, sVarName);
            SetCampaignFloat (CAMPAIGN_NAME, sVarName, fVal);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oObject, "__SET_STRING__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oObject, "__SET_STRING__" + IntToString (i));
            sVal = GetLocalString (oObject, sVarName);
            SetCampaignString (CAMPAIGN_NAME, sVarName, sVal);
        } else {
            break;
        }
    }

    i = 0;
    while (1)
    {
        i++;
        sVarName = GetLocalString (oObject, "__SET_LOC__" + IntToString (i));
        if (sVarName != "")
        {
            DeleteLocalString (oObject, "__SET_LOC__" + IntToString (i));
            lLoc = GetLocalLocation (oObject, sVarName);
            SetCampaignLocation (CAMPAIGN_NAME, sVarName, lLoc);
        } else {
            break;
        }
    }

}


void
AnphSetCampaignInt (string sVarName, int nInt, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int i;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return;
    }

    //ActionSpeakString ("Set Int key = " + sVarName, TALKVOLUME_SHOUT);

    SetLocalInt (oObject, sVarName, nInt);
    SetLocalInt (oObject, sVarName + "__INT_ISSET__", 1);

    i = 0;
    do
    {
        i++;
        sVarSave = GetLocalString (oObject, "__SET_INT__" + IntToString (i));
        if (sVarSave == sVarName)
        {
            return;
        }
    } while (sVarSave != "");

    /* The int was not found to be set prior, so we mark it as
       requiring saving. */
    SetLocalString (oObject, "__SET_INT__" + IntToString (i), sVarName);
}

int
AnphGetCampaignInt (string sVarName, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int nIsSet;
    int nVal;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return (0);
    }

    if (GetLocalInt (oObject, sVarName + "__INT_ISSET__"))
    {
        //ActionSpeakString ("Get Int (cached) key = " + sVarName, TALKVOLUME_SHOUT);
        return (GetLocalInt (oObject, sVarName));
    }

    //ActionSpeakString ("Get (uncached) Int key = " + sVarName, TALKVOLUME_SHOUT);
    nVal = GetCampaignInt (CAMPAIGN_NAME, sVarName, oPlayer);

    SetLocalInt (oObject, sVarName, nVal);
    SetLocalInt (oObject, sVarName + "__INT_ISSET__", 1);

    return (nVal);
}

void
AnphSetCampaignFloat (string sVarName, float flFloat, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int i;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return;
    }

    SetLocalFloat (oObject, sVarName, flFloat);
    SetLocalInt (oObject, sVarName + "__FLOAT_ISSET__", 1);

    i = 0;
    do
    {
        i++;
        sVarSave = GetLocalString (oObject, "__SET_FLOAT__" + IntToString (i));
        if (sVarSave == sVarName)
        {
            return;
        }
    } while (sVarSave != "");

    /* The float was not found to be set prior, so we mark it as
       requiring saving. */
    SetLocalString (oObject, "__SET_FLOAT__" + IntToString (i), sVarName);
}

float
AnphGetCampaignFloat(string sVarName, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int nIsSet;
    float nVal;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return (0.0);
    }

    if (GetLocalInt (oObject, sVarName + "__FLOAT_ISSET__"))
    {
        return (GetLocalFloat (oObject, sVarName));
    }

    nVal = GetCampaignFloat (CAMPAIGN_NAME, sVarName, oPlayer);

    SetLocalFloat (oObject, sVarName, nVal);
    SetLocalInt (oObject, sVarName + "__FLOAT_ISSET__", 1);

    return (nVal);
}

void
AnphSetCampaignString (string sVarName, string sString, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int i;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return;
    }

    SetLocalString (oObject, sVarName, sString);
    SetLocalInt (oObject, sVarName + "__STRING_ISSET__", 1);

    i = 0;
    do
    {
        i++;
        sVarSave = GetLocalString (oObject, "__SET_STRING__" + IntToString (i));
        if (sVarSave == sVarName)
        {
            return;
        }
    } while (sVarSave != "");

    /* The float was not found to be set prior, so we mark it as
       requiring saving. */
    SetLocalString (oObject, "__SET_STRING__" + IntToString (i), sVarName);
}

string
AnphGetCampaignString(string sVarName, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int nIsSet;
    string sVal;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return ("");
    }

    if (GetLocalInt (oObject, sVarName + "__STRING_ISSET__"))
    {
        return (GetLocalString (oObject, sVarName));
    }

    sVal = GetCampaignString (CAMPAIGN_NAME, sVarName, oPlayer);

    SetLocalString (oObject, sVarName, sVal);
    SetLocalInt (oObject, sVarName + "__STRING_ISSET__", 1);

    return (sVal);
}


void
AnphSetCampaignLocation (string sVarName, location lLoc, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int i;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return;
    }

    SetLocalLocation (oObject, sVarName, lLoc);
    SetLocalInt (oObject, sVarName + "__LOC_ISSET__", 1);

    i = 0;
    do
    {
        i++;
        sVarSave = GetLocalString (oObject, "__SET_LOC__" + IntToString (i));
        if (sVarSave == sVarName)
        {
            return;
        }
    } while (sVarSave != "");

    /* The float was not found to be set prior, so we mark it as
       requiring saving. */
    SetLocalString (oObject, "__SET_LOC__" + IntToString (i), sVarName);
}

location
AnphGetCampaignLocation(string sVarName, object oPlayer=OBJECT_INVALID)
{
    object oObject;
    string sVarSave;
    int nIsSet;
    location lLoc;

    if (GetIsObjectValid (oPlayer))
    {
        oObject = oPlayer;
    } else {
        oObject = GetObjectByTag ("AnphCampaign");
        if (!GetIsObjectValid (oObject))
            return (lLoc);
    }

    if (GetLocalInt (oObject, sVarName + "__LOC_ISSET__"))
    {
        return (GetLocalLocation (oObject, sVarName));
    }

    lLoc = GetCampaignLocation (CAMPAIGN_NAME, sVarName, oPlayer);

    SetLocalLocation (oObject, sVarName, lLoc);
    SetLocalInt (oObject, sVarName + "__LOC_ISSET__", 1);

    return (lLoc);
}



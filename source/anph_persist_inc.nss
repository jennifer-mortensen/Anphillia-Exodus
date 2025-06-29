

void AnphPersistParsePair (string sStrChunk)
{
    int iPos;
    int iPos2;
    string sKey;
    string sType;
    string sValue;
    int iStrLen = GetStringLength (sStrChunk);
    //object oPC = GetFirstPC ();
    object oSavingMarker = GetObjectByTag ("SavingMarker");

    //SendMessageToPC (oPC, "Parsing: " + sStrChunk);

    iPos = FindSubString (sStrChunk, "`");
    // we'll now be at the start of the key
    sStrChunk = GetSubString (sStrChunk, iPos + 1, iStrLen);
    iStrLen -= (iPos + 1);

    // Find the next `.
    iPos = FindSubString (sStrChunk, "`");
    sKey = GetSubString (sStrChunk, 0, iPos);

    sStrChunk = GetSubString (sStrChunk, iPos + 1, iStrLen);
    iStrLen -= (iPos + 1);

    // We're now at the type.
    sType = GetSubString (sStrChunk, 0, 1);

    sStrChunk = GetSubString (sStrChunk, 2, iStrLen);
    iStrLen -= 2;

    // And now the value.
    iPos = FindSubString (sStrChunk, "`");
    sValue = GetSubString (sStrChunk, 0, iPos);


    //SendMessageToPC (oPC, "Key: '" + sKey + "', Value: '"
    //                 + sValue + "', type: " + sType);

    if (sType == "S")
    {
        SetLocalString (oSavingMarker, sKey, sValue);
    } else if (sType == "I")
    {
        SetLocalInt (oSavingMarker, sKey, StringToInt (sValue));
    } else if (sType == "F")
    {
         SetLocalFloat (oSavingMarker, sKey, StringToFloat (sValue));
    } else if (sType == "L")
    {
        vector vPos;
        float fFacing;
        string sArea;
        string sPart;
        int iPartLen;
        location lLoc;

        iPartLen = FindSubString (sValue, ":");
        sPart = GetSubString (sValue, 0, iPartLen);
        vPos.x = StringToFloat (sPart);
        sValue = GetSubString (sValue, iPartLen + 1, GetStringLength (sValue));

     //   SendMessageToPC (oPC, "sPart: '" + sPart + "', sValue: '"
     //                    + sValue + "'");

        iPartLen = FindSubString (sValue, ":");
        sPart = GetSubString (sValue, 0, iPartLen);
        vPos.y = StringToFloat (sPart);
        sValue = GetSubString (sValue, iPartLen + 1, GetStringLength (sValue));
     //   SendMessageToPC (oPC, "sPart: '" + sPart + "', sValue: '"
     //                    + sValue + "'");

        iPartLen = FindSubString (sValue, ":");
        sPart = GetSubString (sValue, 0, iPartLen);
        vPos.z = StringToFloat (sPart);
        sValue = GetSubString (sValue, iPartLen + 1, GetStringLength (sValue));

        iPartLen = FindSubString (sValue, ":");
        sPart = GetSubString (sValue, 0, iPartLen);
        fFacing = StringToFloat (sPart);
        sValue = GetSubString (sValue, iPartLen + 1, GetStringLength (sValue));

        // And all that should be left is the area.
        sArea = sValue;
        object oArea;

        if (sArea != "")
        {
            oArea = GetObjectByTag (sArea);
        }
        /*
        SendMessageToPC (oPC, "x: " + FloatToString (vPos.x) + " y:" +
                         FloatToString (vPos.y)
                         + " z: " + FloatToString (vPos.z) + " facing: " +
                         FloatToString (fFacing) +
                         " Area: " + sArea);
        */
        if (GetIsObjectValid (oArea))
        {
            lLoc = Location (GetObjectByTag (sArea), vPos, fFacing);
            SetLocalLocation (oSavingMarker, sKey, lLoc);
        }
    }

}


void AnphPersistParseDB (object oObj)
{
    string sPairs = GetName (oObj);
    int iPos;
    int iStrLen = GetStringLength (sPairs);
    int iLen;
    int iDone = 0;
    int i;
    string sLen;
    string sKey;
    string sValue;
    string sStrChunk;
    //object oPC = GetFirstPC ();

    // Take the first bit off the string up to the first entry
    iPos = FindSubString (sPairs, " ");
    sPairs = GetSubString (sPairs, iPos, iStrLen);
    iStrLen -= iPos;

    // Find the first `, and take everything before that
    // to be the length.
    iPos = FindSubString (sPairs, "`");
    sLen = GetSubString (sPairs, 0, iPos);
    iLen = StringToInt (sLen);

    //SendMessageToPC (oPC, "length of full string is " + IntToString (iStrLen) +
    //                 " first length is '" + sLen + "'");

    do
    {
        if (iPos > 0)
        {
            // Get a string chunk for us to parse.  This
            // will contain the length plus the key/value.
            sStrChunk = GetSubString (sPairs, 0, iLen + GetStringLength (sLen));
            AnphPersistParsePair (sStrChunk);

            sPairs = GetSubString (sPairs, iLen + GetStringLength (sLen), iStrLen);
            iStrLen -= (iLen + GetStringLength (sLen));

            // Find the length of the next value/key pair.
            iPos = FindSubString (sPairs, "`");
            sLen = GetSubString (sPairs, 0, iPos);
            iLen = StringToInt (sLen);

        } else {
            iDone = 1;
        }

    }
    while (!iDone);

    object oSavingMarker;
    oSavingMarker = GetObjectByTag ("SavingMarker");
}


void AnphPersistModuleInit ()
{
    location lLoc;
    object oSavingMarker;
    oSavingMarker = GetObjectByTag ("SavingMarker");
    lLoc = GetLocation (oSavingMarker);

    object oObj = CreateObject (OBJECT_TYPE_ITEM, "persistanceobjec", lLoc);
    SetLocalObject (oSavingMarker, "SavingObject", oObj);

    AnphPersistParseDB (oObj);
}



void SetAnphInt (string sKey, int iValue)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`I`" +
                              IntToString (iValue) + "`");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    SetLocalInt (oSavingMarker, sKey, iValue);
}

void SetAnphFloat (string sKey, float fValue)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`F`" +
                              FloatToString (fValue) + "`");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    SetLocalFloat (oSavingMarker, sKey, fValue);
}

void SetAnphLocation (string sKey, location lValue)
{
    //SaveAnphString (sKey, FloatToString (lValue));
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    SetLocalLocation (oSavingMarker, sKey, lValue);

    string sLocStr;
    vector vPos = GetPositionFromLocation (lValue);
    float fFacing = GetFacingFromLocation (lValue);
    string sArea = GetTag (GetAreaFromLocation(lValue));

    if (sArea == "")
        return;

    sLocStr = FloatToString (vPos.x, 0, 2) + ":" +
               FloatToString (vPos.y, 0, 2) + ":" +
               FloatToString (vPos.z, 0, 2) + ":" +
               FloatToString (fFacing, 0, 2) + ":" +
               sArea;

    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`L`" +
                              sLocStr + "`");
}

string AnphPCID (object oPC)
{
    string sID = GetName(oPC) + GetPCPublicCDKey (oPC);
    return (sID);
}

void SetAnphString (string sKey, string sValue)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`S`" +
                              sValue + "`");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    SetLocalString (oSavingMarker, sKey, sValue);
}

void DeleteAnphInt (string sKey)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`D``");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    DeleteLocalInt (oSavingMarker, sKey);
}

void DeleteAnphFloat (string sKey)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`D``");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    DeleteLocalFloat (oSavingMarker, sKey);
}

void DeleteAnphLocation (string sKey)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`D``");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    DeleteLocalLocation (oSavingMarker, sKey);
}

void DeleteAnphString (string sKey)
{
    WriteTimestampedLogEntry ("AnphPersist: `" + sKey + "`D``");
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    DeleteLocalString (oSavingMarker, sKey);
}

int GetAnphInt (string sKey)
{
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    return (GetLocalInt (oSavingMarker, sKey));
}

float GetAnphFloat (string sKey)
{
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    return (GetLocalFloat (oSavingMarker, sKey));
}

location GetAnphLocation (string sKey)
{
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    return (GetLocalLocation (oSavingMarker, sKey));
}

string GetAnphString (string sKey)
{
    object oSavingMarker = GetObjectByTag ("SavingMarker");
    return (GetLocalString (oSavingMarker, sKey));
}


/* for testing.. */

/*
void main()
{
    object oPC = GetFirstPC ();
    object oSavingMarker = GetObjectByTag ("SavingMarker");

    if (!GetIsObjectValid (oSavingMarker))
    {
        SendMessageToPC (oPC, "savingmarker invalid");
    }

    object oObj = GetLocalObject (oSavingMarker, "SavingObject");

    AnphPersistParseDB (oObj);
}
*/

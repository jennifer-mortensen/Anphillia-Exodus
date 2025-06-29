/** $Id: cs__inc_debug.nss 1.2 2004/03/31 09:00:36 schoeps Exp schoeps $
 ** $Log: cs__inc_debug.nss $
 ** Revision 1.2  2004/03/31 09:00:36  schoeps
 ** Refined the debugging functions, added comments
 **
 ** Revision 1.1  2004/03/31 08:36:22  schoeps
 ** Initial revision
 ** Revision 1.1.1  2004/12/05 Azzmodan
 ** Added prototyping.
 **
 **/




// Important error messages. They are sent to the DMs if Debug mode is on, and logged all the time.
void ErrorMessage(string sMsg);

// These messages are not as important, they are sent to the debug PC if the debug mode has been activated.
void DebugMessage( string sMsg, int iLevel = 0 );

//** Determine if the debug mode has been turned on
int GetDebugIsActive();


//** As the name says. Allows to supply an object to send messages to
void ToggleDebugMode( object oNewDebugger = OBJECT_INVALID );


//** Determine if the debug mode has been turned on
int GetDebugIsActive();

//** determine who should get the debug messages. That is the local PC OR me as found out by reading the CD key
void DetermineDebugCharacer();


//** Since I want to test with a PC, I need to remember whom to sent the Debug messages
object g_objDebugPC;
int g_iDebugLevel = 100;


string MakePosition( object oTarget )
{
    int iX = FloatToInt(GetPosition(oTarget).x);
    int iY = FloatToInt(GetPosition(oTarget).y);

    return "(" + IntToString(iX) + "/" + IntToString(iY) + ")";
}

/*
string MakePositionFromLocation( location locTarget )
{
    int iX = FloatToInt(locTarget.x);
    int iY = FloatToInt(locTarget.y);

    return "(" + IntToString(iX) + "/" + IntToString(iY) + ")";
}
*/

//** determine who should get the debug messages. That is the local PC OR me,
//** as found out by reading the CD key
void DetermineDebugCharacer()
{
    g_objDebugPC = GetFirstPC();
    while ( (GetIsObjectValid(g_objDebugPC))
         && (GetPCIPAddress(g_objDebugPC) != "")
         && (GetPCPublicCDKey(g_objDebugPC) != "QMAVJYGJ")
         && (GetPCPublicCDKey(g_objDebugPC) != "VDKK7HFE"))
        g_objDebugPC = GetNextPC();
}

//** Determine if the debug mode has been turned on
int GetDebugIsActive()
{
    return (GetLocalInt(GetModule(), "iDebugIsON" )==1);
}

//** As the name says. Allows to supply an object to send messages to
void ToggleDebugMode( object oNewDebugger = OBJECT_INVALID )
{
    int iMode = GetLocalInt(GetModule(), "iDebugIsON" );
    iMode = 1 - iMode;
    SetLocalInt(GetModule(), "iDebugIsON", iMode );
    WriteTimestampedLogEntry( "DEBUG: Mode is now " + IntToString(iMode) );

    //** add the ability to set the user of the switch as new Debugger
    if (iMode == 1 && oNewDebugger != OBJECT_INVALID)
    {
        if (GetIsObjectValid(g_objDebugPC))
            SendMessageToPC( g_objDebugPC, "DEBUG: " + GetName(oNewDebugger) + " has directed debug messages onto himself." );

        g_objDebugPC = oNewDebugger;
        SendMessageToPC( g_objDebugPC, "DEBUG: messages enabled." );
    }
}



/** These messages are not as important, they are sent to the debug PC if the
 ** debug mode has been activated.
 **/
void DebugMessage( string sMsg, int iLevel = 0 )
{
    if (GetDebugIsActive())
    {
        if (!GetIsObjectValid(g_objDebugPC))
            DetermineDebugCharacer();

        WriteTimestampedLogEntry( "DEBUG:" + sMsg );
//SpeakString( "DEBUG:" + sMsg );
        SendMessageToPC( g_objDebugPC, "DEBUG:" + sMsg );
    }
}

/** Important error messages. They are sent to the DMs if Debug mode is on, and
 ** logged all the time.
 **/
void ErrorMessage( string sMsg )
{
    WriteTimestampedLogEntry( "ERROR:" + sMsg );
    SendMessageToAllDMs( "ERROR: " + sMsg );
    SpeakString("ERROR:" + sMsg );

    if (GetDebugIsActive())
    {
        if (!GetIsObjectValid(g_objDebugPC))
            DetermineDebugCharacer();

        SendMessageToPC( g_objDebugPC, "ERROR:" + sMsg );
    }
}


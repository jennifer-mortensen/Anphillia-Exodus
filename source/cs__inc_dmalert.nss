/** cs__inc_dmalert
 **
 ** notify the DMs of things that happen
 **/
#include "cs__inc_debug"

//** create a readable position from the object passed
//string MakePosition( object oTarget );
//** alert the DM and log the message if the area is not flagged to suppress alerts
void SendDMAlert( string sMessage, object oTarget = OBJECT_INVALID );
//** inform the DM - no log is written, message cannot be suppressed
void SendDMMessage( string sMessage, object oTarget = OBJECT_INVALID, int iLevel=10 );

//** mostly used for cheats as these are logged
void SendDMAlert( string sMessage, object oTarget = OBJECT_INVALID )
{
    WriteTimestampedLogEntry( sMessage );

    //** suppress alerts in areas flagged as such
    if (GetArea(GetNearestObjectByTag( "NoAlert", oTarget, 1)) == GetArea(oTarget))
        return;

    //** write it to the log and then alert the DMs that are online
    SendMessageToAllDMs( sMessage );

    //** if we have something to jump to, set the destination for the DM cloak
    if (GetIsObjectValid(oTarget))
    {
        object oDM=GetFirstPC();
        while (GetIsObjectValid(oDM))
        {
            //** is it a local player?
//            if (GetPCIPAddress(oDM) == "" && GetDebugIsActive() )
//                SendMessageToPC(oDM, sMessage);

            if (GetIsDM(oDM))
                SetLocalLocation(oDM, "lDMAlert", GetLocation(oTarget));
            oDM = GetNextPC();
        }
    }
}

//** this is not an alert, but more a notification for plot points and such
void SendDMMessage( string sMessage, object oTarget = OBJECT_INVALID, int iLevel = 10 )
{
    //** according to the possible levels, act
    switch (iLevel) {
    case 10:
        sMessage = "Plot Info: " + sMessage;
        break;
    }

    SendMessageToAllDMs( sMessage );
    if (GetIsObjectValid(oTarget))
    {
        object oDM=GetFirstPC();
        while (GetIsObjectValid(oDM))
        {
            //** is it a local player?
            if (GetPCIPAddress(oDM) == "" && GetDebugIsActive() )
                SendMessageToPC(oDM, sMessage);

            if (GetIsDM(oDM))
                SetLocalLocation(oDM, "lDMAlert", GetLocation(oTarget));
            oDM = GetNextPC();
        }
    }
}

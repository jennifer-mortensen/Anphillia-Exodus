/** cs__inc_token
 **
 ** I needed token access a lot, so I am going to make this an include
 **
 ** $Log: cs__inc_token.nss $
 ** Revision 1.3  2004/07/04 09:52:36  Carsten
 ** Added float support
 **
 ** Revision 1.2  2004/06/27 11:32:38  Carsten
 ** Deleting INTs from token added
 **
 **/
#include "cs__inc_dmalert"

const string cTokenTag = "nolose_ctoken";

object GetToken(object oPC)
{
    //** If we are an NPC or familiar, return ourselves so the functions have
    //** something to store stuff on
    if (!GetIsPC(oPC)
     || GetIsObjectValid(GetMaster(oPC))
     || GetIsDMPossessed(oPC))
        return oPC;

    object oToken = GetItemPossessedBy(oPC, cTokenTag );
    if (GetIsObjectValid(oToken))
        return oToken;
    else {
//        if (GetLocalInt(oPC, "iTokenWarningIssued") == 0)
//        {
//            SetLocalInt(oPC, "iTokenWarningIssued", 1);
            //** error handling
            SendDMAlert( "BUG: Could not access token object for " + GetName(oPC) + ", creating one", oPC );
//            SendMessageToPC( oPC, "Your character token is missing. This may cause a lot of problems, so a DM has been notified to inspect you. Stand by a moment." );
//            CreateItemOnObject("nolose_ctoken", oPC, 1);
//        }
        return OBJECT_INVALID;
    }
}

void SetStringOnToken(object oPC, string sLabel, string sValue )
{
    object oToken = GetToken(oPC);
    SetLocalString( oToken, sLabel, sValue);
}
void SetTokenString(object oPC, string sLabel, string sValue )
{
    SetStringOnToken(oPC, sLabel, sValue );
}

void SetIntOnToken(object oPC, string sLabel, int iValue )
{
    object oToken = GetToken(oPC);
    SetLocalInt( oToken, sLabel, iValue);
}
void SetTokenInt(object oPC, string sLabel, int iValue)
{
    SetIntOnToken(oPC, sLabel, iValue )
;
}
void SetObjectOnToken(object oPC, string sLabel, object oValue )
{
    object oToken = GetToken(oPC);
    SetLocalObject( oToken, sLabel, oValue);
}
void SetTokenObject(object oPC, string sLabel, object oValue )
{
    SetObjectOnToken(oPC, sLabel, oValue );
}
void SetFloatOnToken(object oPC, string sLabel, float fValue )
{
    object oToken = GetToken(oPC);
    SetLocalFloat( oToken, sLabel, fValue);
}
void SetTokenFloat(object oPC, string sLabel, float fValue )
{
    SetFloatOnToken(oPC, sLabel, fValue );
}


string GetTokenString(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    return GetLocalString( oToken, sLabel);
}
string GetStringFromToken(object oPC, string sLabel )
{
    return GetTokenString(oPC, sLabel);
}
int GetTokenInt(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    return GetLocalInt( oToken, sLabel);
}
int GetIntFromToken(object oPC, string sLabel )
{
    return GetTokenInt(oPC, sLabel);
}
object GetObjectFromToken(object oPC, string sLabel )
{
    object oToken = GetToken(oPC );
    return GetLocalObject( oToken, sLabel);
}
float GetTokenFloat(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    return GetLocalFloat( oToken, sLabel);
}
float GetFloatFromToken(object oPC, string sLabel )
{
    return GetTokenFloat(oPC, sLabel);
}

void DeleteTokenInt(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalInt( oToken, sLabel);
}
void DeleteIntFromToken(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalInt( oToken, sLabel);
}
void DeleteTokenFloat(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalFloat( oToken, sLabel);
}
void DeleteFloatFromToken(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalFloat( oToken, sLabel);
}
void DeleteStringFromToken(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalString( oToken, sLabel);
}
void DeleteTokenString(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalString( oToken, sLabel);
}
void DeleteTokenObject(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalObject( oToken, sLabel);
}

void SetTokenLocation(object oPC, string sLabel, location locValue )
{
    object oToken = GetToken(oPC);
    SetLocalLocation(oToken, sLabel, locValue);
}
location GetTokenLocation(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    return GetLocalLocation(oToken, sLabel);
}
void DeleteTokenLocation(object oPC, string sLabel )
{
    object oToken = GetToken(oPC);
    DeleteLocalLocation(oToken, sLabel);
}


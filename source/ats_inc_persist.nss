/****************************************************
  Persistent Data Wrapper Script
  ats_inc_persist

  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains wrapper functions for a
  persistent data solution. Right now, it just
  wraps the GetLocal and SetLocal functions.
***************************************************/

string cATSDB = "ATS_MAINDB";

string GetPlayerString(object oObject){
    int a = StringToInt(GetPCPlayerName(oObject));
    int b = StringToInt(GetName(oObject));
    return IntToString(a) + IntToString(b);
}

int ATS_GetPersistentInt(object oObject, string sVarName)
{
    string key = GetPlayerString(oObject);

    int i = GetLocalInt(oObject, sVarName);
//SendMessageToPC(oObject, "ATS:GETPERS:localint=" + IntToString(i));
    if(i == 0){
        i = GetCampaignInt(cATSDB, sVarName, oObject);
//SendMessageToPC(oObject, "ATS:GETPERS:(" + GetPCPlayerName(oObject) + GetName(oObject) + sVarName + ")databaseint=" + IntToString(i));
        if(i != 0) SetLocalInt(oObject, sVarName, i);
    }
    return i;
}
/*float ATS_GetPersistentFloat(object oObject, string sVarName)
{
    return GetLocalFloat(oObject, sVarName);
}
location ATS_GetPersistentLocation(object oObject, string sVarName)
{
    return GetLocalLocation(oObject, sVarName);
}
string  ATS_GetPersistentString(object oObject, string sVarName)
{
    return GetLocalString(oObject, sVarName);
}
object ATS_GetPersistentObject(object oObject, string sVarName)
{
    return GetLocalObject(oObject, sVarName);
}*/

void ATS_SetPersistentInt(object oObject, string sVarName, int nValue)
{
    SetLocalInt(oObject, sVarName, nValue);
//SendMessageToPC(oObject, "ATS:SETPERS:(" + GetPCPlayerName(oObject) + GetName(oObject) + sVarName + ")");
    string key = GetPlayerString(oObject);
    SetCampaignInt(cATSDB, sVarName, nValue, oObject);
}
/*void ATS_SetPersistentFloat(object oObject, string sVarName, float fValue)
{
    SetLocalFloat(oObject, sVarName, fValue);
}
void ATS_SetPersistentLocation(object oObject, string sVarName, location lValue)
{
    SetLocalLocation(oObject, sVarName, lValue);
}
void  ATS_SetPersistentString(object oObject, string sVarName, string sValue)
{
    SetLocalString(oObject, sVarName, sValue);
}

void ATS_SetPersistentObject(object oObject, string sVarName, object oValue)
{
    SetLocalObject(oObject, sVarName, oValue);
}*/



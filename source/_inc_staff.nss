//::///////////////////////////////////////////////
//:: Staff Function Library
//:: _inc_staff
//:://////////////////////////////////////////////
/*
    Contains functions for handling special powers
    of staff members on the server.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: June 30, 2009
//:://////////////////////////////////////////////

//Returns TRUE if oPC is on a staff member's CD Key.
int GetIsStaffMember(object oPC);
//Returns the name associated with oPC's staff member CD Key.
string GetStaffMember(object oPC);

//::///////////////////////////////////////////////
//:: GetIsStaffMember
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC is on a staff member's
    CD Key.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: June 30, 2009
//:://////////////////////////////////////////////
int GetIsStaffMember(object oPC)
{
    string sCDKey = GetPCPublicCDKey(oPC, TRUE);
    if(sCDKey == "QVM9JQFJ" || //Aethra
        sCDKey == "FT6GFQU4" || //Aethra
        sCDKey == "VD7N9P76" || //Cryptic
        sCDKey == "QYU9AP7Y" || //FrostWolf
        sCDKey == "FTR6CL9N" || //J. Persinne
        sCDKey == "FTRGTERU" || //J. Persinne
        sCDKey == "VD7NLUHD" || //Thonil
        sCDKey == "QVMAQX9D") //Dalsok
            return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetStaffMember
//:://////////////////////////////////////////////
/*
    Returns the name associated with oPC's staff
    member CD Key.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: June 30, 2009
//:://////////////////////////////////////////////
string GetStaffMember(object oPC)
{
    string sCDKey = GetPCPublicCDKey(oPC, TRUE);
    string sStaffMember = "";

    if(sCDKey == "QVM9JQFJ")
    {
        sStaffMember = "Aethra";
    }
    else if(sCDKey == "FT6GFQU4")
    {
        sStaffMember = "Aethra";
    }
    else if(sCDKey == "VD7N9P76")
    {
        sStaffMember = "Cryptic";
    }
    else if(sCDKey == "QYU9AP7Y")
    {
        sStaffMember = "FrostWolf";
    }
    else if(sCDKey == "FTR6CL9N")
    {
        sStaffMember = "Persinne";
    }
    else if(sCDKey == "FTRGTERU")
    {
        sStaffMember = "Persinne";
    }
    else if(sCDKey == "VD7NLUHD")
    {
        sStaffMember = "Thonil";
    }
    else if(sCDKey == "QVMAQX9D")
    {
        sStaffMember = "Dalsok";
    }

    return sStaffMember;
}

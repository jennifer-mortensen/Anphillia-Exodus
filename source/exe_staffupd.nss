#include "_inc_staff"

void main()
{
    //J. Persinne; if the PC is logging in on a non-staff computer, clear all staff channel information.
    if(!GetIsStaffMember(OBJECT_SELF))
    {
        DeleteLocalInt(OBJECT_SELF, "STAFF_CHANNEL_ENABLED");
        DeleteLocalInt(OBJECT_SELF, "DM_CHANNEL_ENABLED");
        DeleteLocalString(OBJECT_SELF, "STAFF_MEMBER");
    }
    else
    {
        string sStaffId = GetStaffMember(OBJECT_SELF);
        object oChannelMember;
        SetLocalString(OBJECT_SELF, "STAFF_MEMBER", sStaffId);

        if(GetLocalInt(OBJECT_SELF, "STAFF_CHANNEL_ENABLED") == TRUE)
        {
            SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You have joined the staff channel.");
            oChannelMember = GetFirstPC();
            while(oChannelMember != OBJECT_INVALID)
            {
                if(GetLocalInt(oChannelMember, "STAFF_CHANNEL_ENABLED") == TRUE && oChannelMember != OBJECT_SELF)
                {
                    SendMessageToPC(oChannelMember, "<cÍ]]>" + GetName(OBJECT_SELF) + " (" + sStaffId + ") has joined the staff channel.</c>");
                }
                oChannelMember = GetNextPC();
            }
        }
        if(GetLocalInt(OBJECT_SELF, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(OBJECT_SELF))
        {
            SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You have joined the DM channel.");
            oChannelMember = GetFirstPC();
            while(oChannelMember != OBJECT_INVALID)
            {
                if((GetLocalInt(oChannelMember, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oChannelMember)) && oChannelMember != OBJECT_SELF)
                {
                    SendMessageToPC(oChannelMember, "<c ¿þ>" + GetName(OBJECT_SELF) + " (" + sStaffId + ") has joined the DM channel.</c>");
                }
                oChannelMember = GetNextPC();
            }
        }
    }
}

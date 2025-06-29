#include "_inc_staff"

void main()
{
    if(!GetIsStaffMember(OBJECT_SELF))
        return;

    SetLocalInt(OBJECT_SELF, "STAFF_CHANNEL_ENABLED", TRUE);
}

// PLACEHOLDER
#include "ats_inc_leave"
#include "anph_persist_inc"
int preEvent()
{
    ATS_ClientClose(GetExitingObject());
    return 1;
}

void postEvent()
{
    return;
}

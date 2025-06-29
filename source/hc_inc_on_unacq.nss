// PLACEHOLDER

#include "ats_inc_unacq"

int preEvent()
{
    ATS_OnUnAcquireItem(GetModuleItemLost(), GetModuleItemLostBy(),
                            GetModuleItemAcquiredFrom());
    return 1;
}


void postEvent()
{
    return;
}

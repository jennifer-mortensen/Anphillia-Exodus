// PLACEHOLDER

#include "ats_inc_acquire"

int preEvent()
{
    ATS_OnAcquireItem(GetItemPossessor(GetModuleItemAcquired()),
                      GetModuleItemAcquired(), GetModuleItemAcquiredFrom());

    return 1;
}


void postEvent()
{
    return;
}

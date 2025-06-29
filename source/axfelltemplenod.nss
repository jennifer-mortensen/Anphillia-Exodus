#include "moth_inc_hb"
void main()
{
    object oTarget;
    oTarget = GetEnteringObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
        MothAxfellNodStart();
        }
    }
}


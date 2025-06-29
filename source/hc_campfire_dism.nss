#include "zep_inc_phenos2"
void main()
{
    object oPC=GetLastUsedBy();
    zep_Dismount(oPC);
    DelayCommand(3.0,SetLocalInt(oPC,"HasMountExp",FALSE));
}

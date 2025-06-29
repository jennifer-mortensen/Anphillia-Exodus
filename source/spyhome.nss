
#include "NW_I0_SPELLS"
void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;
    DelayCommand(25.2,DeleteLocalInt(oPC,"ismothspy"));
    DelayCommand(25.2,DeleteLocalInt(oPC,"spyonce"));
    RemoveSpecificEffect(781, oPC);
}




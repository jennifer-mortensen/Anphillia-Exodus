#include "moth_inc_random"
void main()
{
 object oPC = GetEnteringObject();
 int nDice = d100(2);
 if (!GetIsPC(oPC)) return;
 int DoOnceRandom = GetLocalInt(oPC, GetTag(OBJECT_SELF));
 if (DoOnceRandom==TRUE) return;
 SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
 MothRandomEvent(oPC,nDice);
}

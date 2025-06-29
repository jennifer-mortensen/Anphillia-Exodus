#include "moth_inc_effects"
void main()
{
object oPC = GetLastSpeaker();
SetSubRace(oPC, "");
//run the subrace effect to remove old effects
MothBonuses(oPC);
}

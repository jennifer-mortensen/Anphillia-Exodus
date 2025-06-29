void main()
{
object oPC = GetEnteringObject();
object oMod = GetModule();
if (GetIsInCombat(oPC)) return;
if (!GetIsPC(oPC)) return;
int nInt;
nInt=GetLocalInt(oMod, "mothlockdown");
if ((nInt = 1))
   {
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "Mothlockdown1A")));
   }
else
   {
   }
}

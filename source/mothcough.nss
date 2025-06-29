
void main()
{
object oPC = GetEnteringObject();
object oTarget = OBJECT_SELF;
string sPC = GetName(oPC);
int nDice = d4();
int nInt;
float GetRandomDelay;
float fMinimumTime = 1.4;
float fMaximumTime = 26.1;

if ((GetTag(oTarget) == "mothcough1"))
   {
   if (nDice>=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs slightly.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough2"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough3"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough4"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs some blood.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough5"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs repeatadly.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough6"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs voilently.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough7"))
   {
   if (nDice>=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough8"))
   {
   if (nDice>=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs.</c>", oPC));
   }
if ((GetTag(oTarget) == "mothcough9"))
   {
   if (nDice<=3) return;
   if (!GetIsPC(oPC)) return;
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   nInt = GetLocalInt(oPC, "Cough");
   nInt += 1;
   SetLocalInt(oPC, "Cough", nInt);
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   DelayCommand(GetRandomDelay,FloatingTextStringOnCreature("<cýõæ>"+sPC+" coughs.</c>", oPC));
   }
}

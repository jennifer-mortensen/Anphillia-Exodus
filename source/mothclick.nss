void main()
{
object oPC = GetEnteringObject();
object oTarget;
object oMod =GetModule();
oTarget = OBJECT_SELF;
if (!GetIsPC(oPC)) return;
int nInt;

nInt = GetLocalInt(oMod, "MothClick");
nInt += 1;
SetLocalInt(oMod, "MothClick", nInt);
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 1)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'O' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 2)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'O' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 3)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'P' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 4)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'H' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 5)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'S' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt == 6)
   {
   PlaySound("as_sw_stonplate1");
   FloatingTextStringOnCreature("<cýõæ>You step on a small plate on the ground. Before it desends down beneath the other floorbricks you notice that the letter 'B' was clearly marked on it</c>", oPC);
   DestroyObject(oTarget, 1.0);
   }
nInt=GetLocalInt(oMod, "MothClick");
if (nInt >= 7)
   {
   DestroyObject(oTarget, 1.0);
   }
}


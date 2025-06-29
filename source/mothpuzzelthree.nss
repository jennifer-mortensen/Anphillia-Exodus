void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
object oDoor = GetObjectByTag("ToBemfas");
object oCrystal = GetObjectByTag("mothriddle1");
object oWaypoint = GetWaypointByTag("mothholo");
int nInt;
int nExc;
//Once per Anphillian
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
//Unlocking procees
nInt = GetLocalInt(oMod, "Riddle1");
nInt += 1;
SetLocalInt(oMod, "Riddle1", nInt);
DelayCommand(2.5,DestroyObject(OBJECT_SELF));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(SPELL_CALL_LIGHTNING), GetLocation(OBJECT_SELF));
PlaySound("as_sw_stonplate1");
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE), GetLocation(OBJECT_SELF));
PlaySound("al_cv_windmill1");
PlaySound("as_sw_stonplate1");
if (nInt <= 6)
   {
   }
if (nInt >= 7)
   {
   nExc = GetLocalInt(oMod, "Riddle12");
   nExc += 1;
   SetLocalInt(oMod, "Riddle12", nExc);
   }
if (nExc == 1)
   {
   SetLocked(oDoor,FALSE);
   ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_KNOCK),oDoor);
   ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HEALING_X),oCrystal);
   SendMessageToPC(oPC,"You solved the riddle!");
   AssignCommand(oDoor,ActionOpenDoor(oDoor));
   ExecuteScript("mothholo", oMod);
   }
if (nExc >= 2)
   {
   }
}





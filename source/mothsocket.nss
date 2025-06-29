void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
object oTarget;
object oSpawn;
object oBeam;
object oRay;
object oChain;
object oNod;
object oGoal;
object oMod = GetModule();
location lTarget;

oBeam = GetObjectByTag("mothyellow1");
oRay = GetObjectByTag("mothyellow2");
oChain = GetObjectByTag("mothyellow3");
oNod = GetObjectByTag("mothyellow4");
oGoal = GetObjectByTag("mothyellow5");

int nInt;
nInt=GetLocalInt(oMod, "Mothsocket");

if (nInt >= 4)
   {
   int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
   oTarget = GetWaypointByTag("mothyellow6");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "mothmirror3", lTarget);
   {
   DelayCommand(0.1,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.6,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.1,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.1,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.6,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.1,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.1,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.6,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.1,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.1,AssignCommand(oNod, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(0.6,AssignCommand(oNod, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.1,AssignCommand(oNod, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION), GetLocation(oGoal)));
   DelayCommand(1.1,PlaySound("sdr_demonhand"));
   DelayCommand(4.0,DestroyObject(oChain, 0.0));
   DelayCommand(4.0,DestroyObject(oBeam, 0.0));
   DelayCommand(4.0,DestroyObject(oRay, 0.0));
   DelayCommand(4.0,DestroyObject(oNod, 0.0));
   DelayCommand(4.0,DestroyObject(oGoal, 0.0));
   DelayCommand(4.0,DestroyObject(OBJECT_SELF, 1.0));
   }
 }
}

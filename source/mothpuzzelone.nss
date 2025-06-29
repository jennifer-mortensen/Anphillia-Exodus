void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
object oCaster;
object oTarget;
object oObject;
object oItem;
object oTrap;
object oEvent;
object oGoal;
object oDoor;
object oSpark;
object oEdinge;
object oAzzie;
object oBeam;
object oRay;
object oChain;
float fDelay;
int nInt;
int nExc;


oCaster = OBJECT_SELF;
oTarget = GetObjectByTag("MothTarget2");
oObject = GetObjectByTag("MothTarget3");
oItem = GetObjectByTag("MothTarget4");
oTrap = GetObjectByTag("MothTarget5");
oEvent = GetObjectByTag("MothTarget6");
oGoal = GetObjectByTag("MothTarget7");
oDoor = GetObjectByTag("Phobosdoor");
oSpark = GetObjectByTag("Mothsparks");
oEdinge = GetObjectByTag("MothTarget8");
oAzzie = GetObjectByTag("MothTarget9");
oBeam = GetObjectByTag("MothTarget10");
oRay = GetObjectByTag("MothTarget11");
oChain = GetObjectByTag("MothTarget12");

//Once per Anphillian
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
//Unlocking procees
nInt = GetLocalInt(oMod, "Phobos");
nInt += 1;
SetLocalInt(oMod, "Phobos", nInt);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC));
PlaySound("as_sw_stonplate1");
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC));
PlaySound("al_cv_windmill1");
PlaySound("as_sw_stonplate1");
if (nInt <= 5)
   {
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), GetLocation(oTarget));
   DestroyObject(OBJECT_SELF);
   }
if (nInt >= 6)
   {
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), GetLocation(oTarget));
   nExc = GetLocalInt(oPC, "MothTarget1");
   nExc += 1;
   SetLocalInt(oPC, "MothTarget1", nExc);
   }
//Beam between objects starts.
nInt=GetLocalInt(oPC, "MothTarget");
if (nExc == 1)
   {
   DelayCommand(1.0,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.2,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.5,AssignCommand(oBeam, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.0,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.2,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.5,AssignCommand(oRay, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.0,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.2,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.5,AssignCommand(oChain, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(1.1,PlaySound("sdr_demonhand"));
   DelayCommand(1.1,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_AURA_ODD), GetLocation(oTarget), RoundsToSeconds(2)));
   DelayCommand(1.7,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLUR), GetLocation(oTarget), RoundsToSeconds(2)));
   DelayCommand(2.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE), GetLocation(oTarget), RoundsToSeconds(3)));
   DelayCommand(2.1,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget), RoundsToSeconds(2)));
   DelayCommand(4.0,AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oObject, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(4.5,AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oObject, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(6.0,AssignCommand(oObject, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oItem, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(6.5,AssignCommand(oObject, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oItem, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(8.0,AssignCommand(oItem, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oTrap, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(8.5,AssignCommand(oItem, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oTrap, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(10.0,AssignCommand(oTrap, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oEvent, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(10.5,AssignCommand(oTrap, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oEvent, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(12.0,AssignCommand(oEvent, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oTrap, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(12.5,AssignCommand(oEvent, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oTrap, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(14.0,AssignCommand(oEvent, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(14.0,AssignCommand(oEvent, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(14.0,AssignCommand(oTrap, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(14.0,AssignCommand(oTrap, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oGoal, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(14.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), GetLocation(oGoal)));
   DelayCommand(14.6,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), GetLocation(oGoal)));
   DelayCommand(14.7,PlaySound("sdr_demonhand"));
   DelayCommand(14.8,PlaySound("sdr_demonhand"));
   DelayCommand(14.9,PlaySound("sdr_demonhand"));
   DelayCommand(15.5,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.5,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.7,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.9,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(15.5,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.5,AssignCommand(oEdinge, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.7,AssignCommand(oEdinge, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.9,AssignCommand(oEdinge, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(15.5,AssignCommand(oGoal, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.5,AssignCommand(oAzzie, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.7,AssignCommand(oAzzie, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   DelayCommand(16.9,AssignCommand(oAzzie, ActionCastSpellAtObject(SPELL_SEARING_LIGHT, oDoor, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE)));
   {
   {
//Open the damn door already!
        DelayCommand(17.0,PlaySound("al_cv_windmill1"));
        DelayCommand(17.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(481), GetLocation(oDoor)));
        DelayCommand(17.2,ActionUnlockObject(oDoor));
        DelayCommand(17.3,ActionOpenDoor(oDoor));
        DelayCommand(17.4,SetLocked(oDoor, FALSE));
        DelayCommand(17.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oDoor)));
        DelayCommand(18.4,PlaySound("al_cv_fanlg1"));
        DelayCommand(18.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC)));
        DelayCommand(19.4,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), GetLocation(oDoor)));
        DelayCommand(19.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), GetLocation(oDoor)));
        DelayCommand(20.5,AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_CHEER)));
        DelayCommand(21.0,DestroyObject(oSpark, 1.0));
// Feedback loop - PUFF!
        DelayCommand(22.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oGoal)));
        DelayCommand(22.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oGoal)));
        DelayCommand(23.0,DestroyObject(oGoal, 0.0));
        DelayCommand(23.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oEvent)));
        DelayCommand(23.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oEvent)));
        DelayCommand(24.0,DestroyObject(oEvent, 0.0));
        DelayCommand(24.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oTrap)));
        DelayCommand(24.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oTrap)));
        DelayCommand(25.0,DestroyObject(oTrap, 0.0));
        DelayCommand(25.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oItem)));
        DelayCommand(25.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oItem)));
        DelayCommand(26.0,DestroyObject(oItem, 0.0));
        DelayCommand(26.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oObject)));
        DelayCommand(26.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oObject)));
        DelayCommand(27.0,DestroyObject(oObject, 0.0));
        DelayCommand(27.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oTarget)));
        DelayCommand(27.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), GetLocation(oTarget)));
        DelayCommand(28.0,DestroyObject(oTarget, 0.0));
        DelayCommand(24.0,DestroyObject(oEdinge, 0.0));
        DelayCommand(24.0,DestroyObject(oAzzie, 0.0));
        DelayCommand(28.0,DestroyObject(oChain, 0.0));
        DelayCommand(28.0,DestroyObject(oBeam, 0.0));
        DelayCommand(28.0,DestroyObject(oChain, 0.0));
        DelayCommand(28.0,DestroyObject(oCaster, 0.0));
        DelayCommand(28.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), GetLocation(oChain)));
// DONE!
   }
   }
   }
if (nExc >= 2)
   {
   }
}





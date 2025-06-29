int nInt;
location lTarget;
object oTarget;
void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
if (GetTag(OBJECT_SELF) == "mothstatue1")
   {
   oTarget = GetObjectByTag("mothstatue2");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));   }
else if (GetTag(OBJECT_SELF) == "mothstatue2")
   {
   oTarget = GetObjectByTag("mothstatue1");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue3")
   {
   oTarget = GetObjectByTag("mothstatue4");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue4")
   {
   oTarget = GetObjectByTag("mothstatue3");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue5")
   {
   oTarget = GetObjectByTag("mothstatue6");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue6")
   {
   oTarget = GetObjectByTag("mothstatue5");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue7")
   {
   oTarget = GetObjectByTag("mothstatue8");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue8")
   {
   oTarget = GetObjectByTag("mothstatue7");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue9")
   {
   oTarget = GetObjectByTag("mothstatue10");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue10")
   {
   oTarget = GetObjectByTag("mothstatue9");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue11")
   {
   oTarget = GetObjectByTag("mothstatue12");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue12")
   {
   oTarget = GetObjectByTag("mothstatuefinal");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue13")
   {
   oTarget = GetObjectByTag("mothstatue14");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_WARD),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatue14")
   {
   oTarget = GetObjectByTag("mothstatue1");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
else if (GetTag(OBJECT_SELF) == "mothstatuefinal")
   {
   oTarget = GetObjectByTag("mothstatue1");
   lTarget = GetLocation(oTarget);
   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),OBJECT_SELF);
   AssignCommand(oPC, ClearAllActions());
   DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
   oTarget = oPC;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetLocation(oTarget));
   }
}


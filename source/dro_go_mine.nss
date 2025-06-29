void SpawnMineral(object oSpawner, object oAttackthis, string sCreateTemplate)
{
   int nIteration = GetLocalInt(oSpawner, "mine");
   SetLocalInt(oSpawner, "mine", nIteration + 1);
   AssignCommand(oSpawner, ActionAttack(oAttackthis));
   CreateObject(OBJECT_TYPE_ITEM, sCreateTemplate, GetLocation(oSpawner));
   if (nIteration <= 4)
   {
      DelayCommand(5.0, SpawnMineral(oSpawner, oAttackthis, sCreateTemplate));
   }
}

void main()
{
   SetLocalInt(OBJECT_SELF, "mine", 1);
   string sTargetTag = GetStringRight(GetTag(OBJECT_SELF), 4);

   // Repair Tin, only 3 letters
   if (sTargetTag == "_Tin")
      sTargetTag = "Tin";

   object oMinableRock = GetNearestObjectByTag("cnrRock" + sTargetTag);
   string sCreateString = "cnrnugget" + GetStringLowerCase(sTargetTag);
   AssignCommand(OBJECT_SELF, ActionMoveToObject(oMinableRock, TRUE));
   DelayCommand(5.0, SpawnMineral(OBJECT_SELF, oMinableRock, sCreateString));
}

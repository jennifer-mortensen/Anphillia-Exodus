void main()
{
   object oPlayer = GetClickingObject();
   if (!GetLevelByClass(CLASS_TYPE_CLERIC, oPlayer) > 0)
   {
      SendMessageToPC(oPlayer, "Only a priestess may enter this holy place.");
   }
   else
   {
      object oTarget = GetObjectByTag("DrowBigTemple");
      AssignCommand (oPlayer, JumpToObject(oTarget));
   }
}

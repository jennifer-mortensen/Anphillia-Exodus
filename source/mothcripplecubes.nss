void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, 35))
   {
   ActionStartConversation(oPC, "mothcripplecube");
   }
}

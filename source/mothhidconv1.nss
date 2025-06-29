// Will reveal a hidden passage. Teleport triggered from conversation.
// Makes a Spot,Listen,Search check +d20.
// They must be above 18,28,28 to reveal the hidden passage.

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int nSearch = GetSkillRank(SKILL_SEARCH, oPC)+ d20();
int nListen = GetSkillRank(SKILL_LISTEN, oPC)+ d20();
int nSpot = GetSkillRank(SKILL_SPOT, oPC)+ d20();
if (nSearch <= 17)
   {
   return;
   }
if (nListen <= 27)
   {
   return;
   }
if (nSpot <= 27)
   {
   return;
   }
else
   {
   object oTarget;
   oTarget = OBJECT_SELF;
   string sObjectTag = GetTag(oTarget);
   AssignCommand(oTarget, ActionStartConversation(oPC, "moth" + sObjectTag));
   }
}


// Will reveal a hidden passage. Teleport triggered from conversation.
// Makes a Spot,Listen,Search check +d20.
// ALL of them must be above 18 to reveal the hidden passage.

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC) || GetStealthMode(oPC) == STEALTH_MODE_ACTIVATED) return;

int nSearch = GetSkillRank(SKILL_SEARCH, oPC)+ d20();
int nListen = GetSkillRank(SKILL_LISTEN, oPC)+ d20();
int nSpot = GetSkillRank(SKILL_SPOT, oPC)+ d20();
if (nSearch <= 17)
   {
   return;
   }
if (nListen <= 17)
   {
   return;
   }
if (nSpot <= 17)
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


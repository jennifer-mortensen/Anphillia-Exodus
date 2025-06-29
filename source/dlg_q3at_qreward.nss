#include "_inc_quest"

void main()
{
    //Issue the reward for this quest.
    object oPC = GetPCSpeaker();

    IssueQuestReward(oPC, "Q3");
}

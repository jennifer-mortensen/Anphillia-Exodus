#include "NW_I0_GENERIC"
void main()
{
    if(GetLocalInt(OBJECT_SELF, "TRANSITION_HALTED") == TRUE) //J. Persinne; kick out if this NPC is trying to reach the intruder through a transition it can not pass.
    {
        DeleteLocalInt(OBJECT_SELF, "TRANSITION_HALTED");
        return;
    }

    if(GetLocalInt(GetArea(OBJECT_SELF), "MY_PC_COUNT") == -1)
        return;

    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}





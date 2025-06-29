#include "NW_I0_GENERIC"
#include "NW_O2_CONINCLUDE"
#include "moth_inc"
void main()
{
    MothGiveNPCBuff();
    SetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL);
    SetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE);
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
    SetSpawnInCondition(NW_FLAG_DEATH_EVENT);
    SetListeningPatterns();
}

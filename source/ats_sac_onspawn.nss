#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "moth_inc"
void main()
{
    MothGiveNPCBuff();
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
    SetSpawnInCondition(NW_FLAG_DEATH_EVENT);
    SetListeningPatterns();
}



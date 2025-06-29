#include "X0_INC_HENAI"
void main()
{
    SetAssociateListenPatterns();
    bkSetListeningPatterns();
    SetAssociateState(NW_ASC_SCALED_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);
    SetAssociateStartLocation();
}



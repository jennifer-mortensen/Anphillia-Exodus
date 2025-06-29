#include "moth_inc_spells"
void main()
{
    object oDoor = GetBlockingDoor();

    if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 3)
    {
        DoDoorAction(oDoor, DOOR_ACTION_OPEN);
    }
    else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH) && GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH) >= 16)
    {
        if(!MothGetIsAssociate(OBJECT_SELF))
        {
        DoDoorAction(oDoor, DOOR_ACTION_BASH);
        }
    }
}

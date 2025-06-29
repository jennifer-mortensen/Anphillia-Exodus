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

    if(GetIsDead(OBJECT_SELF))
        return;

    //Randomly pulse a spell.
    int nRandom = d6();
    switch(nRandom)
    {
        case 1:
            ActionCastSpellAtLocation(75, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Gust of Wind
            break;
        case 2:
            ActionCastSpellAtLocation(596, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Electrical Aura of Menace
            break;
        case 3:
            if(GetLocalInt(OBJECT_SELF, "AVATAR_USED") == TRUE) //Avatar spam prevention; this guy would be a bit nuts without it.
                ActionCastSpellAtLocation(596, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Electrical Aura of Menace
            else
            {
                ActionCastSpellAtLocation(492, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Electrical Avatar
                SetLocalInt(OBJECT_SELF, "AVATAR_USED", TRUE);
                DelayCommand(9.0, DeleteLocalInt(OBJECT_SELF, "AVATAR_USED"));
            }
            break;
        case 4:
            ActionCastSpellAtLocation(11, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Call Lightning
            break;
        case 5:
            ActionCastSpellAtLocation(426, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); //Earthquake
            break;
        default:
            return;
    }
}





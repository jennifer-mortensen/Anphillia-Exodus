#include "_inc_assault"

void main()
{
    object oClicker = GetPlaceableLastClickedBy();
    if(GetLocalInt(OBJECT_SELF, "STILL_BEING_LAID") == TRUE) //Canceled ladder setting
    {
        string sID = GetAssaultObjectID(OBJECT_SELF);
        object oGround = GetStoneyGroundFromID(sID);
        object oLayer = GetLocalObject(oGround, "MY_LADDER_LAYER");
        if(oClicker == oLayer)
        {
            SetCommandable(TRUE, oClicker);
            SetLocalInt(oLayer, "CANCELED_LADDER_LAY", TRUE);
            AssignCommand(oClicker, ClearAllActions());
            AssignCommand(oClicker, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)); //Replay the animation for a duration of 0 seconds to clear it out.
            DeleteLocalObject(oGround, "MY_LADDER_LAYER");
            DestroyObject(OBJECT_SELF);
        }
    }
    else //Canceled ladder climbing
    {
        object oClimber = GetLocalObject(OBJECT_SELF, "MY_CLIMBER");
        if(oClicker == oClimber)
        {
            int nHeight = GetLocalInt(oClimber, "LADDER_HEIGHT");
            float fKnockdownDuration = 3.0 + (3.0 * IntToFloat(nHeight - 2));
            if(nHeight > 1)
                ApplyLadderFallDamage(oClimber,fKnockdownDuration, "You have jumped off of the ladder!");
            else
                SendAssaultMessage("You have climbed down from the ladder!", oClimber);
            SetCommandable(TRUE, oClicker);
            AssignCommand(oClicker, ClearAllActions());
            AssignCommand(oClicker, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID)); //Replay the animation for a duration of 0 seconds to clear it out.
            SetLocalInt(oClimber, "CANCELED_LADDER_CLIMB", TRUE);
            DeleteLocalInt(oClimber, "IS_CLIMBING");
            DeleteLocalInt(oClimber, "LADDER_HEIGHT");
            DeleteLocalFloat(oClimber, "TIME_SPENT_CLIMBING");
            DeleteLocalObject(OBJECT_SELF, "MY_CLIMBER");
        }
    }
}

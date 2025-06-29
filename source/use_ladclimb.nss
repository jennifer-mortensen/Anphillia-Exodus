#include "_inc_assault"

void UpdateLadderClimbStatus(object oPC)
{
    float fClimbTime = GetLadderClimbTime(oPC);
    float fSecondsSpentClimbing = GetLocalFloat(oPC, "TIME_SPENT_CLIMBING");

    //The player canceled their climb. Clear the climber from our memory and exit out.
    if(GetLocalInt(oPC, "CANCELED_LADDER_CLIMB") == TRUE)
    {
        DeleteLocalInt(oPC, "CANCELED_LADDER_CLIMB");
    }

    if(GetLocalInt(oPC, "IS_CLIMBING") == FALSE || GetLocalObject(OBJECT_SELF, "MY_CLIMBER") != oPC)
    {
        return;
    }

    //---VFX and Height Handling
    int nLastHeightStored = GetLocalInt(oPC, "LADDER_HEIGHT");
    int nCurrentHeight;
    float fCurrentHeightInPercent = fSecondsSpentClimbing / fClimbTime;
    float fVFXOffset;

    if(fCurrentHeightInPercent >= 1.0)
    {
        nCurrentHeight = 5;
    }
    else if(fCurrentHeightInPercent >= 0.80)
    {
        nCurrentHeight = 4;
    }
    else if(fCurrentHeightInPercent >= 0.60)
    {
        nCurrentHeight = 3;
    }
    else if(fCurrentHeightInPercent >= 0.40)
    {
        nCurrentHeight = 2;
    }
    else if(fCurrentHeightInPercent >= 0.20)
    {
        nCurrentHeight = 1;
    }

    while(nLastHeightStored < nCurrentHeight)
    {
        DelayCommand(fVFXOffset, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oPC));
        if(nLastHeightStored == 2 && nCurrentHeight != 5)
            SendAssaultMessage("You are now high up on the ladder. To get off in a timely manner, you'll have to jump!", oPC);
        nLastHeightStored++;
        fVFXOffset = fVFXOffset + 0.1;
    }
    //---End VFX and Height Handling

    //Store the now current height.
    SetLocalInt(oPC, "LADDER_HEIGHT", nCurrentHeight);

    //The climber has finished their climb. Port them to the ladder's top and then exit out.
    if(fSecondsSpentClimbing >= fClimbTime)
    {
        DeleteLocalInt(oPC, "LADDER_HEIGHT");
        DeleteLocalFloat(oPC, "TIME_SPENT_CLIMBING");
        DeleteLocalInt(oPC, "IS_CLIMBING");
        ActionClimbLadder(oPC, GetAssaultObjectID(OBJECT_SELF));
        return;
    }

    //Update our status in one second.
    fSecondsSpentClimbing = fSecondsSpentClimbing + 1.0;
    SetLocalFloat(oPC, "TIME_SPENT_CLIMBING", fSecondsSpentClimbing);
    DelayCommand(1.0, UpdateLadderClimbStatus(oPC));
}

void main()
{
    object oPC = GetLastUsedBy();

    if(GetLocalInt(OBJECT_SELF, "STILL_BEING_LAID") == TRUE)
    {
        SendAssaultMessage("You cannot climb a ladder while it is still being laid!", oPC);
        return;
    }
    if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "MY_CLIMBER")))
    {
        SendAssaultMessage("You cannot climb a ladder while it is in use!", oPC);
        return;
    }
    if(GetAppearanceType(oPC) > 6)
    {
        SendAssaultMessage("You cannot climb a ladder while polymorphed!", oPC);
        return;
    }

    float fClimbTime = GetLadderClimbTime(oPC);
    if(fClimbTime < 1.0) //Minimum of one second climb to avoid divide by zero error.
        fClimbTime = 1.0;

    SendAssaultMessage("You have begun to climb a ladder! (Click the ladder to stop climbing or jump off. Note that once you reach the top, you will be unable to return the way you came.)", oPC);

    //Animations
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fClimbTime));
    DelayCommand(0.1, SetCommandable(FALSE, oPC));

    SetLocalInt(oPC, "IS_CLIMBING", TRUE);

    SetLocalFloat(oPC, "TIME_SPENT_CLIMBING", 0.0);
    SetLocalObject(OBJECT_SELF, "MY_CLIMBER", oPC); //Remember who's climbing

    if(GetLocalInt(oPC, "CANCELED_LADDER_CLIMB") == FALSE) //If CANCELED_LADDER_CLIMB is TRUE, this means we already have a cyclical check running.
    {
        UpdateLadderClimbStatus(oPC); //Begin a cyclical check function to track ladder climbing status.
    }
}

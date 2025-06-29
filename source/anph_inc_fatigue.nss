/*
void CheckPlayerFatigue(object oPC)
{
    object oLastArea = GetLocalObject(oPC, "lastArea");

    //check position only when there is no area transition and player is not hasted. DMs dont fatigue
    if((oLastArea == GetArea(oPC))&&(!GetIsDM(oPC)))
    {
        int fatigue = GetLocalInt(oPC, "fatigue");
        location currentLoc = GetLocation(oPC);
        location oLastLoc = GetLocalLocation(oPC, "lastLoc");
        float distance = GetDistanceBetweenLocations(currentLoc, oLastLoc);
        SetLocalLocation(oPC, "lastLoc", currentLoc);

        //distance > 20 equates to run, player gets tired
        //doubled to take into account of the slowed heartbeat
        if(distance > 40.0 && distance < 70.0)
        {
            fatigue++;
            SetLocalInt(oPC, "fatigue", fatigue);
            //Debug:
            //AssignCommand(oPC, SpeakString("I am more tired. fat: "+IntToString(fatigue+1)+" dist: "+FloatToString(distance)));
        }
        //player slows down, recover one point of fatigue
        //doubled to take into account of the slowed heartbeat
        else if(distance < 20.0)
        {
            fatigue--;
            if(fatigue < 0)
                fatigue = 0;
            SetLocalInt(oPC, "fatigue", fatigue);
            //debug:
            //AssignCommand(oPC, SpeakString("I am less tired. fat: "+IntToString(fatigue)+" dist: "+FloatToString(distance)));
        }

        //now check if player feels the fatigue by comparing fatigue level with con modifier +3
        if(fatigue > (GetAbilityModifier(ABILITY_CONSTITUTION, oPC)+2))
        {
            FloatingTextStringOnCreature("You are exhausted from all the running", oPC, FALSE);
            //fatigue effects

            //following commented section is a forced rest. enable as require
            if(FortitudeSave(oPC, 16) == 0)
            {
                //SetCommandable(FALSE, oPC);
                //AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 15.0));
                //DelayCommand(5.0, SetCommandable(TRUE, oPC));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oPC, IntToFloat(d4(3)));
            }
            else
                //slow for 3 rounds
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oPC, IntToFloat(d4(1)));
        }

    }
    else
        //updates current area after transition.
        SetLocalObject(oPC, "lastArea", GetArea(oPC));
}

void ResetFatigue(object oPC)
{
    SetLocalInt(oPC, "fatigue", 0);
}

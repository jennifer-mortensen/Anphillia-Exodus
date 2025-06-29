//If set to TRUE, all subraces will be level capped.
const int ECL_LEVEL_CAP = TRUE;

//Return the oPC's ECL.
int GetECL(object oPC);
//Returns oPC's level based on their current experience, adjusted for ECL.
int GetECLAdjustedLevelFromXP(object oPC);
//Returns oPC's hit dice, adjusted for ECL.
int GetECLAdjustedHitDice(object oPC);
//Return's oPC's level based on their current experience.
int GetLevelFromXP(object oPC);
//Returns oPC's current virtual experience total.
int GetVirtualXP(object oPC);
//Returns the minimum amount of experience required to reach nLevel.
int GetXPRequiredForLevel(int nLevel);
//Gives nLevelsToResward to oPC.
void GiveLevel(object oPC, int nLevelsToReward = 1);
//Rewards the oPC with nReward in experience. If oPC is level capped and has an ECL, then virtual experience will be granted instead. If nAdjustForECL is set to true and the level cap is enabled,
//then a subraced character's experience gain will be adjusted downward to account for their smaller experience table. Use this function in place of all GiveXPToCreature() functions.
void GiveVirtualXPToCreature(object oPC, int nReward, int nAdjustForECL = TRUE);
//Sets oPC's virtual experience total to nXPTotal.
void SetVirtualXP(object oPC, int nXPTotal);

//Return the oPC's ECL.
int GetECL(object oPC)
{
    int nECL = GetLocalInt(oPC, "ECL");
    return nECL;
}

//Returns oPC's level based on their current experience, adjusted for ECL.
int GetECLAdjustedLevelFromXP(object oPC)
{
    int nECLAdjustedLevel = GetLevelFromXP(oPC) + GetECL(oPC);
    return nECLAdjustedLevel;
}

//Returns oPC's hit dice, adjusted for ECL.
int GetECLAdjustedHitDice(object oPC)
{
    int nECLAdjustedHitDice = GetHitDice(oPC) + GetECL(oPC);
    return nECLAdjustedHitDice;
}

//Return's oPC's level based on their current experience.
int GetLevelFromXP(object oPC)
{
    int nLevel = FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(GetXP(oPC)) / 500 )));
    int nMaxLevel = 40;
    if(ECL_LEVEL_CAP)
        nMaxLevel -= GetECL(oPC);
    if(nLevel > nMaxLevel)
        nLevel = nMaxLevel;
    return nLevel;
}

//Returns oPC's current virtual experience total.
int GetVirtualXP(object oPC)
{
    int nVirtualXP = GetLocalInt(oPC, "VIRTUAL_EXPERIENCE");
    return nVirtualXP;
}

//Returns the minimum amount of experience required to reach nLevel.
int GetXPRequiredForLevel(int nLevel)
{
    int nMinimumXP;
    if(nLevel < 1 || nLevel > 40)
    {
        return -1; //Return value on error.
    }
    while(nLevel > 1) //Loop and add the amount of experience required for each level.
    {
        nLevel--;
        nMinimumXP = nMinimumXP + nLevel * 1000;
    }
    return nMinimumXP;
}

//Gives nLevelsToResward to oPC.
void GiveLevel(object oPC, int nLevelsToReward = 1)
{
    int nCurrentLevel = GetLevelFromXP(oPC);
    int nMaximumLevel = 40;

    if(ECL_LEVEL_CAP == TRUE)
        nMaximumLevel -= GetECL(oPC);

    if(nCurrentLevel >= nMaximumLevel && nLevelsToReward > 0) //Terminate the script if the PC is level capped.
        return;
    if(nCurrentLevel + nLevelsToReward > nMaximumLevel) //If the number of levels we'd like to grant exceeds the number of levels the PC can gain, then set them at their level cap.
    {
        SetXP(oPC, GetXPRequiredForLevel(nMaximumLevel));
    }
    else
    {
        SetXP(oPC, GetXPRequiredForLevel(nCurrentLevel + nLevelsToReward));
    }
}

//Rewards the oPC with nReward in experience. If oPC is level capped and has an ECL, then virtual experience will be granted instead. If nAdjustForECL is set to true and the level cap is enabled,
//then a subraced character's experience gain will be adjusted downward to account for their smaller experience table. Use this function in place of all GiveXPToCreature() functions.
void GiveVirtualXPToCreature(object oPC, int nReward, int nAdjustForECL = TRUE)
{
    int nECL = GetECL(oPC);
    int nXP = GetXP(oPC);
    int nMaximumLevel = 40;
    int nMinimumLevel = 4;

    float fECLAdjust;

    if(ECL_LEVEL_CAP == TRUE)
    {
        nMaximumLevel -= nECL;
        nMinimumLevel -= nECL;
        if(nAdjustForECL == TRUE)
        {
            fECLAdjust = IntToFloat(GetXPRequiredForLevel(nMaximumLevel)) / 780000.0;
            nReward = FloatToInt(IntToFloat(nReward) * fECLAdjust);
        }
    }

    int nMaximumXP;
    int nMinimumXP;
    int nXPToMaximumXP;
    int nVirtualXP;
    int nVirtualXPReward;

    if(nReward == 0) //Exit if the reward is 0.
        return;

    if(nReward > 0) //Experience Gain
    {
        nMaximumXP = GetXPRequiredForLevel(nMaximumLevel);
        nXPToMaximumXP = nMaximumXP - nXP;
        if(nXPToMaximumXP > nReward || nMaximumLevel == 40) //If the character does not have enough experience to hit their ECL-adjusted XP cap, then just reward them normal experience.
        {
            SetXP(oPC, nXP + nReward);
        }
        else
        {
            SetXP(oPC, nMaximumXP);
            nVirtualXP = GetVirtualXP(oPC);
            nVirtualXPReward = nReward - nXPToMaximumXP;
            SetVirtualXP(oPC, nVirtualXP + nVirtualXPReward);
            SendMessageToPC(oPC, "Experience Points Gained:  " + IntToString(nVirtualXPReward));
        }
    }
    else //Experience Loss
    {
        nReward = abs(nReward);
        nVirtualXP = GetVirtualXP(oPC);

        if(nVirtualXP > 0) //Handle Virtual Experience Loss
        {
            if(nReward < nVirtualXP) //We have enough virtual XP to accomodate the full loss.
            {
                SetVirtualXP(oPC, nVirtualXP - nReward);
                SendMessageToPC(oPC, "Experience Points Lost: " + IntToString(nReward));
                return; //No more experience will be taken; exit out.
            }
            else  //We will lose more total experience than we have virtual XP; just display the amount of virtual experience lost (that is, all of it).
            {
                SetVirtualXP(oPC, 0);
                SendMessageToPC(oPC, "Experience Points Lost: " + IntToString(nVirtualXP));
                nReward -= nVirtualXP;
            }
        }
        //Now let's take the rest of the experience (we won't have gotten this far if there was no more to take).
        nMinimumXP = GetXPRequiredForLevel(nMinimumLevel);
        if((nXP - nReward) < nMinimumXP) //Don't let the PC drop below their minimum level.
            SetXP(oPC, GetXPRequiredForLevel(nMinimumLevel));
        else
            SetXP(oPC, nXP - nReward);
    }
}

//Sets oPC's virtual experience total to nXPTotal.
void SetVirtualXP(object oPC, int nXPTotal)
{
    SetLocalInt(oPC, "VIRTUAL_EXPERIENCE", nXPTotal);
    SetLocalInt(oPC, "VIRTUAL_EXPERIENCE_ALTERED", TRUE); //Log that we've altered virtual experience. We do this so that we only use slow data write functions when necessary.

}

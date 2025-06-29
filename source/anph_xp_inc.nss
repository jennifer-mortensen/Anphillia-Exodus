#include "_inc_xp"
int GetLevelExp (int nLev)
{
    int nNew;

    if(nLev >= 40) nNew=781000;
    else if(nLev == 39) nNew=742000;
    else if(nLev == 38) nNew=704000;
    else if(nLev == 37) nNew=667000;
    else if(nLev == 36) nNew=631000;
    else if(nLev == 35) nNew=596000;
    else if(nLev == 34) nNew=561000;
    else if(nLev == 33) nNew=528000;
    else if(nLev == 32) nNew=496000;
    else if(nLev == 31) nNew=465000;
    else if(nLev == 30) nNew=435000;
    else if(nLev == 29) nNew=406000;
    else if(nLev == 28) nNew=378000;
    else if(nLev == 27) nNew=351000;
    else if(nLev == 26) nNew=325000;
    else if(nLev == 25) nNew=300000;
    else if(nLev == 24) nNew=276000;
    else if(nLev == 23) nNew=253000;
    else if(nLev == 22) nNew=231000;
    else if(nLev == 21) nNew=210000;
    else if(nLev == 20) nNew=190000;
    else if(nLev == 19) nNew=171000;
    else if(nLev == 18) nNew=153000;
    else if(nLev == 17) nNew=136000;
    else if(nLev == 16) nNew=120000;
    else if(nLev == 15) nNew=105000;
    else if(nLev == 14) nNew=91000;
    else if(nLev == 13) nNew=78000;
    else if(nLev == 12) nNew=66000;
    else if(nLev == 11) nNew=55000;
    else if(nLev == 10) nNew=45000;
    else if(nLev == 9) nNew=36000;
    else if(nLev == 8) nNew=28000;
    else if(nLev == 7) nNew=21000;
    else if(nLev == 6) nNew=15000;
    else if(nLev == 5) nNew=10000;
    else if(nLev == 4) nNew=6000;
    else if(nLev == 3) nNew=3000;
    else if(nLev == 2) nNew=1000;
    else nNew=1;

    return (nNew);
}

int GetExperienceLevel (object oPC)
{
    int nNew;
    int nExp = GetXP(oPC);

    if(nExp > 781000) nNew = 40;
    else if(nExp > 742000) nNew = 39;
    else if(nExp > 704000) nNew = 38;
    else if(nExp > 667000) nNew = 37;
    else if(nExp > 631000) nNew = 36;
    else if(nExp > 596000) nNew = 35;
    else if(nExp > 561000) nNew = 34;
    else if(nExp > 528000) nNew = 33;
    else if(nExp > 496000) nNew = 32;
    else if(nExp > 465000) nNew = 31;
    else if(nExp > 435000) nNew = 30;
    else if(nExp > 406000) nNew = 29;
    else if(nExp > 378000) nNew = 28;
    else if(nExp > 351000) nNew = 27;
    else if(nExp > 325000) nNew = 26;
    else if(nExp > 300000) nNew = 25;
    else if(nExp > 276000) nNew = 24;
    else if(nExp > 253000) nNew = 23;
    else if(nExp > 231000) nNew = 22;
    else if(nExp > 210000) nNew = 21;
    else if(nExp > 190000) nNew = 20;
    else if(nExp > 171000) nNew = 19;
    else if(nExp > 153000) nNew = 18;
    else if(nExp > 136000) nNew = 17;
    else if(nExp > 120000) nNew = 16;
    else if(nExp > 105000) nNew = 15;
    else if(nExp > 91000) nNew = 14;
    else if(nExp > 78000) nNew = 13;
    else if(nExp > 66000) nNew = 12;
    else if(nExp > 55000) nNew = 11;
    else if(nExp > 45000) nNew = 10;
    else if(nExp > 36000) nNew = 9;
    else if(nExp > 28000) nNew = 8;
    else if(nExp > 21000) nNew = 7;
    else if(nExp > 15000) nNew = 6;
    else if(nExp > 10000) nNew = 5;
    else if(nExp > 6000) nNew = 4;
    else if(nExp > 3000) nNew = 3;
    else if(nExp > 1000) nNew = 2;
    else nNew=1;

    return (nNew);
}

void AnphGiveQuestReward (object oPC, int nPercentLvl)
{
    int nXP;
    int nNextXP;
    float fPercent;
    int nLevel;

    nLevel = GetLevelFromXP(oPC);
    if (nLevel == 40)
        nLevel = 39;

    nXP = GetLevelFromXP(oPC);
    nNextXP = GetXPRequiredForLevel(nLevel + 1);

    nXP = nNextXP - nXP;

    fPercent = IntToFloat (nPercentLvl) / 100.0;


    nXP = FloatToInt ((IntToFloat (nXP) * fPercent));

    GiveVirtualXPToCreature (oPC, nXP);
}

int AnphCalculateReward (object oPC, float fCR, int iHighestLevel)
{
    object oMod = GetModule();
    float fBaseExp = GetLocalFloat(oMod,"BASEXP");
    if (fBaseExp == 0.0)
        return (0);
    int XPPad = GetLocalInt (oMod, "XPPAD");
    int iHD = GetECLAdjustedLevelFromXP(oPC);
    float fXP;
    int nCurLvl = GetECLAdjustedLevelFromXP(oPC);
    float nDiff = IntToFloat (nCurLvl) - fCR;
    if (iHighestLevel > (nCurLvl + 3))
    {
        fXP = fCR - IntToFloat (iHighestLevel - nCurLvl);
    } else
    {
        fXP = fCR;
    }
    if (fXP < 0.0)
    {
        fXP = 0.0;
    }
    fXP += IntToFloat (XPPad);
    if (nDiff > 1.0)
    {
        fXP /= nDiff;
    }
    if (fCR < 0.9)
    {
        fXP = 1.0;
    }
    return (FloatToInt (fXP));
}
void AnphRewardXP (object oMonster, object oKiller)
{
    int BONUS_XP = 5;

    //MothDepopEnd(oMonster);
    float fDistance = 45.0;
    float fCR = GetChallengeRating(oMonster);
    int i;
    int iDone = 0;
    int iHighestLevel = 0;
    object oMaster;
    if (!GetIsPC (oKiller))
    {
        oMaster = GetMaster (oKiller);
        if (GetIsPC (oMaster))
        {
            oKiller = oMaster;
        } else {
            return;
        }
    }
    object oP = GetFirstPC ();
    for (i = 1; !iDone; i++)
    {
        object oPC = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR,
                                         PLAYER_CHAR_IS_PC, oMonster, i);
        if (!GetIsObjectValid (oPC))
        {
            iDone = 1;
        } else if (GetDistanceBetween (oPC, oMonster) > fDistance)
        {
            iDone = 1;
        } else
        {
            int iHD = GetECLAdjustedLevelFromXP(oPC);
            if (iHD > iHighestLevel)
            {
                iHighestLevel = iHD;
            }
        }
    }
    iDone = 0;
    for (i = 1; !iDone; i++)
    {
        object oPC = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR,
                                         PLAYER_CHAR_IS_PC, oMonster, i);
        if (!GetIsObjectValid (oPC))
        {
            iDone = 1;
        } else if (GetDistanceBetween (oPC, oMonster) > fDistance)
        {
            iDone = 1;
        } else
        {
            int nXP;
            //if(GetLocalInt(oMonster, "NO_EXPERIENCE") != TRUE)
                nXP = AnphCalculateReward (oPC, fCR, iHighestLevel);
            //else nXP = 0;

            if (nXP <= 1)
                GiveVirtualXPToCreature (oPC, 2, FALSE);
            if (nXP >= 2)
            {
                if(GetECLAdjustedLevelFromXP(oPC) <= 20)
                    BONUS_XP += 50;
                GiveVirtualXPToCreature(oPC, nXP * 21 / 2 + BONUS_XP);
            }
        }
    }
}
//void main() {}



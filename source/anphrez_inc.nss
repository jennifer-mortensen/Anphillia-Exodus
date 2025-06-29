//
#include "moth_inc"
#include "anph_inc"
#include "_inc_xp"
#include "_inc_death"
void DestroyDeathcorpse (object oPC)
{
    string sCDK=GetPCPublicCDKey (oPC);
    string sName=GetName(oPC);
    string sID=sName+sCDK;
    object oDeathCorpse;
    object oDeadMan;
    object oMod = GetModule();

    oDeathCorpse = GetLocalObject (oMod,"DeathCorpse"+sID);
    DestroyObject (oDeathCorpse);
    oDeadMan = GetLocalObject (oMod,"PlayerCorpse"+sID);
    DestroyObject (oDeadMan);
}

/*
//int GetLevelExp (int nLev)
{
    int nNew;

    if(nLev >= 20) nNew=190000;
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
*/

/*int CalculateXPLoss (object oPC, object oKiller, int PvPDeath = FALSE)
{
    int iLvl;
    int iXPLoss;
    int iCurrentXP;
    int iMax;
    iLvl = MothGetPlayerLevel(oPC);
    iCurrentXP = GetXP (oPC);

    if (iLvl <= 5)
    {
        iXPLoss = iLvl * 50;
    }
    else if (iLvl <= 10)
    {
        iXPLoss = iLvl * 75;
    }
    else if (iLvl <= 15)
    {
        iXPLoss = iLvl * 150;
    }
    else if (iLvl <= 20)
    {
        iXPLoss = iLvl * 175;
    }
    else if (iLvl <= 30)
    {
        iXPLoss = iLvl * 200;
    }
    else if (iLvl <= 35)
    {
        iXPLoss = iLvl * 200;
    }
    else if (iLvl <= 40)
    {
        iXPLoss = iLvl * 200 + 513;
    }
    else if (iLvl == 41)
    {
        iXPLoss = iLvl * 200 + 613;
    }
    else if (iLvl == 42)
    {
        iXPLoss = iLvl * 200 + 613;
    }

    if (PvPDeath)
    {
        iXPLoss = iXPLoss * 1/2;
    }


    return (iXPLoss);
}*/

/*void doXPLoss (object oPC, object oKiller, int nBurned=FALSE, object oBurner = OBJECT_INVALID, int nScalped = FALSE, int PvPDeath = FALSE, int nRespawn = FALSE)
{
    int iLvlStart;
    int iXPLoss;
    int iCurrentXP;
    int iNewXP;
    int iLvl;
    int iCurrentXPBurner;
    int iNewXPBurner;
    string sFactionPC;
    string sFactionBurner;
    //Burn/scalp override override
    nBurned=FALSE;
    nScalped = FALSE;
    iLvl = MothGetPlayerLevel (oPC);
    iCurrentXP = GetXP (oPC);

    // make xp-loss dependant on burning
    if (nBurned)
    {
       sFactionPC = AnphGetPlayerTeam(oPC);
       sFactionBurner = AnphGetPlayerTeam(oBurner);
       iCurrentXPBurner = GetXP(oBurner);
       if (sFactionPC == sFactionBurner)
       {
          iXPLoss = iLvl * iLvl * 8;
          iNewXPBurner = iCurrentXPBurner - iXPLoss;
          if (iNewXPBurner < 1)
          {
             iNewXPBurner = 1;
          }
          SendMessageToPC(oBurner, "*** You lost experience for burning a fellow " + sFactionPC + "***");
          SetXP (oBurner, iNewXPBurner);
       }
       else
       {
          SendMessageToPC(oPC, "You were burned by the enemy.");
          //iXPLoss = iLvl * iLvl * 8;
       }
    }
    else if (nScalped)
    {
       sFactionPC = AnphGetPlayerTeam(oPC);
       sFactionBurner = AnphGetPlayerTeam(oBurner);
       iCurrentXPBurner = GetXP(oBurner);
       if (sFactionPC == sFactionBurner)
       {
          iXPLoss = iLvl * iLvl * 3;
          iNewXPBurner = iCurrentXPBurner - iXPLoss;
          if (iNewXPBurner < 1)
          {
             iNewXPBurner = 1;
          }
          SendMessageToPC(oBurner, "*** You lost experience for scalping a fellow " + sFactionPC + "***");
          SetXP (oBurner, iNewXPBurner);
       }
       else
       {
          SendMessageToPC(oPC, "You were scalped by the enemy.");
          //iXPLoss = iLvl * iLvl * 3;
       }
    }
    else
    {
       iXPLoss = CalculateXPLoss (oPC, oKiller, PvPDeath);
    }

    iXPLoss = iXPLoss + Random (10 * iLvl);

    if(GetECLAdjustedLevelFromXP(oPC) < 21) //J. Persinne; discount experience loss for characters below level 21.
    {
        if(nRespawn = FALSE)
            iXPLoss = FloatToInt(IntToFloat(iXPLoss) * 0.75); //75% of experience loss on death
        else
        {
            if(GetECLAdjustedLevelFromXP(oPC) < 11)
                iXPLoss = FloatToInt(IntToFloat(iXPLoss) * 0.25); //25% of experience loss on respawn for levels 1-10
            else
                iXPLoss = FloatToInt(IntToFloat(iXPLoss) * 0.50); //50% of experience loss on respawn for levels 11-20
        }
    }

    GiveVirtualXPToCreature(oPC, -iXPLoss);

    //iNewXP = iCurrentXP - iXPLoss;

    //if (iNewXP < 1)
    //    iNewXP = 1;

   // SendMessageToAllDMs(SUBSCRIPTION_04, "*** Player " + GetName(oPC) + " lost " + IntToString(iXPLoss) + " this much exp ***");

    //SetXP (oPC, iNewXP);
} */


void AnphRez (object oPC, int nBurned=FALSE, object oBurner = OBJECT_INVALID, int nScalped = FALSE)
{
    //int iXP;

    //iXP = GetXP (oPC);

    string sStartTag = "none";

    // Special treatment for drow
    /*if (GetIsObjectValid (GetItemPossessedBy(oPC, GetLocalString(GetModule(), "FACTION_04_RING"))))
    {
        if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0)
        {
           sStartTag = "DrowPriestStartLocation";
        }
        else
        {
           sStartTag = "DrowStartLocation";
        }
    }*/
    // else just select the normal starting location
    //else
    //{
       sStartTag = GetLocalString(GetModule(), "FACTION_0" + IntToString(AnphGetPlayerTeamInt(oPC)) + "_STARTLOCATION");
    //}

    object oTarget = GetObjectByTag(sStartTag);

    ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectHeal(
                         GetMaxHitPoints(oPC)), oPC);

    //doXPLoss (oPC, oBurner, nBurned, oBurner, nScalped, FALSE, TRUE);
    DoXPLoss(oPC, FALSE, TRUE);

    DestroyDeathcorpse (oPC);

    SetLocalInt (oPC, "LOGINDEATH", 0);
    MothGetShifterLevels(oPC);
    AssignCommand (oPC, JumpToObject (oTarget));
}
//void main() {}


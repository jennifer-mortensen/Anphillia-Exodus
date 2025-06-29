//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
  {
    switch (nCR)
    {
    case 1:
      switch(d6(1))
      {
        case 1: sRetTemplate = "NW_SKELETON"; break;
        case 2: sRetTemplate = "NW_ZOMBIE01"; break;
        case 3: sRetTemplate = "NW_NIXIE"; break;
        case 4: sRetTemplate = "NW_ORCA"; break;
        case 5: sRetTemplate = "NW_ORCB"; break;
        case 6: sRetTemplate = "NW_BTLFIRE"; break;
      }
      break;
    case 2:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_KOBOLD004"; break;
        case 2: sRetTemplate = "NW_KOBOLD005"; break;
        case 3: sRetTemplate = "NW_KOBOLD003"; break;
        case 4: sRetTemplate = "NW_PIXIE"; break;
    }
      break;
    case 3:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_BTLBOMB"; break;
        case 2: sRetTemplate = "NW_BTLFIRE002"; break;
        case 3: sRetTemplate = "NW_BTLSTINK"; break;
        case 4: sRetTemplate = "NW_NYMPH"; break;
      }
      break;
    default:
       sRetTemplate = "";
       break;
    }
  }

  else if (sGroupType == "crypt")
  {
    switch (nCR)
    {
    case 1:
      switch(d4(1))
      {
        case 1:
        case 2: sRetTemplate = "NW_SKELETON"; break;
        case 3: sRetTemplate = "NW_ZOMBIE01"; break;
        case 4: sRetTemplate = "NW_ZOMBIE02"; break;
      }
      break;
    case 2:
      sRetTemplate = "NW_GHOUL";
      break;
    case 3:
      sRetTemplate = "NW_SHADOW";
      break;
    default:
       sRetTemplate = "";
       break;
    }  }

  else
  {
    // unknown group type
    sRetTemplate = "";
  }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
  {
    return 0.0;
  }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
  {
    return 1.;
  }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    if (GetStringLeft(sTemplate, 7) == "scaled_")
    {
      float fEncounterLevel;
      int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
      string sGroupType = GetStringRight(sTemplate,
          GetStringLength(sTemplate) - 7);

      // First Time in for this encounter?
      if (! nScaledInProgress)
      {

        // First time in - find the party level
        int nTotalPCs = 0;
        int nTotalPCLevel = 0;

        object oArea = GetArea(OBJECT_SELF);

        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
          if (GetIsPC(oPC) == TRUE)
          {
              nTotalPCs++;
              nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
          }
          oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
          fEncounterLevel = 0.0;
        }
        else
        {
          fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
        }

        // Save this for subsequent calls
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

        // We're done when the CRs chosen add up to the
        // desired encounter level
        SetLocalInt(oSpawn, "ScaledCallCount", 0);
        SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
      }


      fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
      int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

      // For simplicity, I'm not supporting creatures with CR < 1.0)
      if (fEncounterLevel < 1.0)
      {
        // We're done... No creatures have CR low enough to add to this encounter
        sRetTemplate = "";
      }

      else
      {
        // randomly choose a CR at or below the remaining (uncovered) encounter
        // level
        int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

        // cap to the largest CR we currently support in GetTemplateByCR
        if (nCR > 3)
        {
          nCR = 3;
        }

        sRetTemplate = GetTemplateByCR(nCR, sGroupType);


        // Convert CR to Encounter Level equivalent so it can be correctly
        // subtracted.  This does the real scaling work
        float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
        float fElRemaining = 1.0 - fELEquiv;

        fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
      }

      nScaledCallCount++;
      SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

      nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

      if (nScaledCallCount >= nSpawnNumber)
      {
        // reset...
        SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
      }
    }

    // cr_militia
    if (sTemplate == "cr_militia")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "cr_militia_m";
            break;
            case 2:
            sRetTemplate = "cr_militia_f";
            break;
        }
    }
    //

    // pg_guard
    if (sTemplate == "pg_guard")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "pg_guard_m";
            break;
            case 2:
            sRetTemplate = "pg_guard_f";
            break;
        }
    }
    //

    // Goblins
    if (sTemplate == "goblins_low")
    {
        if (d2(1) == 1)
        {
            sRetTemplate = "NW_GOBLINA";
        }
        else
        {
            sRetTemplate = "NW_GOBLINB";
        }
    }
    //

    // Goblins and Boss
    if (sTemplate == "gobsnboss")
    {
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Scaled Encounter
    if (sTemplate == "scaledgobs")
    {
        // Initialize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        // Cycle through PCs in Area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
            oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        // Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            // Spawn Something with CR 1
            case 1:
                sRetTemplate = "cr1creature";
            break;
            //

            // Spawn Something with CR 5
            case 5:
                sRetTemplate = "cr5creature";
            break;
            //
        }
    }
    //

    // Pirates and Boss
    if (sTemplate == "pirates")
    {
        // Delay the Spawn for 45 Minutes
        if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
            if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
                // Start the Delay
                SetLocalInt(oSpawn, "DelayStarted", TRUE);
                DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
            sRetTemplate = "";
            return sRetTemplate;
        }
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Advanced Scaled Encounter
    if (sTemplate == "advscaled")
    {
        //Initalize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        //Cycle through PCs in area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
        oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        //Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            //Spawn Something with CR 1
            case 1:
                switch (d6())
                {
                    case 1: sRetTemplate = "cr1example1";
                    case 2: sRetTemplate = "cr1example2";
                    case 3: sRetTemplate = "cr1example3";
                    case 4: sRetTemplate = "cr1example4";
                    case 5: sRetTemplate = "cr1example5";
                    case 6: sRetTemplate = "cr1example6";
                }
            break;
        }
    }
    //

    // Encounters
    if (sTemplate == "encounter")
    {
        // Declare Variables
        int nCounter, nCounterMax;
        string sCurrentTemplate;

        // Retreive and Increment Counter
        nCounter = GetLocalInt(oSpawn, "GroupCounter");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nCounter++;

        // Retreive CurrentTemplate
        sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

        // Check CounterMax
        if (nCounter > nCounterMax)
        {
            sCurrentTemplate = "";
            nCounter = 1;
        }

        if (sCurrentTemplate != "")
        {
            // Spawn Another CurrentTemplate
            sRetTemplate = sCurrentTemplate;
        }
        else
        {
            // Choose New CurrentTemplate and CounterMax
            switch (Random(2))
            {
                // Spawn 1-4 NW_DOGs
                case 0:
                sRetTemplate = "NW_DOG";
                nCounterMax = Random(4) + 1;
                break;
            }
            // Record New CurrentTemplate and CounterMax
            SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

        // Record Counter
        SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
    //

    //
    if (sTemplate == "kobolds")
    {
        int nKobold = Random(6) + 1;
        sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }
    //
    //Sily's Groups
    if (sTemplate == "sily_goblin_scout")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "an_goblin";
            break;
            case 2:
            sRetTemplate = "an_goblin2";
            break;
        }
    }


    //-----Anphillia Groups-----
    if(sTemplate == "lowbie_beetles")
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "nw_btlfire";
                break;
            case 2:
                sRetTemplate = "nw_btlfire";
                break;
            case 3:
                sRetTemplate = "nw_btlfire02";
                break;
        }
    }

    else if(sTemplate == "lowbie_beetlesb")
    {
        switch(d2(1))
        {
            case 1:
                sRetTemplate = "nw_btlfire";
                break;
            case 2:
                sRetTemplate = "nw_btlfire";
                break;
        }
    }

    else if(sTemplate == "lowbie_goblins")
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "gob_archer";
                break;
            case 2:
                sRetTemplate = "gob_fighter";
                break;
            case 3:
                sRetTemplate = "gobchiefa003";
                break;
            case 4:
                sRetTemplate = "gobwiza002";
                break;
        }
    }

    else if(sTemplate == "ats_cats")
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "ats_sac_cougar1_";
                break;
            case 2:
                sRetTemplate = "ats_sah_panther_";
                break;
            case 3:
                sRetTemplate = "ats_sac_cat0003_";
                break;
        }
    }

    else if(sTemplate == "ats_bears")
    {
        switch(d2(1))
        {
            case 1:
                sRetTemplate = "ats_sao_bear004_";
                break;
            case 2:
                sRetTemplate = "ats_sao_bear001_";
                break;
            case 3:
        }
    }

    else if(sTemplate == "ats_deer")
    {
        switch(d2(1))
        {
            case 1:
                sRetTemplate = "ats_sah_deer001_";
                break;
            case 2:
                sRetTemplate = "ats_sah_deer002_";
                break;
        }
    }

    else if(sTemplate == "lowbie_mushies") //CR 17
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "bugbearboss006";
                break;
            case 2:
                sRetTemplate = "bugbearboss005";
                break;
            case 3:
                sRetTemplate = "bugbearboss0132";
                break;
            case 4:
                sRetTemplate = "bugbearboss013";
                break;
            case 5:
                sRetTemplate = "bugbearboss004";
                break;
            case 6:
        }
    }


    else if(sTemplate == "midlevel_abishai") //CR 25
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "abishaimauler001";
                break;
            case 2:
                sRetTemplate = "abishaimauler";
                break;
            case 3:
                sRetTemplate = "abishaimauler004";
                break;
            case 4:
                sRetTemplate = "abishaimauler002";
                break;
            case 5:
                sRetTemplate = "abishaimauler003";
                break;
            case 6:
         }
     }


    else if(sTemplate == "lowbie_outlaws") //CR 13
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "minwiz002";
                break;
            case 2:
                sRetTemplate = "minotaur003";
                break;
            case 3:
                sRetTemplate = "minotaur003";
                break;

         }
     }


    else if(sTemplate == "lowbie_spiders") //CR 17
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "spidblood001";
                break;
            case 2:
                sRetTemplate = "spiddire003";
                break;
            case 3:
                sRetTemplate = "piddire001";
                break;
            case 4:
                sRetTemplate = "spiderlin001";
                break;
            case 5:
                sRetTemplate = "spiddire002";
                break;
            case 6:
                sRetTemplate = "spidredba001";
                break;

         }
     }


    else if(sTemplate == "spiderlair_minions") //CR 17
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "spiddire002";
                break;
            case 2:
                sRetTemplate = "spiddire003";
                break;
            case 3:
                sRetTemplate = "piddire001";
                break;

         }
     }


    else if(sTemplate == "lowbie_worg_riders") //CR 12
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "gnoll011";
                break;
            case 2:
                sRetTemplate = "gnoll004";
                break;
            case 3:
                sRetTemplate = "gnoll003";
                break;

         }
     }


    else if(sTemplate == "lowbie_ants") //CR 15
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "bugbearboss009";
                break;
            case 2:
                sRetTemplate = "bugbearboss008";
                break;
            case 3:
                sRetTemplate = "bugbearboss007";
                break;

         }
     }



    else if(sTemplate == "lowbie_kobolds") //CR 8
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "kobold002";
                break;
            case 2:
                sRetTemplate = "kobold003";
                break;
            case 3:
                sRetTemplate = "kobold005";
                break;
            case 4:
                sRetTemplate = "kobold007";
                break;
            case 5:
                sRetTemplate = "kobold006";
                break;
            case 6:
                sRetTemplate = "kobold004";
                break;

         }
     }



    else if(sTemplate == "lowbie_jyn") //CR 8
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "gob_fighter001";
                break;
            case 2:
                sRetTemplate = "gobchiefb001";
                break;
            case 3:
                sRetTemplate = "gobwiza001";
                break;

         }
     }



    else if(sTemplate == "lowbie_bandits") //CR 11
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "bandit004";
                break;
            case 2:
                sRetTemplate = "banditarcher";
                break;
            case 3:
                sRetTemplate = "bandit005";
                break;
            case 4:
                sRetTemplate = "starvingbear001";
                break;

         }
     }



    else if(sTemplate == "lowbie_mercs") //CR 11
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "dwarfmerc004";
                break;
            case 2:
                sRetTemplate = "elfmerc003";
                break;
            case 3:
                sRetTemplate = "halfmerc003";
                break;
            case 4:
                sRetTemplate = "humanmerc003";
                break;

         }
     }



    else if(sTemplate == "lowbie_bats") //CR 12
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "fruitbat";
                break;
            case 2:
                sRetTemplate = "ancientbat";
                break;
            case 3:
                sRetTemplate = "vampirebat";
                break;
            case 4:
                sRetTemplate = "ats_sao_bat0001_";
                break;
         }
     }



    else if(sTemplate == "lowbie_bears") //CR 12
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "ats_sao_bear004_";
                break;
            case 2:
                sRetTemplate = "ats_sao_bear001_";
                break;
            case 3:
                sRetTemplate = "bearkodiak002";
                break;
            case 4:
                sRetTemplate = "ats_sao_bear002_";
                break;
         }
     }


    else if(sTemplate == "ats_winterskins") //CR 16
    {
        switch(d2(1))
        {
            case 1:
                sRetTemplate = "ats_sao_bear003_";
                break;
            case 2:
                sRetTemplate = "ats_sac_dog0003_";
                break;

         }
     }



    else if(sTemplate == "lowbie_ogres") //CR 17
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "valleyogre";
                break;
            case 2:
                sRetTemplate = "ogrechief002";
                break;
            case 3:
                sRetTemplate = "ogremage002";
                break;


         }
     }



    else if(sTemplate == "lowbie_undead") //CR 11
    {
        switch(d8(1))
        {
            case 1:
                sRetTemplate = "skeleton";
                break;
            case 2:
                sRetTemplate = "ghoul001";
                break;
            case 3:
                sRetTemplate = "wight";
                break;
            case 4:
                sRetTemplate = "wraith";
                break;
            case 5:
                sRetTemplate = "ghast001";
                break;
            case 6:
                sRetTemplate = "zombie";
                break;
            case 7:
                sRetTemplate = "mummy001";
                break;
            case 8:
                sRetTemplate = "shadow";
                break;

         }
     }



    else if(sTemplate == "middle_undead") //CR 16
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "vampire001";
                break;
            case 2:
                sRetTemplate = "mumfight001";
                break;
            case 3:
                sRetTemplate = "mummyboss002";
                break;
            case 4:
                sRetTemplate = "ghoulboss002";
                break;
            case 5:
                sRetTemplate = "ghoullord001";
                break;
            case 6:
                sRetTemplate = "vampire003";
                break;

         }
     }



    else if(sTemplate == "highbie_undead") //CR 22
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "vampire007";
                break;
            case 2:
                sRetTemplate = "grudgezombie";
                break;
            case 3:
                sRetTemplate = "skeletonarcher";
                break;
            case 4:
                sRetTemplate = "vampire009";
                break;

         }
     }



    else if(sTemplate == "lowbie_animals") //CR 8
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "ats_sao_badger1_";
                break;
            case 2:
                sRetTemplate = "raptor002";
                break;
            case 3:
                sRetTemplate = "zep_worg001";
                break;
            case 4:
                sRetTemplate = "youngforesttiger";
                break;
         }
     }



    else if(sTemplate == "lowbie_bugbears") //CR 13
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "bugbeara001";
                break;
            case 2:
                sRetTemplate = "bugchiefb001";
                break;
            case 3:
                sRetTemplate = "bugwiza001";
                break;
            case 4:
                sRetTemplate = "bugbearboss001";
                break;
         }
     }



    else if(sTemplate == "lowbie_snow_orcs") //CR 16
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "gnoll017";
                break;
            case 2:
                sRetTemplate = "gnoll016";
                break;
            case 3:
                sRetTemplate = "gnoll015";
                break;
         }
     }



    else if(sTemplate == "lowbie_outposters") //CR 15
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "outpostdueller";
                break;
            case 2:
                sRetTemplate = "outpostduelle001";
                break;
            case 3:
                sRetTemplate = "outpostduelle002";
                break;
            case 4:
                sRetTemplate = "sleeker";
                break;

         }
     }



    else if(sTemplate == "lowbie_hags") //CR 11
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "bandit007";
                break;
            case 2:
                sRetTemplate = "bandit008";
                break;
            case 3:
                sRetTemplate = "banditarcher001";
                break;
         }
     }



    else if(sTemplate == "middle_grey_orcs") //CR 17
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "orca001";
                break;
            case 2:
                sRetTemplate = "orcbashers";
                break;
            case 3:
                sRetTemplate = "orcb001";
                break;
            case 4:
                sRetTemplate = "orcprotector";
                break;
         }
     }

//spawn_cfg_group.nss
    else if(sTemplate == "rauts_melee") //cr 40
    {
        switch(d2(1))
        {
            case 1:
                sRetTemplate = "gaughwarrior";
                break;
            case 2:
                sRetTemplate = "rautminer";
                break;
         }
     }

    else if(sTemplate == "rauts_ranged") //cr40
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "gaughwarrior001";
                break;
            case 2:
                sRetTemplate = "rautguard";
                break;
            case 3:
                sRetTemplate = "rautguard";
                break;
         }
     }


    else if(sTemplate == "highbie_aboms") //cr30
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "earthhuge001";
                break;
            case 2:
                sRetTemplate = "largeabomination";
                break;
            case 3:
                sRetTemplate = "smallabomination";
                break;
            case 4:
                sRetTemplate = "mediumabominatio";
                break;
         }
     }

    else if(sTemplate == "middle_ogres") //cr 27ish
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "sandogre";
                break;
            case 2:
                sRetTemplate = "sandogre";
                break;
            case 3:
                sRetTemplate = "sandogre";
                break;
            case 4:
                sRetTemplate = "sandogrescrapper";
                break;
            case 5:
                sRetTemplate = "sandogrescrapper";
                break;
            case 6:
                sRetTemplate = "sandogremage";
                break;
         }
     }

    else if(sTemplate == "savage_covenant")
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "hobgoblinsavage";
                break;
            case 2:
                sRetTemplate = "hobgoblinsavage";
                break;
            case 3:
                sRetTemplate = "hobgoblinsavage";
                break;
            case 4:
                sRetTemplate = "hobgoblin003";
                break;
            case 5:
                sRetTemplate = "cov_libertine";
                break;
            case 6:
                sRetTemplate = "cov_expert";
                break;

         }
     }



    else if(sTemplate == "highbie_asabi")
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "expanse_asabi";
                break;
            case 2:
                sRetTemplate = "expanse_asabi";
                break;
            case 3:
                sRetTemplate = "expanse_asabi_2";
                break;
            case 4:
                sRetTemplate = "expanse_asabi_2";
                break;
            case 5:
                sRetTemplate = "expanse_stingtail";
                break;
            case 6:
                sRetTemplate = "expanse_shifter";
                break;

         }
     }

    else if(sTemplate == "highbie_expanse") //J. Persinne; duplicate created to cover asabi in the expanse.
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "expanse_asabi";
                break;
            case 2:
                sRetTemplate = "expanse_asabi";
                break;
            case 3:
                sRetTemplate = "expanse_asabi_2";
                break;
            case 4:
                sRetTemplate = "expanse_asabi_2";
                break;
            case 5:
                sRetTemplate = "expanse_stingtail";
                break;
            case 6:
                sRetTemplate = "expanse_shifter";
                break;

         }
     }


    else if(sTemplate == "dragons_blue")
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "juvenillestor006";
                break;
            case 2:
                sRetTemplate = "juvenillestor006";
                break;
            case 3:
                sRetTemplate = "juvenillestor008";
                break;
            case 4:
                sRetTemplate = "juvenillestor009";
                break;
            case 5:
                sRetTemplate = "juvenillestormdr";
                break;
            case 6:
                sRetTemplate = "juvenillestormdr";
                break;

         }
     }

    else if(sTemplate == "bluedragons") //J. Persinne; duplicate template created for the broken cliffs dragons until I confirm with Ae what he had planned for there.
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "juvenillestor006";
                break;
            case 2:
                sRetTemplate = "juvenillestor006";
                break;
            case 3:
                sRetTemplate = "juvenillestor008";
                break;
            case 4:
                sRetTemplate = "juvenillestor009";
                break;
            case 5:
                sRetTemplate = "juvenillestormdr";
                break;
            case 6:
                sRetTemplate = "juvenillestormdr";
                break;

         }
     }

    else if(sTemplate == "cliffs_wyverns")
    {
        switch(d6(1))
        {
            case 1:
                sRetTemplate = "wyvern1";
                break;
            case 2:
                sRetTemplate = "wyvern2";
                break;
            case 3:
                sRetTemplate = "wyvern3";
                break;
            case 4:
                sRetTemplate = "wyvern4";
                break;
            case 5:
                sRetTemplate = "wyvern5";
                break;
            case 6:
                sRetTemplate = "wyvern5";
                break;

         }
     }

    else if(sTemplate == "hive_bugs") //CR 36
    {
        switch(d4(1))
        {
            case 1:
                sRetTemplate = "hive_beetle_1";
                break;
            case 2:
                sRetTemplate = "hive_beetle_2";
                break;
            case 3:
                sRetTemplate = "hive_beetle_3";
                break;
            case 4:
                sRetTemplate = "hive_beetle_4";
                break;
         }
     }



    else if(sTemplate == "hive_mother") //CR 80; minibosses, 65% chance to spawn.
    {
        switch(d3(1))
        {
            case 1:
                sRetTemplate = "hive_beetle_mot1";
                break;
            case 2:
                sRetTemplate = "hive_beetle_mot2";
                break;
            case 3:
                sRetTemplate = "hive_beetle_mot3";
                break;
         }
     }


// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}

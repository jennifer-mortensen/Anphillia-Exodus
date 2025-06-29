#include "inc_thchaos"

void main()
{
   int DD_LEVEL = GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER);

// Modify Variables:

   //% Chance added for DD to fire chaos shield. Default 1% / 2 DD Levels
   int DD_PER = DD_LEVEL / 2;

   //% Chance added for Chaos Shield Level to fire. Default 1% Per 1 level of chaos shield.
   int CHAOS_PER = GetCasterLevel(OBJECT_SELF);

   //Duration in rounds in which the following effects last. Default 1 round per 10 DD levels.
   int DURATION = DD_LEVEL / 10;

   if (DD_LEVEL == 30)
   {
   DURATION = 4;
   }

        // Attack increase bonus
        int ATTACK_INCREASE = DD_LEVEL / 10;

        if (DD_LEVEL == 30)
        {
        ATTACK_INCREASE = 4;
        }
        // Regen granted per 2.0 seconds
        int REGEN_INCREASE = DD_LEVEL / 10;

        if (DD_LEVEL == 30)
        {
        REGEN_INCREASE = 4;
        }
        // Damage base for a damage shield effect. (Calc = DAMAGE_BASE + 1d6 Bludgeoning)
        int DAMAGE_BASE = DD_LEVEL / 2;

        if (DD_LEVEL == 30)
        {
        DAMAGE_BASE = 20;
        }
        // Miss chance for an attacker
        int MISS_CHANCE = DD_LEVEL;

    //Duration in seconds for the immobilise effect. (Set to 1 second / 3 DD levels by default)
    float DURATION1 = IntToFloat(DD_LEVEL/3);

   //% Chance for an effect to fire.
   int PROC_CHANCE = DD_PER + CHAOS_PER;

// End Modify Variables.

   object oItem = GetSpellCastItem();
   object oSpellTarget = GetSpellTargetObject();
   object oSpellOrigin = OBJECT_SELF;

   int nChance = PROC_CHANCE;
   if (Random(100)+1 > nChance)
   {
      return;
   }

   if (GetHasSpellEffect(GetSpellId(),oSpellTarget))
   {
        return;
   }

   if (GetIsObjectValid(oItem))
   {
        FloatingTextStrRefOnCreature(100925, oSpellOrigin);
        FloatingTextStrRefOnCreature(100925, oSpellTarget);


        int nRandom = Random(5);

            if(nRandom == 0)
            {
            thChaos1(ATTACK_INCREASE, DURATION);
            }

            else if(nRandom == 1)
            {
            thChaos2(REGEN_INCREASE, DURATION);
            }

            else if(nRandom == 2)
            {
            thChaos3(DAMAGE_BASE, DURATION);
            }

            else if(nRandom == 3)
            {
            thChaos4(DURATION1);
            }

            else if(nRandom == 4)
            {
            thChaos5(MISS_CHANCE, DURATION);
            }


    }
}

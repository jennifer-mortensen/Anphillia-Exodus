#include "NW_I0_SPELLS"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    //Declare major variables
    int nAge = GetHitDice(OBJECT_SELF);
    int nDamage, nDamStrike;; // for level drain
    int nDamage2, nDamStrike2; // for negative energy
    int nDC;
    float fDelay;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    //Determine save DC and ability damage
    if (nAge <= 6) //Wyrmling
    {
        nDamage = 1;
        nDamage2 = 2;
        nDC = 18;
    }
    else if (nAge >= 7 && nAge <= 9) //Very Young
    {
        nDamage = 1;
        nDamage2 = 4;
        nDC = 20;
    }
    else if (nAge >= 10 && nAge <= 12) //Young
    {
        nDamage = 1;
        nDamage2 = 6;
        nDC = 22;
    }
    else if (nAge >= 13 && nAge <= 15) //Juvenile
    {
        nDamage = 2;
        nDamage2 = 8;
        nDC = 24;
    }
    else if (nAge >= 16 && nAge <= 18) //Young Adult
    {
        nDamage = 2;
        nDamage2 = 10;
        nDC = 26;
    }
    else if (nAge >= 19 && nAge <= 21) //Adult
    {
        nDamage = 3;
        nDamage2 = 12;
        nDC = 30;
    }
    else if (nAge >= 22 && nAge <= 24) //Mature Adult
    {
        nDamage = 4;
        nDamage2 = 14;
        nDC = 34;
    }
    else if (nAge >= 25 && nAge <= 27) //Old
    {
        nDamage = 5;
        nDamage2 = 16;
        nDC = 35;
    }
    else if (nAge >= 28 && nAge <= 30) //Very Old
    {
        nDamage = 5;
        nDamage2 = 18;
        nDC = 37;
    }
    else if (nAge >= 31 && nAge <= 33) //Ancient
    {
        nDamage = 6;
        nDamage2 = 20;
        nDC = 38;
    }
    else if (nAge >= 34 && nAge < 37) //Wyrm
    {
        nDamage = 7;
        nDamage2 = 22;
        nDC = 41;
    }
    else if (nAge >= 37) //Great Wyrm
    {
        nDamage = 8;
        nDamage2 = 24;
        nDC = 43;
    }
    PlayDragonBattleCry();
    nDamage2 = d8(nDamage2);
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DRAGON_BREATH_NEGATIVE));

            //nDamStrike = MothGetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,OBJECT_SELF);
            nDamStrike2 = MothGetReflexAdjustedDamage(nDamage2,oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,OBJECT_SELF);

            if (nDamStrike2 > 0)
            {
                //Set Damage and VFX
                //effect eBreath = EffectNegativeLevel(nDamStrike);
                effect eBreath2 = EffectDamage(nDamStrike2, DAMAGE_TYPE_NEGATIVE);
                //eBreath = SupernaturalEffect(eBreath);
                //eBreath2 = SupernaturalEffect(eBreath2);
                //Determine effect delay
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBreath, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBreath2, oTarget));
             }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE);
    }
}



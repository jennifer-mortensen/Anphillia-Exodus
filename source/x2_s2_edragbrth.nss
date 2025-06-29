#include "NW_I0_SPELLS"
#include "X0_i0_spells"
#include "x2_inc_shifter"
void main()
{
    int nAge;
    int bPoison = FALSE;
    nAge = GetHitDice(OBJECT_SELF);
    int nDice;
    int nDamage;
    int nDamageDice;
    int nDC;
    if (nAge <= 6) //Wyrmling
    {
        nDice = 1;
    }
    else if (nAge >= 7 && nAge <= 9) //Very Young
    {
        nDice = 2;
    }
    else if (nAge >= 10 && nAge <= 12) //Young
    {
        nDice = 4;
    }
    else if (nAge >= 13 && nAge <= 15) //Juvenile
    {
        nDice = 6;
    }
    else if (nAge >= 16 && nAge <= 18) //Young Adult
    {
        nDice = 8;
    }
    else if (nAge >= 19 && nAge <= 21) //Adult
    {
        nDice = 10;
    }
    else if (nAge >= 22 && nAge <= 24) //Mature Adult
    {
        nDice = 12;
    }
    else if (nAge >= 25 && nAge <= 27) //Old
    {
        nDice = 14;
    }
    else if (nAge >= 28 && nAge <= 30) //Very Old
    {
        nDice = 16;
    }
    else if (nAge >= 31 && nAge <= 33) //Ancient
    {
        nDice = 18;
    }
    else if (nAge >= 34 && nAge <= 37) //Wyrm
    {
        nDice = 20;
    }
    else if (nAge > 37 && nAge <40) //Great Wyrm
    {
        nDice = 22;
    }
    else
    {
        nDice = 24;
    }
    nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD,TRUE)+12;
    int nSpellId= GetSpellId();
    int nVis;
    int nType;
    int nSave;
    if (nSpellId == 796) // lightning
    {
        nVis = VFX_IMP_LIGHTNING_S;
        nType = DAMAGE_TYPE_ELECTRICAL;
        nSave = SAVING_THROW_TYPE_ELECTRICITY;
        nDamage = d12(nDice);
    }
    else if (nSpellId == 797) // cold
    {
        nVis = VFX_IMP_FROST_S;
        nType = DAMAGE_TYPE_COLD;
        nSave = SAVING_THROW_TYPE_COLD;
        nDamage = d12(nDice);
    }
    else //gas
    {
        nVis = VFX_IMP_POISON_L;
        nType = DAMAGE_TYPE_ACID;
        bPoison = TRUE;
        nDamage = d10(nDice);
    }
    effect eVis  = EffectVisualEffect(nVis);
    effect eDamage;
    effect ePoison;
    object oTarget;
    float fDelay;
    location lFinalTarget = GetSpellTargetLocation();
    vector vFinalPosition;
    if ( lFinalTarget == GetLocation(OBJECT_SELF) )
    {
        vector lTargetPosition = GetPositionFromLocation(lFinalTarget);
        vFinalPosition.x = lTargetPosition.x +  cos(GetFacing(OBJECT_SELF));
        vFinalPosition.y = lTargetPosition.y +  sin(GetFacing(OBJECT_SELF));
        lFinalTarget = Location(GetAreaFromLocation(lFinalTarget),vFinalPosition,GetFacingFromLocation(lFinalTarget));
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            nDamage = d10(nDice);
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, nSave))
            {
                nDamage = nDamage / 2;
            }
            if(nDamage > 0)
            {

                eDamage = EffectDamage(nDamage, nType);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
            }
            if (bPoison && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
               if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON))
               {
                    ePoison = EffectPoison(MothGetPoison());
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePoison,oTarget));
               }
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
            }
         }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE );
    }
}



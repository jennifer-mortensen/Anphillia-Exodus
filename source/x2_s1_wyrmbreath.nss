#include "X0_I0_SPELLS"
#include "NW_I0_SPELLS"
#include "x2_inc_shifter"

void main()
{

    //--------------------------------------------------------------------------
    // Set up variables
    //--------------------------------------------------------------------------
    int nType = GetSpellId();
    int nDamageType;
    int nDamageDie;
    int nVfx;
    int nSave;
    int nSpell;
    int nDice;
    int nRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
    //--------------------------------------------------------------------------
    // Calculate Save DC based on shifter level
    //--------------------------------------------------------------------------
    int  nDC  = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+4;
    //--------------------------------------------------------------------------
    // Decide on breath weapon type, vfx based on spell id
    //--------------------------------------------------------------------------
    switch (nType)
    {
        case 663: //white
            nDamageDie  = 10;
            nDamageType = DAMAGE_TYPE_COLD;
            nVfx        = VFX_IMP_FROST_S;
            nSave       = SAVING_THROW_TYPE_COLD;
            nSpell      = SPELLABILITY_DRAGON_BREATH_COLD;
            nDice       = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2)+1;
            break;

        case 664: //black
            nDamageDie  = 10;
            nDamageType = DAMAGE_TYPE_ACID;
            nVfx        = VFX_IMP_ACID_S;
            nSave       = SAVING_THROW_TYPE_ACID;
            nSpell      = SPELLABILITY_DRAGON_BREATH_ACID;
            nDice       = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2)+1;
            break;

        case 665: //red
            if(nRDD>1)
            {
            nDamageDie   = 11;
            nDamageType  = DAMAGE_TYPE_FIRE;
            nVfx         = VFX_IMP_FLAME_M;
            nSave        = SAVING_THROW_TYPE_FIRE;
            nSpell       = SPELLABILITY_DRAGON_BREATH_FIRE;
            nDice        = nRDD/2+3;
            nDC          = nRDD+20;
            }
            else
            {
            nDamageDie   = 10;
            nDamageType  = DAMAGE_TYPE_FIRE;
            nVfx         = VFX_IMP_FLAME_M;
            nSave        = SAVING_THROW_TYPE_FIRE;
            nSpell       = SPELLABILITY_DRAGON_BREATH_FIRE;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2)+1;
            }
            break;

        case 666: //green
            nDamageDie   = 10;
            nDamageType  = DAMAGE_TYPE_ACID;
            nVfx         = VFX_IMP_ACID_S;
            nSave        = SAVING_THROW_TYPE_ACID;
            nSpell       = SPELLABILITY_DRAGON_BREATH_GAS;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2)+1;
            break;

        case 667: //blue
            nDamageDie   = 10;
            nDamageType  = DAMAGE_TYPE_ELECTRICAL;
            nVfx         = VFX_IMP_LIGHTNING_S;
            nSave        = SAVING_THROW_TYPE_ELECTRICITY;
            nSpell       = SPELLABILITY_DRAGON_BREATH_LIGHTNING;
            nDice        = (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2)+1;
            break;

    }
    //--------------------------------------------------------------------------
    // Calculate Damage
    //--------------------------------------------------------------------------


    int nDamage;
    float fDelay;
    object oTarget;
    effect eVis, eBreath;

    //--------------------------------------------------------------------------
    //Loop through all targets and do damage
    //--------------------------------------------------------------------------
    location lFinalTarget = GetSpellTargetLocation();
    vector vFinalPosition;
    if ( lFinalTarget == GetLocation(OBJECT_SELF) )
    {
        // Since the target and origin are the same, we have to determine the
        // direction of the spell from the facing of OBJECT_SELF (which is more
        // intuitive than defaulting to East everytime).

        // In order to use the direction that OBJECT_SELF is facing, we have to
        // instead we pick a point slightly in front of OBJECT_SELF as the target.
        vector lTargetPosition = GetPositionFromLocation(lFinalTarget);
        vFinalPosition.x = lTargetPosition.x +  cos(GetFacing(OBJECT_SELF));
        vFinalPosition.y = lTargetPosition.y +  sin(GetFacing(OBJECT_SELF));
        lFinalTarget = Location(GetAreaFromLocation(lFinalTarget),vFinalPosition,GetFacingFromLocation(lFinalTarget));
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            switch ( nDamageDie )
            {
                case 4:
                    nDamage = d2(nDice);
                    break;
                case 6:
                    nDamage = d4(nDice);
                    break;
                case 8:
                    nDamage = d6(nDice);
                    break;
                case 10:
                    nDamage = d8(nDice);
                    break;
                case 11:
                    nDamage = d10(nDice);
                    break;
            }
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_FIRE))
            {
                nDamage = nDamage / 2;
            }
            if (nDamage > 0)
            {
                eBreath = EffectDamage(nDamage, nDamageType);
                eVis = EffectVisualEffect(nVfx);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreath, oTarget));
             }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lFinalTarget, TRUE);
    }
}






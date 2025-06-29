int ApplyPrismaticEffect(int nEffect, object oTarget, object oCaster);
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nRandom;
    int nVisual;
    effect eVisual;
    int bTwoEffects;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRISMATIC_SPRAY));
            //Make an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                //Blind the target if they are less than 9 HD
                nRandom = Random(7);
                nVisual = ApplyPrismaticEffect(nRandom, oTarget,OBJECT_SELF);

            }
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation());
    }
}

///////////////////////////////////////////////////////////////////////////////
//  ApplyPrismaticEffect
///////////////////////////////////////////////////////////////////////////////
/*  Given a reference integer and a target, this function will apply the effect
    of corresponding prismatic cone to the target.  To have any effect the
    reference integer (nEffect) must be from 1 to 7.*/
///////////////////////////////////////////////////////////////////////////////
//  Created By: Aidan Scanlan On: April 11, 2001
///////////////////////////////////////////////////////////////////////////////

int ApplyPrismaticEffect(int nEffect, object oTarget, object oCaster)
{
    int nCasterLevel = MothGetCasterLevel(oCaster)/2;
    int nDamage;
    effect ePrism;
    effect eVis;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    int nVis;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    //Based on the random number passed in, apply the appropriate effect and set the visual to
    //the correct constant
    switch(nEffect)
    {
        case 0: //Positive
            {
            nDamage = d12(nCasterLevel);
            nVis = VFX_COM_HIT_FROST;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_POSITIVE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
            }
        break;
        case 1://fire
            nDamage = d12(nCasterLevel);
            nVis = VFX_IMP_FLAME_S;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_FIRE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 2: //Acid
            nDamage = d12(nCasterLevel);
            nVis = VFX_IMP_ACID_L;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_ACID);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 3: //Electricity
            nDamage = d12(nCasterLevel);
            nVis = VFX_IMP_LIGHTNING_S;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_ELECTRICITY);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 4: //Sonic
            {
            nDamage = d12(nCasterLevel);
            nVis = VFX_IMP_SONIC;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_SONIC);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
            }
        break;
        case 5: //Paralyze
            {
                effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()) == 0)
                {
                    ePrism = EffectCutsceneParalyze();
                    eLink = EffectLinkEffects(eDur, ePrism);
                    eLink = EffectLinkEffects(eLink, eDur2);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
                }
            }
        break;
        case 6: //Divine
            {
            nDamage = d12(nCasterLevel);
            nVis = VFX_COM_HIT_DIVINE;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_DIVINE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));

            }
        break;
        case 7: //Divine
            {
            nDamage = d12(nCasterLevel);
            nVis = VFX_COM_HIT_DIVINE;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_DIVINE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));

            }
        break;
    }
    return nVis;
}


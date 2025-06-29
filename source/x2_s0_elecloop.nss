#include "x2_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    location lTarget    = GetSpellTargetLocation();
    effect   eStrike    = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    int      nMetaMagic = GetMetaMagicFeat();
    float    fDelay;
    effect   eBeam;
    int      nDamage;
    int      nPotential;
    effect   eDam;
    object   oLastValid;
    effect   eStun = EffectLinkEffects(EffectVisualEffect(VFX_IMP_STUN),EffectDazed());
    int nNumDice = MothGetCasterLevel(OBJECT_SELF);
    if (nNumDice<1)
    {
        nNumDice = 1;
    }
    if (nNumDice >8)
    {
        nNumDice = 8;
    }
    else if (nNumDice >=21)
    {
        nNumDice = 15;
    }
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (GetIsObjectValid(oLastValid))
            {
                   fDelay += 0.2f;
                   fDelay += GetDistanceBetweenLocations(GetLocation(oLastValid), GetLocation(oTarget))/20;
            }
            else
            {
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            }
            if (GetIsObjectValid(oLastValid))
            {
                 eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oLastValid, BODY_NODE_CHEST);
                 DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam,oTarget,1.5f));
            }
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nPotential = MaximizeOrEmpower(6, nNumDice, nMetaMagic);
                nDamage    = MothGetReflexAdjustedDamage(nPotential, oTarget, MothDC(), SAVING_THROW_TYPE_ELECTRICITY);
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStun,oTarget, RoundsToSeconds(2)));
                }
                if (nDamage >0)
                {
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oTarget));
                 }
            }
            oLastValid = oTarget;

        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE );
    }

}



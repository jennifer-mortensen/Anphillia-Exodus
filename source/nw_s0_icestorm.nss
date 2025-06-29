//::///////////////////////////////////////////////
//:: Ice Storm
//:: nw_s0_icestorm
//:://////////////////////////////////////////////
/*
    Deals 3d8 Bludgeoning Damage, 4d8 Cold Damage,
    and an additional 1d8 Cold Damage per three
    caster levels above the sixth in a huge
    area of effect. Ice storm is not party
    friendly.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: March 3, 2010
//:://////////////////////////////////////////////

#include "_inc_gen"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    effect eIceStorm = EffectVisualEffect(VFX_FNF_ICESTORM);
    effect eImpact = EffectVisualEffect(VFX_IMP_FROST_S);
    float fDelay;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nBludgeoningDamage;
    int nBludgeoningDamageDice = 3;
    int nColdDamage;
    int nColdDamageDice = 4;
    location lTarget = GetSpellTargetLocation();
    object oTarget;

    if(GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_RAKSHASA_MALE) || GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_RAKSHASA_FEMALE))
        nCasterLevel +=  MothGetShifterLevels(OBJECT_SELF);

    nColdDamageDice += (nCasterLevel - 6) / 3;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eIceStorm, lTarget);

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ICE_STORM));
            fDelay = GetRandomDelay(0.75, 1.25);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                if(nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nBludgeoningDamage = nBludgeoningDamageDice * 8;
                    nColdDamage = nColdDamageDice * 8;
                }
                else
                {
                    nBludgeoningDamage = d8(nBludgeoningDamageDice);
                    nColdDamage = d8(nColdDamageDice);
                    if(nMetaMagic == METAMAGIC_EMPOWER)
                    {
                        nBludgeoningDamage = nBludgeoningDamage + (nBludgeoningDamage / 2);
                        nColdDamage = nColdDamage + (nColdDamage / 2);
                    }
                }
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nBludgeoningDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_ONE), oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nColdDamage, DAMAGE_TYPE_COLD), oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}


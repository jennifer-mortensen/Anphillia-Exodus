#include "x2_inc_toollib"
#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    effect eVis1 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    int nFail = 5 + (nCasterLvl/4);
    effect eSF = EffectSpellFailure(nFail);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDamageBonus=nCasterLvl+6;
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    TLVFXPillar(VFX_IMP_EVIL_HELP,GetLocation(OBJECT_SELF), 4, 0.0f, 6.0f);
    TLVFXPillar(VFX_IMP_GLOBE_USE,GetLocation(OBJECT_SELF), 4, 0.0f, 6.0f);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            if(!GetIsPC(oTarget)){eSF = EffectSpellFailure(nFail*2);}
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                nDamage = d3(nCasterLvl)+nDamageBonus;
                effect eAcid = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_FOUR);
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSF, oTarget, RoundsToSeconds(nCasterLvl/2)));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}


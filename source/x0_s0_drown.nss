#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDam = GetCurrentHitPoints(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eMove = EffectAbilityDecrease(ABILITY_CONSTITUTION,3);
    effect eDam;
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 437));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            if ((GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
                &&(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                &&(GetRacialType(oTarget) != RACIAL_TYPE_ELEMENTAL))
            {
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()))
                {
                    RemoveEffectsFromSpell(oTarget, GetSpellId());
                    TLVFXPillar(VFX_IMP_NEGATIVE_ENERGY, GetLocation(oTarget),3,0.0f);
                    nDam = FloatToInt(nDam * 0.70);
                    if(nDam>500){nDam==496+d10();}
                    eDam = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oTarget,RoundsToSeconds(4));
                }
            }
        }
    }
}






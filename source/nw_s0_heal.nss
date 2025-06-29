#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "_inc_spells"
void main()
{
    if(!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    int nPureDruid = FALSE;
    if(MothGetIsPureClass(CLASS_TYPE_DRUID,OBJECT_SELF))
    {
        nPureDruid = TRUE;
    }
    object oTarget = GetSpellTargetObject();
    effect eHeal;
    int nHeal, nTouch;
    effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
    if(GetLevelByClass(CLASS_TYPE_DRUID) > 0) //J. Persinne; Druids that cast this spell now provide a heal over time effect to the target.
    {
        ApplyDruidHoT(250, oTarget);
    }
    nHeal = GetDomainAdjustedHeal(250);
    if(!GetIsObjectValid(oScroll))
    {
        if(nPureDruid == TRUE && (GetRacialType(oTarget) == RACIAL_TYPE_ANIMAL || GetRacialType(oTarget) == RACIAL_TYPE_DRAGON))
        {
            nHeal = 500;
        }
    }
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            if (TouchAttackMelee(oTarget))
            {
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    eHeal = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}

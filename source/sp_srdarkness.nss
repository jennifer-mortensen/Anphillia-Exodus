#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "_inc_xp"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    int nCurrentAbilityUses = GetLocalInt(OBJECT_SELF, "CURRENT_DARKNESS_CASTINGS");

    if(nCurrentAbilityUses > 0)
    {
        nCurrentAbilityUses--;
        SetLocalInt(OBJECT_SELF, "CURRENT_DARKNESS_CASTINGS", nCurrentAbilityUses);
        SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You now have " + IntToString(nCurrentAbilityUses) + " use(s) of darkness left.</c>");
    }
    else
    {
        FloatingTextStringOnCreature("<cþŒ >*You must rest in order to replenish your racial darkness spell(s) per day.*</c>", OBJECT_SELF, FALSE);
        return;
    }

    effect eAOE = EffectAreaOfEffect(AOE_PER_DARKNESS, "sp_srdarknessa", "sp_srdarknessb");
    location lTarget = GetSpellTargetLocation();

    int nCasterLevel = GetECLAdjustedHitDice(OBJECT_SELF);

    int nDuration = nCasterLevel;
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);

    if (nDuration < 1)
    {
        nDuration = 1;
    }

    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,6.7))
    {
     FloatingTextStringOnCreature("<cŒŒŒ>*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}


//::///////////////////////////////////////////////
//:: Clairaudience / Clairvoyance
//:: NW_S0_ClairAdVo.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants the target creature a bonus of +10 to
    spot and listen checks
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 21, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    effect eSpot = EffectSkillIncrease(SKILL_SEARCH, 5);
    effect eListen = EffectSkillIncrease(SKILL_OPEN_LOCK, 5);
    effect eVis = EffectVisualEffect(VFX_DUR_GLOW_YELLOW);
    effect eDur = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);

    effect eLink = EffectLinkEffects(eSpot, eListen);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);

    object oTarget = GetSpellTargetObject();
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    //Meta-Magic checks
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }

    //Make sure the spell has not already been applied
    if(!GetHasSpellEffect(SPELL_KNOCK, oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_KNOCK, FALSE));

         //Apply linked and VFX effects
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10));
    }
}


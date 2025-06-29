#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oOwner = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur3 = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eFear = EffectFrightened();
    effect eMind = EffectDazed();
    effect eDam;
    effect eVis2 = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eVis3 = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eVis4 = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eVis5 = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eLink = EffectLinkEffects(eFear, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    effect eLink2 = EffectLinkEffects(eMind, eDur3);
    eLink2 = EffectLinkEffects(eLink2, eDur2);
    int nDamage;
    int nLevel = GetLevelByClass(40,oOwner);
    int nHD =(GetSkillRank(SKILL_TAUNT,oOwner,TRUE)/2)+1;
    int nDC =(GetSkillRank(SKILL_TAUNT,oOwner,TRUE)/2)+11;
    int nDuration = nHD;
    if(GetIsEnemy(oTarget, GetAreaOfEffectCreator()))
    {
        SignalEvent(oTarget, EventSpellCastAt(oOwner, SPELLABILITY_AURA_FEAR));
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
        {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        if ((nLevel >= 2) && (nLevel <= 6))
            {
                nDamage = d4(nHD);
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_COLD))
                {
                    nDamage = nDamage / 2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        if ((nLevel >= 7) && (nLevel <= 10))
            {
                nDamage = d4(nHD);
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_FIRE))
                {
                    nDamage = nDamage / 2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget);
            }
        if ((nLevel >= 11) && (nLevel <= 14))
            {
                nDamage = d4(nHD);
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY))
                {
                    nDamage = nDamage / 2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis4, oTarget);
            }
        if (nLevel >= 15)
            {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS))
              {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis5, oTarget);
              }
            }
    }
}

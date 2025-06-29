#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nToAffect = nCasterLevel/2+2;
    object oTarget;
    float fTargetDistance;
    float fDelay;
    location lTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eWail = EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
    int nCnt = 1;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWail, GetSpellTargetLocation());
    oTarget = GetSpellTargetObject();
    if (!GetIsObjectValid(oTarget))
    oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    while (nCnt <= nToAffect)
    {
        lTarget = GetLocation(oTarget);
        fDelay = GetRandomDelay(1.0, 4.0);
        fTargetDistance = GetDistanceBetweenLocations(GetSpellTargetLocation(), lTarget);
        if(GetIsObjectValid(oTarget) && fTargetDistance <= 12.0)
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WAIL_OF_THE_BANSHEE));
                if(!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_DEATH))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        effect eDeath = EffectDeath();
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                    }
                }
            }
        }
        else
        {
            nCnt = nToAffect;
        }
        nCnt++;
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    }
}


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage = d6(6);
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    int nToAffect = 10;
    object oTarget;
    float fTargetDistance;
    float fDelay;
    location lTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eHit = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eWail = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    int nCnt = 1;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWail, GetSpellTargetLocation());
    oTarget = GetSpellTargetObject();
    if (!GetIsObjectValid(oTarget))
      oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    while (nCnt <= nToAffect)
    {
        lTarget = GetLocation(oTarget);
        fDelay = GetRandomDelay(3.0, 4.0);
        fTargetDistance = GetDistanceBetweenLocations(GetSpellTargetLocation(), lTarget);
        if(GetIsObjectValid(oTarget) && fTargetDistance <= 12.0)
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
             SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DEATH));
             if(GetHitDice(oTarget) <= 17)
             {
                if(!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_DEATH)) //, OBJECT_SELF, 3.0))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        effect eDeath = EffectDeath();
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget)); // no delay
                    }
                }
             }
            }
        }
        else
        {
            //Kick out of the loop
            nCnt = nToAffect;
        }
        //Increment the count of creatures targeted
        nCnt++;
        //Get the next closest target in the spell target location.
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, GetSpellTargetLocation(), nCnt);
    }
}

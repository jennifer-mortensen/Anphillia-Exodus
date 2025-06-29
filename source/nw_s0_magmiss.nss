#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eMissile = EffectVisualEffect(VFX_IMP_MIRV);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    int nMissiles = (nCasterLvl - 1) / 2 + 1;
    if(nMissiles > 5)
        nMissiles = 5;
    if(nCasterLvl > 20)
    {
        nMissiles += (nCasterLvl - 20) / 4;
    }
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    float fDelay2, fTime;

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_MISSILE));
        if (nMissiles < 3)
        {
            nMissiles = 3;
        }
        if (nMissiles > 8)
        {
            nMissiles = 8;
        }
        if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        {
           for (nCnt = 1; nCnt <= nMissiles; nCnt++)
            {
                int nDam = d4(1) + 1;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                      nDam = 5;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDam = nDam + nDam/2;
                }
                fTime = fDelay;
                fDelay2 += 0.1;
                fTime += fDelay2;
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY);
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
             }
         }
         else
         {
            for (nCnt = 1; nCnt <= nMissiles; nCnt++)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
            }
         }
     }
}

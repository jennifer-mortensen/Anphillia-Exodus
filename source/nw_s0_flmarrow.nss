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
    effect eMissile;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    int nMissiles = (nCasterLvl)/4;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_ARROW));
        for (nCnt = 1; nCnt <= nMissiles; nCnt++)
        {
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                int nDam = d6(4) + 1;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                      nDam = 24;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDam = nDam + nDam/2;
                }
                nDam = MothGetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_FIRE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));

            }
            eMissile = EffectVisualEffect(VFX_IMP_MIRV_FLAME);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
        }
    }
}


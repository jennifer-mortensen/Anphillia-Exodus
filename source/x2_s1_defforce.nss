//Intelligent Weapon
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
    effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eVis3 = EffectVisualEffect(VFX_COM_SPARKS_PARRY);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    int nMissiles = (nCasterLvl)/4;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        for (nCnt = 1; nCnt <= nMissiles; nCnt++)
        {
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                int nDam = d6(5) + 1;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                      nDam = 30;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDam = nDam + nDam/2;
                }
                nDam = MothGetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_TRAP);
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_FIVE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
            }
            eMissile = EffectVisualEffect(486);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
        }
    }
}



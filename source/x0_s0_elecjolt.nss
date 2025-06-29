#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (!MothDecreaseOnHitSpellChancePC())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    if (nCasterLevel <= 29)
    {
        nCasterLevel = 5;
    }
    else
    {
        nCasterLevel = 15;
    }
    int nDam = d3(nCasterLevel);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDam = 3*nCasterLevel ;
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDam = nDam + nDam/2;
            }
        effect eBad = EffectDamage(nDam, DAMAGE_TYPE_ELECTRICAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
    }
}











#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF)/2;
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_QUILLFIRE));
        {
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                int nDam = d4(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                      nDam = 4*nCasterLvl;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDam = nDam + nDam/2;
                }
                nDam = nDam + nCasterLvl+10/2;
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_ACID);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
                effect ePoison = EffectPoison(POISON_LARGE_SCORPION_VENOM);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoison, oTarget);
            }

        }
    }
}




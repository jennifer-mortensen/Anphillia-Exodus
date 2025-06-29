#include "x2_inc_spellhook"
void main()
{
        if (!X2PreSpellCastCode())
        {
            return;
        }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSummon;
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    int nRoll = d4();
    object oScroll = GetSpellCastItem();
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER) && !GetIsObjectValid(oScroll)) //WITH THE ANIMAL DOMAIN
    {
        switch (nRoll)
        {
            case 1:
                eSummon = EffectSummonCreature("MOTH_S_AIREPIC");
            break;

            case 2:
                eSummon = EffectSummonCreature("MOTH_S_WATEREPIC");
            break;

            case 3:
                eSummon = EffectSummonCreature("MOTH_S_EARTHEPIC");
            break;

            case 4:
                eSummon = EffectSummonCreature("MOTH_S_FIREEPIC");
            break;
        }
    }
    else
    {
        switch (nRoll)
        {
            case 1:
                eSummon = EffectSummonCreature("NW_S_AIRELDER");
            break;

            case 2:
                eSummon = EffectSummonCreature("NW_S_WATERELDER");
            break;

            case 3:
                eSummon = EffectSummonCreature("NW_S_FIREELDER");
            break;

            case 4:
                eSummon = EffectSummonCreature("NW_S_EARTHELDER");
            break;
        }
    }
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
}


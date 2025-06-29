#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    string sSummon1 ="NW_SW_AIRGREAT";
    string sSummon2 ="NW_SW_WATERGREAT";
    string sSummon3 ="NW_SW_EARTHGREAT";
    string sSummon4 ="NW_SW_FIREGREAT";
    if(GetHasFeat(FEAT_EPIC_DRUID,OBJECT_SELF))
    {
    sSummon1 ="MOTH_S_AIREPIC";
    sSummon2 ="MOTH_S_WATEREPIC";
    sSummon3 ="MOTH_S_EARTHEPIC";
    sSummon4 ="MOTH_S_FIREEPIC";
    }
    string sSummonOn1;
    string sSummonOn2;
    string sSummonOn3;
    string sSummonOn4;
    switch (Random(4))
      {
       case 0: sSummonOn1 = sSummon1; break;
       case 1: sSummonOn1 = sSummon2; break;
       case 2: sSummonOn1 = sSummon3; break;
       case 3: sSummonOn1 = sSummon4; break;
     }
    switch (Random(4))
      {
       case 0: sSummonOn2 = sSummon1; break;
       case 1: sSummonOn2 = sSummon2; break;
       case 2: sSummonOn2 = sSummon3; break;
       case 3: sSummonOn2 = sSummon4; break;
     }
    switch (Random(4))
      {
       case 0: sSummonOn3 = sSummon1; break;
       case 1: sSummonOn3 = sSummon2; break;
       case 2: sSummonOn3 = sSummon3; break;
       case 3: sSummonOn3 = sSummon4; break;
     }
    switch (Random(4))
      {
       case 0: sSummonOn4 = sSummon1; break;
       case 1: sSummonOn4 = sSummon2; break;
       case 2: sSummonOn4 = sSummon3; break;
       case 3: sSummonOn4 = sSummon4; break;
     }
    effect eSummon;
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    eSummon = EffectSwarm(FALSE,sSummonOn1,sSummonOn2,sSummonOn3,sSummonOn4);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummon, OBJECT_SELF, HoursToSeconds(nDuration));
}


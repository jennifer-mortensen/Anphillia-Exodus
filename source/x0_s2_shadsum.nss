#include "x2_inc_spellhook"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(27);
    int nDuration = nCasterLevel;
    effect eSummon;
    MothUnsummonMultipleSummons();
    if (nCasterLevel <= 5)
    {
        eSummon = EffectSummonCreature("mothplanar1",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <= 8)
    {
        eSummon = EffectSummonCreature("mothplanar1",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <=10)
    {
        eSummon = EffectSummonCreature("mothplanar2",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
      if (GetHasFeat(1002,OBJECT_SELF)&& nCasterLevel >=20)
      {
               eSummon = EffectSummonCreature("mothsdsum20",VFX_FNF_SUMMON_EPIC_UNDEAD);
      }
      else if (GetHasFeat(1002,OBJECT_SELF))
      {
           if (GetLocalString(OBJECT_SELF,"MothSetFactionInt") == "MothAxfellMember")
              {
               eSummon = EffectSummonCreature("mothplanevil",VFX_FNF_SUMMON_UNDEAD);
              }
           else
              {
               eSummon = EffectSummonCreature("mothplangood",VFX_FNF_SUMMON_UNDEAD);
              }
      }
      else
      {
         eSummon = EffectSummonCreature("mothplanar2",VFX_FNF_SUMMON_UNDEAD);
      }

    }
    eSummon = ExtraordinaryEffect(eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}

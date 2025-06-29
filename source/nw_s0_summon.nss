effect SetSummonEffect(int nSpellID);
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nSpellID = GetSpellId();
    if(nSpellID == SPELL_SUMMON_CREATURE_IX && GetAppearanceType(OBJECT_SELF) == 2508 && GetIsPC(OBJECT_SELF)) //J. Persinne; Lizardfolk Whipmasters have a 30 seconds
    {                                                                                                         //timelock on their summon.
        int nTimelock = GetLocalInt(OBJECT_SELF, "SUMMON_CREATURE_IX_TIMELOCK");
        if(nTimelock == TRUE)
        {
            FloatingTextStringOnCreature("<c ее>*No Summon Creature IX Focus!*</c>",OBJECT_SELF,FALSE);
            SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
            return;
        }
        else
        {
            DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
            DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Summon Creature IX Focus is lost!</c>"));
            SetLocalInt(OBJECT_SELF, "SUMMON_CREATURE_IX_TIMELOCK", TRUE);
            DelayCommand(30.0, DeleteLocalInt(OBJECT_SELF, "SUMMON_CREATURE_IX_TIMELOCK"));
            DelayCommand(30.0, FloatingTextStringOnCreature("<c ее>*Summon Creature IX Focus Regained!*</c>",OBJECT_SELF,FALSE));
        }
    }
    if(nSpellID == SPELL_SUMMON_CREATURE_V &&
    GetHasFeat(FEAT_EPIC_DRUID,OBJECT_SELF))
    {
      ExecuteScript("mothdruidswarm",OBJECT_SELF);
      return;
    }
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    if(nDuration == 1)
    {
        nDuration = 2;
    }
    effect eSummon = SetSummonEffect(nSpellID);
    MothUnsummonMultipleSummons();
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}


effect SetSummonEffect(int nSpellID)
{
    int nFNF_Effect;
    int nRoll = d3();
    int nRoll2 = d4();
    string sSummon;
    if(GetAppearanceType(OBJECT_SELF) == 2508 && GetIsPC(OBJECT_SELF)) //J. Persinne; Epic Lizardfolk Whipmasters summon epic elementals.
    {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        switch (nRoll2)
        {
            case 1:
                sSummon = "MOTH_S_AIREPIC";
                break;
            case 2:
                sSummon = "MOTH_S_WATEREPIC";
                break;
            case 3:
                sSummon = "MOTH_S_FIREEPIC";
                break;
            case 4:
                sSummon = "MOTH_S_EARTHEPIC";
                break;
        }
    }
    else if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            if (GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF)>9)
                {
                switch (nRoll2)
                       {
                     case 1:
                      sSummon = "NW_S_AIRHUGE";
                     break;
                     case 2:
                      sSummon = "NW_S_WATERHUGE";
                     break;
                     case 3:
                      sSummon = "NW_S_FIREHUGE";
                     break;
                     case 4:
                      sSummon = "NW_S_EARTHHUGE";
                     break;
                     }
                }
            else
                {
                sSummon = "NW_S_diretiger";
                }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll2)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
                case 4:
                    sSummon = "NW_S_EARTHHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll2)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
                case 4:
                    sSummon = "NW_S_EARTHGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll2)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
                case 4:
                    sSummon = "NW_S_EARTHELDER";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll2)
            {
                case 1:
                    sSummon = "MOTH_S_AIREPIC";
                break;

                case 2:
                    sSummon = "MOTH_S_WATEREPIC";
                break;

                case 3:
                    sSummon = "MOTH_S_FIREEPIC";
                break;
                case 4:
                    sSummon = "MOTH_S_EARTHEPIC";
                break;
            }
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_s_badgerdire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;

}


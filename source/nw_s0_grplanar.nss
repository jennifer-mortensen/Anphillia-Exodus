#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eGate;
    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if (GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
           if(nRacial == RACIAL_TYPE_OUTSIDER){nDuration=nDuration*10;}
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
           if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
                {
                    MothImmobilize(oTarget,OBJECT_SELF,GetSpellId(),nDuration);
                }
            }
        }
    }
    else
    {
        MothUnsummonMultipleSummons();
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature("summonedfiendis", VFX_FNF_SUMMON_GATE, 3.0);
            break;
            case ALIGNMENT_GOOD:
                eSummon = EffectSummonCreature("NW_S_CTRUMPET", VFX_FNF_SUMMON_CELESTIAL, 3.0);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature("NW_S_CTRUMPET", VFX_FNF_SUMMON_MONSTER_3, 1.0);
                fDelay = 1.0;
            break;
        }
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    }
}


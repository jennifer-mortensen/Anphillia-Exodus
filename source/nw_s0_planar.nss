#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eGate;
    int nRacial = GetRacialType(oTarget);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nDuration == 0)
    {
        nDuration == 1;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if (GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(nRacial == RACIAL_TYPE_OUTSIDER){nDuration=nDuration*10;}
            if (GetIsPlayableRacialType(oTarget) ||
                nRacial == RACIAL_TYPE_OUTSIDER ||
                nRacial == RACIAL_TYPE_ANIMAL)
            {
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
                    {
                      MothImmobilize(oTarget,OBJECT_SELF,GetSpellId(),nDuration);
                    }
                }
            }
        }
    }
    else
    {
        MothUnsummonMultipleSummons();
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature("summonedarcanal",VFX_FNF_SUMMON_GATE, fDelay);
            break;
            case ALIGNMENT_GOOD:
                eSummon = EffectSummonCreature("NW_S_CHOUND", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature("NW_S_CHOUND",VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
        }
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    }
}


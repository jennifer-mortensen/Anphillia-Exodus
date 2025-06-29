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
    if(nDuration == 0)
    {
        nDuration = 1;
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
                nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID ||
                nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS ||
                nRacial == RACIAL_TYPE_HUMANOID_ORC ||
                nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN)
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
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                {
                    eSummon = EffectSummonCreature("summonedflayer",VFX_FNF_SUMMON_GATE , fDelay);
                }
            break;
            case ALIGNMENT_GOOD:
                {
                    eSummon = EffectSummonCreature("nw_s_clantern", 219 ,fDelay);
                }
            break;
            case ALIGNMENT_NEUTRAL:
                {
                    eSummon = EffectSummonCreature("nw_s_clantern", 219 ,fDelay);
                }
            break;
        }
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    }
}


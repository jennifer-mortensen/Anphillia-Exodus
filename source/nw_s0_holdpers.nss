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
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nMeta = GetMetaMagicFeat();
    int nDuration = nCasterLvl/4;
    if (nMeta == METAMAGIC_EXTEND)
       {
        nDuration = nDuration * 2;
       }
    if(!MothGetIsFortAlly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_PERSON));
        if (GetIsPlayableRacialType(oTarget) ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN)
        {
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
                {
                 //MothImmobilize(oTarget,OBJECT_SELF,GetSpellId(),nDuration); //J. Persinne; No need for immobilization effects with permanent freedom removed.
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
    }
}

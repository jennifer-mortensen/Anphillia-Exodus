#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eLink = CreateDoomEffectsLink();
    eLink = ExtraordinaryEffect(eLink);
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
          {
            int nResult = WillSave(oTarget, MothDC(), SAVING_THROW_TYPE_NONE);
            if (nResult == 1)
            {
                return;
            }
            else if (nResult == 2)
            {
                if (GetIsPC(OBJECT_SELF))
                {
                    FloatingTextStrRefOnCreature(84525, oTarget,FALSE);
                }
                return;
            }
            else
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, HoursToSeconds(nLevel));
            }
          }
    }
}

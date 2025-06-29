#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
     FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
     return;
    }
    effect eDexFix = EffectAbilityIncrease(ABILITY_DEXTERITY, 1);
    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eFreeze2 = EffectCutsceneParalyze();
    eFreeze = ExtraordinaryEffect(eFreeze);
    eFreeze2 = ExtraordinaryEffect(eFreeze2);
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nMeta = GetMetaMagicFeat();
    int nSpell = GetSpellId();
    int nDuration = nCasterLvl/10;
    float fDuration = IntToFloat(nDuration);
    fDuration = fDuration + 3.0;
    if (nMeta == METAMAGIC_EXTEND)
       {
        fDuration = fDuration + 1.0;
       }
    if (nSpell==635)
       {
        fDuration = fDuration * 2;
       }
    if(!MothGetIsFortAlly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,nSpell));
        if(MothStopRacialSpellCheck(oTarget))
        {
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
               if(GetIsPC(oTarget))
               {
                if (!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(),SAVING_THROW_TYPE_SPELL))
                {
                    DelayCommand(0.2,TLVFXPillar(VFX_IMP_EVIL_HELP, GetLocation(oTarget), 6, 0.0f, 3.0f));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze,oTarget,fDuration);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze2,oTarget,fDuration);
                    DelayCommand(fDuration, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDexFix, oTarget, 0.5));
                }
               }
               else
               {
                    fDuration = fDuration + 1.5;
                    DelayCommand(0.2,TLVFXPillar(VFX_IMP_EVIL_HELP, GetLocation(oTarget), 6, 0.0f, 3.0f));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze,oTarget,fDuration);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze2,oTarget,fDuration);
                    DelayCommand(fDuration, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDexFix, oTarget, 0.5));
               }
            }
        }
        else
        {
          SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Invalid Target or Racial Type!</c>");
        }
    }
}

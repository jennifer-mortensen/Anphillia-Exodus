#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGGHOUL);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDice = 6;
    int nDC = MothDC();
    //If Demonflesh Golem
    if(GetAppearanceType(OBJECT_SELF) == 468)
    {
      nCasterLvl = GetHitDice(OBJECT_SELF);
      nDice = 10;
      nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD,TRUE)+9;
    }
    int nDamage;
    int nDuration = nCasterLvl/2;
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if(!MothGetIsFortAlly(oTarget) && GetHasSpellEffect(SPELL_GHOUL_TOUCH,oTarget)==FALSE)
    {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GHOUL_TOUCH));
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, GetLocation(oTarget), RoundsToSeconds(nDuration));
            if(!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE))
            {
                nDamage = d6(nDice)+nDuration;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nDice*6 + nDuration;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + nDamage / 2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(0.5, MothImmobilize(oTarget,OBJECT_SELF,GetSpellId(),nDuration/2));
            }
    }
}


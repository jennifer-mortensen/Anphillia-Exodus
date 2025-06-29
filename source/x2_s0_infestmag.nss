#include "x2_I0_SPELLS"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
void RunMaggotImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic);
void main()
{

    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDamage = MothGetCasterLevel(OBJECT_SELF);
    if (nDamage > 15)
    {
        nDamage = 15;
    }
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage += 18;
    }
    else
    {
        nDamage  += d6(3);
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2);
        }
    }
    int nDuration = 10 + MothGetCasterLevel(OBJECT_SELF);
    if (nDuration < 1)
    {
        nDuration = 10;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration*2;
    }
    effect eDam      = EffectDamage(nDamage+12, DAMAGE_TYPE_ACID);
    effect eDur      = EffectVisualEffect(VFX_DUR_FLIES);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            TLVFXPillar(VFX_IMP_ACID_L, GetLocation(oTarget), 4, 0.1f,0.0f, 1.0f);
            DelayCommand(0.1,TLVFXPillar(VFX_IMP_ACID_L, GetLocation(oTarget), 4, 0.1f,0.0f, 1.0f));
            DelayCommand(0.2,TLVFXPillar(VFX_IMP_ACID_L, GetLocation(oTarget), 4, 0.1f,0.0f, 1.0f));
            if (GetHasSpellEffect(GetSpellId(),oTarget))
            {
                FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
                return;
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration/2));
            DelayCommand(8.0, RunMaggotImpact(oTarget,oCaster,nLevel, nMetaMagic));
        }
    }
}
void RunMaggotImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic)
{
    if (GZGetDelayedSpellEffectsExpired(SPELL_INFESTATION_OF_MAGGOTS,oTarget,oCaster))
    {
        return;
    }
    if (GetIsDead(oTarget) == FALSE)
    {
            int nDamage = nLevel;
            if (nDamage > 15)
            {
                nDamage = 15;
            }
            int nMetaMagic = GetMetaMagicFeat();
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage += 18;
            }
            else
            {
                nDamage  += d6(3);
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
            }
            effect eDmg = EffectDamage(nDamage+12,DAMAGE_TYPE_ACID);
            effect eVFX = EffectVisualEffect(VFX_IMP_ACID_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
            DelayCommand(8.0f,RunMaggotImpact(oTarget,oCaster, nLevel,nMetaMagic));
   }
}



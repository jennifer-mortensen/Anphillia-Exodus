//shadowblend
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
       return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    float fDelay;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)+3;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    object oTarget;
    effect eHeal,eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    if (nCasterLevel > 30)
    {
        nCasterLevel = 30;
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
                nDamage = d4(nCasterLevel);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = nCasterLevel*4;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/22;
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==FALSE)
            {
               if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                 {
                 SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                 eDam = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
            else if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==TRUE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                eHeal = EffectHeal(nDamage*2);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
            }
            else if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==FALSE)
            {
              if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                 SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                 if(MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                 {
                  nDamage /= 2;
                 }
                 eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
               }
            }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }
}

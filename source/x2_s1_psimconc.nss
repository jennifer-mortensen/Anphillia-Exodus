//Psonic Mass Concussion
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    if(nCasterLevel > 28)
    {
        nCasterLevel = 28;
    }
    effect eFla = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect eDiv = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_MASS_MIND_AFFECTING);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_WORD);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
    effect eDeaf = EffectStunned();
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm3, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm4, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
          if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
          {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = GetRandomDelay(0.5, 1.0);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nDamage = d8(nCasterLevel)-nMothBonus3;
                    if (MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SONIC, OBJECT_SELF, 0.5))
                    {
                        nDamage = nDamage / 2;
                    }
                    else
                    {
                        //Apply stun effect
                        DelayCommand(fDelay+0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(nCasterLevel/2)));
                    }
                    if(nDamage > 0)
                    {
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
           }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}



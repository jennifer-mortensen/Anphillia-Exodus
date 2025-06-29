//Shadow Attack
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode()) //J. Persinne; Shadow Attack now deals 1d3 per caster level, and 33% damage back to the caster.
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    //int nBonus = nCasterLevel/2;
    int nDamage = d3(nCasterLevel);
    effect eVisa = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eVisb = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVisc = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);
    effect eVisd = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eVis = EffectLinkEffects(eVisa,eVisb);
    eVis = EffectLinkEffects(eVisa,eVisc);
    eVis = EffectLinkEffects(eVisa,eVisd);
    effect eRay = EffectBeam(VFX_BEAM_EVIL, oTarget, BODY_NODE_CHEST);
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE){nDamage=0;}
    if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
      {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        PlaySound("as_an_bat2");
        PlaySound("as_an_bat2");
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            effect eBad = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            //effect eHeal = EffectHeal(nDamage-nBonus);
            effect eKickbackDamage = EffectDamage(nDamage / 3, DAMAGE_TYPE_NEGATIVE);
            effect eKickbackVFX = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
            //effect eVs = EffectVisualEffect(VFX_IMP_HEALING_M);
            effect eLink = EffectLinkEffects(eKickbackDamage, eKickbackVFX);
            if(nDamage > 0)
            {
            DelayCommand(1.8,ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, OBJECT_SELF));
            DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, OBJECT_SELF, 1.6));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
            }
        }
    }
}



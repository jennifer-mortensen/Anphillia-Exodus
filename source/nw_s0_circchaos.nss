#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nSave = 1+nCasterLvl/10;
    int nDamageBonus = nCasterLvl;
    if(nDamageBonus>10)
    {
      nDamageBonus=10;
    }
    float fDelay;
    effect eSaveDecreased = EffectSavingThrowDecrease(SAVING_THROW_ALL,nSave);
    effect eExplode = EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_HOWL_ODD);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eLinkExplode = EffectLinkEffects(eExplode,eExplode2);
    eLinkExplode = EffectLinkEffects(eLinkExplode,eExplode3);
    effect eVis1 = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);
    effect eVis3 = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eVis4 = EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    eVis = EffectLinkEffects(eVis,eVis4);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLinkExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 14.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d2(nCasterLvl) + nDamageBonus;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 2 * nCasterLvl + nDamageBonus;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + nDamage / 2;
                }
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                  {
                   if(!GetHasSpellEffect(GetSpellId(),oTarget))
                     {
                     DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveDecreased, oTarget, RoundsToSeconds(nCasterLvl)));
                     }
                  }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 14.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}




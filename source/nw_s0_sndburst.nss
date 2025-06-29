#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eStun = EffectStunned();
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eStun, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eDam;
    location lLoc = GetSpellTargetLocation();
    int nDC = MothDC();
    //If Epic Gargoyle
    if(GetAppearanceType(OBJECT_SELF) == 1885)
    {
        int nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        nCasterLevel == nShifter;
        nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+5;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, lLoc);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SOUND_BURST));
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                nDamage = d12(2)+ nCasterLevel+12;
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(3));
                }
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 24 + nCasterLevel +12;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
    }
}


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, OBJECT_SELF) >= 10)
    {
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartFear")==0)
          {
          int nChamp =1;
          IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_FEAR);
          FloatingTextStringOnCreature("<c“pØ>*Epic Purple Dragon Knight. First Fear ability is a free action!*</c>",OBJECT_SELF);
          SetLocalInt(OBJECT_SELF,"MothPDKStartFear",nChamp);
          }
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartFear")>=1)
          {
          }
    }
    object oTarget;
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eAttack = EffectAttackDecrease(3);
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, 3, SAVING_THROW_TYPE_ALL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT);
    int nDC = 16+nChr+nCasterLevel;
    float fDelay;
    location lLoc = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lLoc, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_LOS_NORMAL_30,lLoc, 1, fDelay1, 6.0f, 2.0f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc,TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
             fDelay = GetRandomDelay(0.4, 1.1);
             SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 808, FALSE));
             if(!MySavingThrow(SAVING_THROW_WILL, oTarget,nDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, fDelay))
             {
              RemoveEffectsFromSpell(oTarget, 808);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCasterLevel)));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE);
    }
}

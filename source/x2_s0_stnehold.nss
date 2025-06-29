#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eImpact1 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eDexFix = EffectAbilityIncrease(ABILITY_DEXTERITY, 1);
    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eFreeze2 = EffectCutsceneParalyze();
    eFreeze = ExtraordinaryEffect(eFreeze);
    eFreeze2 = ExtraordinaryEffect(eFreeze2);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    nDuration = nDuration/10;
    float fDuration = IntToFloat(nDuration);
    fDuration = fDuration + 3.0;
    int iTimer = GetLocalInt(OBJECT_SELF, "mothstonehold");
    location lSpell = GetSpellTargetLocation();
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<c ее>*No Stone Hold focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
    return;
    }
    if (iTimer == FALSE)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Stone Hold Focus is lost.</c>"));
    SetLocalInt(OBJECT_SELF, "mothstonehold", TRUE);
    DelayCommand(48.0, DeleteLocalInt(OBJECT_SELF, "mothstonehold"));
    DelayCommand(48.0, FloatingTextStringOnCreature("<c ее>*Stone Hold Focus Regained!*</c>",OBJECT_SELF,FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImpact1, GetSpellTargetLocation(),2.0);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF))
                {
                DelayCommand(0.2,TLVFXPillar(VFX_IMP_EVIL_HELP, GetLocation(oTarget), 6, 0.0f, 3.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze,oTarget,fDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFreeze2,oTarget,fDuration);
                DelayCommand(fDuration, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDexFix, oTarget, 0.5));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lSpell);
    }
   }
}


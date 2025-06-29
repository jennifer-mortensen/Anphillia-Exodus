#include "x2_inc_shifter"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eDur = EffectLinkEffects(eVis,eVis2);
    int nDice = GetHitDice(OBJECT_SELF);
    int nBonus = GetAbilityModifier(ABILITY_WISDOM);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        int nDamage = d2(nDice)+nBonus;
        int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+10;
        nDamage = MothGetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_POSITIVE,OBJECT_SELF);
        effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE);
        eDur = EffectLinkEffects(eDamage,eDur);
        if(nDamage>0)
        {
        DelayCommand(0.1,TLVFXPillar(VFX_IMP_MAGBLUE,GetLocation(oTarget), 1, 0.0f, 0.6f));
        DelayCommand(0.2,TLVFXPillar(VFX_IMP_MAGBLUE,GetLocation(oTarget), 1, 0.0f, 0.4f));
        DelayCommand(0.3,TLVFXPillar(VFX_IMP_MAGBLUE,GetLocation(oTarget), 1, 0.0f, 0.2f));
        DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDur,oTarget));
        }
}

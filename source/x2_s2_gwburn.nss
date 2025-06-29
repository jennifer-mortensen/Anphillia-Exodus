#include "x2_inc_shifter"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    effect eRay      = EffectBeam(444,OBJECT_SELF,BODY_NODE_CHEST);
    effect eDur      = EffectVisualEffect(498);
    int nDice = GetHitDice(OBJECT_SELF);
    int nExtra = nDice/3;
    float fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/16;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay,oTarget,1.7f);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        int nDamage = d4(nDice)+nExtra;
        int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+8;
        nDamage = MothGetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_FIRE,OBJECT_SELF);
        effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
        effect eHit = EffectVisualEffect(VFX_IMP_FLAME_S);
        eHit = EffectLinkEffects(eDamage,eHit);
        if(nDamage>0)
        {
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,3.0f));
        DelayCommand(fDelay+0.3f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oTarget,3.0f));
        }
}




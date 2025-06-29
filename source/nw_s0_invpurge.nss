#include "NW_I0_GENERIC"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    float nRadius = 38.0;
    location lSpell = GetSpellTargetLocation();
    effect eVis1 = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DISPEL_DISJUNCTION);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eVisCaster = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    float fDelay;
    location lTarget = GetSpellTargetLocation();
    int iTimer = GetLocalInt(OBJECT_SELF, "MothInvisPurge");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Spell focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    DelayCommand(1.0, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(1.0, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Invisibility Purge Focus is lost.</c>"));
    SetLocalInt(OBJECT_SELF, "MothInvisPurge", TRUE);
    DelayCommand(300.0, DeleteLocalInt(OBJECT_SELF, "MothInvisPurge"));
    DelayCommand(300.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,nRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
    fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
    DelayCommand(0.1,TLVFXPillar(VFX_IMP_PULSE_WIND,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(0.5,TLVFXPillar(VFX_IMP_PULSE_WIND,GetLocation(OBJECT_SELF), 1, 0.0f, 4.0f));
    DelayCommand(1.1,TLVFXPillar(VFX_IMP_PULSE_WIND,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(1.5,TLVFXPillar(VFX_IMP_PULSE_WIND,GetLocation(OBJECT_SELF), 1, 0.0f, 2.0f));
    DelayCommand(2.0,TLVFXPillar(VFX_IMP_PULSE_WIND,GetLocation(OBJECT_SELF), 1, 0.0f, 1.0f));
    while(oTarget != OBJECT_INVALID)
     {
      if(GetIsDead(oTarget)==FALSE)
      {
       RemoveEffectsFromSpell(oTarget,88);
       RemoveEffectsFromSpell(oTarget,90);
       DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
       DelayCommand(2.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisCaster, lTarget));
      }
     oTarget = GetNextObjectInShape(SHAPE_SPHERE,nRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
     }
}


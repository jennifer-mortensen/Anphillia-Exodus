#include "NW_I0_GENERIC"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    vector vHeight = GetPosition(OBJECT_SELF);

    object oScroll = GetSpellCastItem();
    if(oScroll != OBJECT_INVALID)
    {
        SendMessageToPC(OBJECT_SELF,"<c¥¥¥>[Server] You cannot use this spell from an item.</c>");
        return ;
    }

    string sAreaTag = GetTag(GetArea(OBJECT_SELF));    //J. Persinne; needed for our workaround to affect all targets within range on the walls of Suman/Rustin if the
    vector vCasterPosition = GetPosition(OBJECT_SELF); //caster is on the walls.
    vector vTargetPosition;
    int nCheckLineOfSight;
    if((sAreaTag == "SUMAN_VALLEY" || sAreaTag == "RUSTIN_ROAD") && vCasterPosition.z >= 9.0)
        nCheckLineOfSight = FALSE;
    else
        nCheckLineOfSight = TRUE;

    float nDuration = 7.5;
    float nRadius = 43.0;
    location lSpell = GetSpellTargetLocation();
    int iTimer = GetLocalInt(OBJECT_SELF, "FocusSpell2");

    if (iTimer == TRUE)
     {
    FloatingTextStringOnCreature("<cðøþ>*No School focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now. The spell is lost.</c>");
    return;
     }
    else
    DelayCommand(1.0, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(1.0, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Transmutation Focus is lost.</c>"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
    EffectVisualEffect(VFX_FNF_TIME_STOP), OBJECT_SELF );
    SetLocalInt(OBJECT_SELF, "FocusSpell2", TRUE);
    DelayCommand(33.0, DeleteLocalInt(OBJECT_SELF, "FocusSpell2"));
    DelayCommand(33.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    object oTarget;
    if(nCheckLineOfSight == TRUE)
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE,nRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
    else
    {
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE,nRadius,lSpell,FALSE,OBJECT_TYPE_CREATURE);
        vTargetPosition = GetPosition(oTarget);
    }

    effect eDexFix = EffectAbilityIncrease(ABILITY_DEXTERITY, 1);
    while( oTarget != OBJECT_INVALID )
    {
      if( GetHasEffect(EFFECT_TYPE_CUTSCENE_PARALYZE,oTarget) == FALSE && oTarget != OBJECT_SELF )
        {
        if((nCheckLineOfSight == TRUE) || (nCheckLineOfSight == FALSE && LineOfSightObject(OBJECT_SELF, oTarget)) || (nCheckLineOfSight == FALSE && vTargetPosition.z >= 9.0))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget,nDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_PARALYZE_HOLD),oTarget,nDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oTarget,nDuration);
            DelayCommand(nDuration, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDexFix, oTarget, 0.5));
        }
       }
    if(nCheckLineOfSight == TRUE)
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,nRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
    else
    {
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,nRadius,lSpell,FALSE,OBJECT_TYPE_CREATURE);
        vTargetPosition = GetPosition(oTarget);
    }
    }
}



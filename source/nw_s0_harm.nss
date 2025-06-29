#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDamage, nHeal;
    int nMetaMagic = GetMetaMagicFeat();
    int nTouch = TouchAttackMelee(oTarget);
    effect eVis = EffectVisualEffect(246);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eHeal, eDam;
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE){return;}
    //Check that the target-self is undead
    if (GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD && oTarget==OBJECT_SELF)
    {
        int iTimer = GetLocalInt(OBJECT_SELF, "selfharm");
        int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
        if (iTimer == TRUE)
        {
        FloatingTextStringOnCreature("<c ее>*No Self Harm focus!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
        }
        if (iTimer == FALSE)
        {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Self Harm Focus is lost.</c>"));
        nHeal = 250 + GetHitDice(OBJECT_SELF);
        eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, FALSE));
        SetLocalInt(OBJECT_SELF, "selfharm", TRUE);
        DelayCommand(240.0, DeleteLocalInt(OBJECT_SELF, "selfharm"));
        DelayCommand(240.0, FloatingTextStringOnCreature("<c ее>*Self Harm Focus Regained!</c>*",OBJECT_SELF,FALSE));
        }
    }
    //if undead
    else if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
        {
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM,FALSE));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
          eHeal = EffectHeal(250);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
    //if hostile living
    else if(!MothGetIsFortAlly(oTarget)&&
         GetRacialType(oTarget)!=RACIAL_TYPE_UNDEAD&&
         GetRacialType(oTarget)!=RACIAL_TYPE_CONSTRUCT)
    {
        if (nTouch != FALSE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM));
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                nDamage = GetCurrentHitPoints(oTarget)*2/3;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = GetCurrentHitPoints(oTarget)*2/3;
                }
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF))
                  {
                     nDamage = nDamage/2;
                  }
                eDam = EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE);
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}

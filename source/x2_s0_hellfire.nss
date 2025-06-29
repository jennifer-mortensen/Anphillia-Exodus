//Aura of hellfire
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    object oTarget;
    effect eVisual = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eImpacta = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    effect eImpactb = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eImpactc = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eAttack = EffectAbilityIncrease(ABILITY_CHARISMA,4);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,20);
    effect eSave = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_ORANGE);
    effect eImpact = EffectLinkEffects(eImpacta,eImpactb);
    eImpact = EffectLinkEffects(eImpact,eImpactc);
    effect eLink = EffectLinkEffects(eDur, eSave);
    eLink = EffectLinkEffects(eLink, eFire);
    effect eLink2 = EffectLinkEffects(eVisual, eDur);
    eLink2 = EffectLinkEffects(eLink2, eAttack);
    eLink2 = EffectLinkEffects(eLink2, eFire);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, OBJECT_SELF, TurnsToSeconds(nDuration));
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) ||
           GetIsReactionTypeNeutral(oTarget) && oTarget != OBJECT_SELF)
        {
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            fDelay = GetRandomDelay(0.4, 1.1);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 761, FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
/*
#include "x2_inc_spellhook"
//Function called to remove the AOE effect when it is dead, since the normal
//AOE onExit script is disabled against the creator of the effect
//VvVvV This whole function has been added by Rabidness VvVvV
void delayDispell( object oTarget )
{
    effect eAOE;
    if(GetHasSpellEffect(761, oTarget))
    {
        //Search through the valid effects on the target.
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE))
        {
            //If the effect was created by the AOE then remove it
            if(GetEffectSpellId(eAOE) == 761)
            {
                RemoveEffect(oTarget, eAOE);
            }
            //Get next effect on the target
            eAOE = GetNextEffect(oTarget);
        }
    }
    DeleteLocalObject( oTarget , "oProtFireSource" );
}

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_UNEARTHLY,"x2_s0_hellfirea","x2_s0_hellfireb","x2_s0_hellfirec");
    effect eEvila = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eEvilb = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eEvil = EffectLinkEffects(eEvila,eEvilb);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA,4);
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 761, FALSE));

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCha, OBJECT_SELF, TurnsToSeconds(nDuration));
    //VvVvV Rabidness additions VvVvV
    SetLocalObject( oTarget , "oProtFireSource" , oTarget );
    DelayCommand( TurnsToSeconds(nDuration) , delayDispell( oTarget ) );
}

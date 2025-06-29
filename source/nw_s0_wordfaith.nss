#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "_inc_subrace"

//J. Persinne, July 23 2009; Nameless Light now provides partial immunity ala true seeing.
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }
        object oTarget;
        int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
        effect eBlind = EffectBlindness();
        effect eStun = EffectStunned();
        effect eConfuse = EffectConfused();
        effect eDeath = EffectDeath();
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eSmite = EffectVisualEffect(VFX_FNF_WORD);
        effect eSonic = EffectVisualEffect(VFX_IMP_SONIC);
        effect eUnsummon =  EffectVisualEffect(VFX_IMP_UNSUMMON);
        effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eKill;
        effect eKillVisual1 = EffectVisualEffect(VFX_IMP_DEATH_L);
        effect eKillVisual2 = EffectVisualEffect(VFX_IMP_DEATH);
        effect eKillVisual = EffectLinkEffects(eKillVisual1,eKillVisual2);
        effect eLink;
        int nHD;
        float fDelay;
        int nDuration = nCasterLevel / 2;
        //Apply the FNF VFX impact to the target location
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmite, GetSpellTargetLocation());
        //Get the first target in the spell area
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget))
        {
            //Make a faction check
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
                fDelay = GetRandomDelay(0.5, 2.0);
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WORD_OF_FAITH));
                //Make SR check
                if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSonic, oTarget);
                    if (GetIsObjectValid(GetMaster(oTarget)))
                    {
                        if (GetAssociateType(oTarget) == ASSOCIATE_TYPE_SUMMONED)
                        {
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eUnsummon, oTarget));
                            if(GetHasSpellEffect(SPELL_TRUE_SEEING, oTarget)||GetHasSpellEffect(765, oTarget)||GetHasEffect(EFFECT_TYPE_TRUESEEING,oTarget)||GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget), ITEM_PROPERTY_TRUE_SEEING))
                            {
                                eKill  = EffectDamage(GetMaxHitPoints(oTarget)/2);
                            }
                            else
                            {
                                eKill  = EffectDamage(GetCurrentHitPoints(oTarget)+10);
                            }
                             DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                             DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKillVisual, oTarget));

                         }
                    }
                    else
                    {
                        //Check the HD of the creature
                        nHD = GetHitDice(oTarget);
                        //J. Persinne; creatures with planar vulnerabilties now take 1d6 damage per 4 caster levels.
                        /*if(GetIsPlanarVulnerable(oTarget))
                        {
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6(nCasterLevel / 4)), oTarget);
                        } */

                        if(GetHasSpellEffect(SPELL_TRUE_SEEING, oTarget)||GetHasSpellEffect(765, oTarget)||GetHasEffect(EFFECT_TYPE_TRUESEEING,oTarget)||GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget), ITEM_PROPERTY_TRUE_SEEING))
                        {
                            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                            {
                                eLink = EffectLinkEffects(eBlind, eDur);
                                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(nDuration)));
                            }
                        }
                        //Apply the appropriate effects based on HD
                        else if (nHD >= 12)
                        {
                            eLink = EffectLinkEffects(eBlind, eDur);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else if (nHD >= 8 && nHD < 12)
                        {
                            eLink = EffectLinkEffects(eStun, eMind);
                            eLink = EffectLinkEffects(eLink, eDur);
                            eLink = EffectLinkEffects(eLink, eBlind);

                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else if (nHD > 4 && nHD < 8)
                        {
                            eLink = EffectLinkEffects(eStun, eMind);
                            eLink = EffectLinkEffects(eLink, eDur);
                            eLink = EffectLinkEffects(eLink, eConfuse);
                            eLink = EffectLinkEffects(eLink, eBlind);

                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                        }
                        else
                        {
                           if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
                           {
                                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                           }
                           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                        }
                    }
                }
            }
            //Get the next target in the spell area
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        }
}

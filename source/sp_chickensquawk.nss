/*
Chickens Squawk
Spell level: Wizard/Sorcerer 7
Innate level: 7
School: transmutation
Descriptor: N/A
Components: verbal, somatic
Range: medium
Area of effect: single target
Duration: 1d4+2 Rounds
Save: fortitude negates
Spell resistance: yes
Description: The target is turned into a chicken.
*/

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();

    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
        return;

    if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_CHICKEN) //If the target has this spell effect, we don't want to reapply it.
    {                                                          //Unfortunately, checking spell ID won't work in this case, but an appearance check is sufficient.
        FloatingTextStrRefOnCreature(100775, OBJECT_SELF, FALSE);
        return;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL))
            {
                if(!GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS))
                {
                    MothRemovePolymorph(oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget);
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectPolymorph(ANPH_POLYMORPH_TYPE_CHICKEN, TRUE), oTarget, RoundsToSeconds(d4() + 2)));
                    if(GetIsPC(oTarget)) //AI responds poorly to action cancels; cancel only on PCs.
                        DelayCommand(0.5, AssignCommand(oTarget, ClearAllActions()));
                    DelayCommand(0.5, AssignCommand(oTarget, PlaySound("c_chicken_atk1")));
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDazed(), oTarget); //Does nothing except spit out the "target is immune to mind affecting spells" message.
                }
            }
            else
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE), oTarget);
        }
    }
}

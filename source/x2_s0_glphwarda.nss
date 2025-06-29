#include "x0_i0_spells"
#include "moth_inc_spells"

void TriggerGlyph(object oGlyph);

void main()
{
    object oTarget  = GetEnteringObject();
    object oGlyph = GetAreaOfEffectCreator(OBJECT_SELF);
    object oCreator = GetLocalObject(oGlyph, "oCaster") ;
    int nGlyphTriggered;

    if (!GetIsObjectValid(oGlyph) || !GetIsObjectValid(oCreator)) // the placeable or creator is no longer there
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    nGlyphTriggered = GetLocalInt(OBJECT_SELF, "nGlyphTriggered");

    if (!nGlyphTriggered && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCreator))
    {
        SetLocalInt(OBJECT_SELF, "nGlyphTriggered", TRUE);
        SetLocalObject(oGlyph, "oTarget", oTarget);

        effect eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
        int nMetaMagic = GetLocalInt(OBJECT_SELF, "nMetaMagic");

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        TriggerGlyph(oGlyph);

        DestroyObject(oGlyph, 0.5);
        DestroyObject(OBJECT_SELF, 1.0);
    }
}

void DoDamage(int nDamage, object oTarget)
{
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
    if(nDamage > 0)
    {
        //Apply VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
}

void TriggerGlyph(object oGlyph)
{
    //Declare major variables
    object oCreator = GetLocalObject(oGlyph,"oCaster");
    object oTarget = GetLocalObject(oGlyph, "oTarget");
    effect eDur = EffectVisualEffect(445);
    effect eExplode = EffectVisualEffect(459);
    int nDamage;
    int nDamageDice;
    int nDC = GetLocalInt(oGlyph, "nDC");
    int nCasterLevel = GetLocalInt(oGlyph, "nCasterLevel");
    int nIsPC = FALSE;
    int nMetaMagic = GetLocalInt(oGlyph, "nMetaMagic");
    int nFirstTarget = TRUE;
    location lTarget = GetLocation(oGlyph);
    string sFeedback = "<cfþ >Targets Affected: </c>";

    if (!GetIsObjectValid(oCreator))
    {
        DestroyObject(oGlyph);
        return;
    }

    if(GetIsPC(oCreator))
        nIsPC = TRUE;

    nDamageDice = nCasterLevel / 2;

    if (nDamageDice > 10)
        nDamageDice = 10;
    else if (nDamageDice < 1)
        nDamageDice = 1;
    if(nCasterLevel > 20)
        nDamageDice += (nCasterLevel - 20) / 3;

    if(nIsPC) //PCs receive feedback on who was affected.
    {
        DelayCommand(0.1, FloatingTextStringOnCreature("*Glyph of Warding Triggered!*", oCreator, FALSE));
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Cycle through the targets in the explosion area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCreator))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCreator, 549));
            //Make SR check
            if (!MyResistSpell(oCreator, oTarget))
            {
                if(nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nDamageDice * 8;
                }
                else
                {
                    nDamage = d8(nDamageDice);
                    if(nMetaMagic == METAMAGIC_EMPOWER)
                    {
                        nDamage = nDamage + (nDamage / 2);
                    }
                }
                //Change damage according to Reflex, Evasion and Improved Evasion
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_SONIC, oCreator);
                AssignCommand(oCreator, DoDamage(nDamage,oTarget));
                if(nIsPC) //Provide feedback that this target was affected.
                {
                    if(!nFirstTarget)
                    {
                        sFeedback += ", ";
                    }
                    sFeedback += GetName(oTarget);
                    nFirstTarget = FALSE;
                }
            }
        }
        //Get next target in the sequence
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
    if(nFirstTarget == TRUE)
        sFeedback += "None";
    sFeedback += ".";
    if(nIsPC) //Send the feedback.
    {
        DelayCommand(0.11, SendMessageToPC(oCreator, sFeedback));
    }
}

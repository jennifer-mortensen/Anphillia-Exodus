//Glyph of Warding
//Spell level: 3
//Innate level: 3
//School: abjuration
//Descriptor: sonic
//Components: verbal, somatic
//Range: short (8 meters)
//Area of effect: large (5 meter radius)
//Duration: 1 turn / level
//Save: reflex 1/2
//Spell resistance: yes
//
//Description: The caster creates a small, magical zone that can detect the passage
//of enemy creatures. When the field is activated, it explodes, doing: 1d8 points of
//sonic damage per two caster levels to all enemies within the area of effect. (To
//a maximum of 10d8 at 20). An extra 1d8 / 3 epic caster levels of damage applies.
//With a reflex save for half. In addition, the caster receives feedback for each
//target affected. This spell cannot be cast twice in the same location.

#include "x2_inc_spellhook"
#include "moth_inc"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    location lTarget = GetSpellTargetLocation();
    object oGlyph;

    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF, lTarget, SHAPE_SPHERE, 5.0))
    {
         FloatingTextStringOnCreature("<cеее>*You cannot apply these two spells at one location!*</c>", OBJECT_SELF, FALSE);
         return;
    }

   oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "x2_plc_glyph", lTarget);

    //Store caster information.
    SetLocalObject(oGlyph, "oCaster", OBJECT_SELF);
    SetLocalInt(oGlyph, "nCasterLevel", MothGetCasterLevel(OBJECT_SELF));
    SetLocalInt(oGlyph, "nMetaMagic", GetMetaMagicFeat());
    SetLocalInt(oGlyph, "nDC", MothDC());
    SetLocalInt(oGlyph, "nRestCount", GetLocalInt(OBJECT_SELF, "REST_COUNT"));

    //Force first heartbeat in order to handle initialization.
    ExecuteScript("x2_o0_glyphhb", oGlyph);
}




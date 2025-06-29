#include "x2_inc_switches"

/*
    Heartbeat for glyph of warding object

    Short rundown:

    Casting "glyph of warding" will create a GlyphOfWarding
    object from the palette and store all required variables
    on that object. You can also manually add those variables
    through the toolset.

    On the first heartbeat, the glyph creates the glyph visual
    effect on itself for the duration of the spell.

    Each subsequent heartbeat the glyph checks if the effect
    is still there. If it is no longer there, it has either been
    dispelled or removed, and the glyph will terminate itself.

    Also on the first heartbeat, this object creates an AOE object
    around itself, which, when getting the OnEnter Event from a
    Creature Hostile to the player, will  signal User Defined Event
    2000 to the glyph placeable which will fire the spell
    stored on a variable on it self on the intruder

    Note that not all spells might work because this is a placeable
    object casting them, but the more populare ones are working.

    The default spell cast is id 764, which is the script for
    the standard glyph of warding.

    Check the comments on the Glyph of Warding object on the palette
    for more information
*/

void main()
{
    object oCaster = GetLocalObject(OBJECT_SELF, "oCaster");
    int nCasterRestCount = GetLocalInt(oCaster, "REST_COUNT");
    int nRestCount = GetLocalInt(OBJECT_SELF, "nRestCount");
    if(!GetIsObjectValid(oCaster) || nCasterRestCount > nRestCount)
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    int nSetup = GetLocalInt(OBJECT_SELF, "nGlyphInitialized");

    if (!nSetup)
    {
        effect eAOE = EffectAreaOfEffect(AOE_PER_GLYPH_OF_WARDING, "x2_s0_glphwarda", "sp_glyphhb", "****");
        int nCasterLevel = GetLocalInt(OBJECT_SELF, "nCasterLevel");
        int nMetaMagic = GetLocalInt(OBJECT_SELF, "nMetaMagic");
        int nDuration = nCasterLevel / 2;

        if (nMetaMagic == METAMAGIC_EXTEND)
        {
           nDuration *= 2;
        }

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING), OBJECT_SELF, TurnsToSeconds(nDuration));
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, GetLocation(OBJECT_SELF), TurnsToSeconds(nDuration));

        SetLocalInt(OBJECT_SELF, "nGlyphInitialzed", TRUE);
    }
    else
    {
        int nDestroySelf = TRUE;
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(eEffect) && nDestroySelf == TRUE)
        {
            if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT && GetEffectCreator(eEffect) == OBJECT_SELF)
            {
                nDestroySelf = FALSE;
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }

        if (nDestroySelf)
        {
            DestroyObject(OBJECT_SELF);
            return;
        }
    }

}

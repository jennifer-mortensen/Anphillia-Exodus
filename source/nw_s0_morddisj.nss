void StripEffects(int nNumber, object oTarget);
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (!MothDecreaseOnHitSpellChance())
    {
        return;
    }
    effect   eVis        = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect   eImpact     = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    object   oTarget     = GetSpellTargetObject();
    location lLocal      = GetSpellTargetLocation();
    int      nCasterLevel= MothGetCasterLevel(OBJECT_SELF);
    //TLVFXPillar(VFX_IMP_AC_BONUS,GetLocation(OBJECT_SELF), 2, 0.0f, 5.0f);
    if(!GetIsPC(OBJECT_SELF))
    {
      nCasterLevel=1;
    }
    if (GetIsObjectValid(oTarget))
    {
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact,TRUE,TRUE);
    }
    else
    {
        float fDelay1 = GetDistanceBetweenLocations(lLocal, GetLocation(OBJECT_SELF))/20;
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLocal);
        TLVFXPillar(VFX_FNF_DISPEL_DISJUNCTION,lLocal, 1, fDelay1, 5.0f, 1.5f);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE );
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                spellsDispelAoE(oTarget, OBJECT_SELF,nCasterLevel);

            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            }
            else
            {
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE,TRUE);
            }

           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }
}


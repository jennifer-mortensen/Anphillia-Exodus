#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
#include "_inc_gen"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    object    oTarget      = GetSpellTargetObject();

    //J. Persinne; Rakshasa True Seeing Handling
    if(oTarget == OBJECT_SELF && (GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_RAKSHASA_MALE) || GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_RAKSHASA_FEMALE)))
    {
        //Timelock Handling
        int iTimer = GetLocalInt(OBJECT_SELF, "RAKSHASA_EYE_TIMELOCK");
        if (iTimer == TRUE)
        {
            FloatingTextStringOnCreature("<c ее>*No Rakshasa True Seeing Focus!*</c>",OBJECT_SELF,FALSE);
            SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
            return;
        }
        if (iTimer == FALSE)
        {
            DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
            DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Rakshasa's True Seeing focus is lost!</c>"));
            SetLocalInt(OBJECT_SELF, "RAKSHASA_EYE_TIMELOCK", TRUE);
            DelayCommand(330.0, DeleteLocalInt(OBJECT_SELF, "RAKSHASA_EYE_TIMELOCK"));
            DelayCommand(330.0, FloatingTextStringOnCreature("<c ее>*Rakshasa True Seeing focus Regained!*</c>",OBJECT_SELF,FALSE));
        }
        //---End Timelock Handling

        int nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER);
        int nDuration = 5 + nShifter / 2;
        effect eVFX = SupernaturalEffect(EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT));
        object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, OBJECT_SELF, RoundsToSeconds(nDuration));
        AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyTrueSeeing(), oHide, RoundsToSeconds(nDuration));

        return;
    }
    //---End Rakshasa True Seeing Handling

    if (!MothDecreaseOnHitSpellChance())
    {
        return;
    }

    effect    eVis         = EffectVisualEffect(VFX_IMP_BREACH);
    effect    eImpact      = EffectVisualEffect(VFX_FNF_DISPEL);
    location  lLocal       = GetSpellTargetLocation();
    int       nCasterLevel = MothGetCasterLevel(OBJECT_SELF);

    if(!GetIsPC(OBJECT_SELF))
    {
      nCasterLevel=1;
    }
    if (GetIsObjectValid(oTarget))
    {
         spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact);
    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE );
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                spellsDispelAoE(oTarget, OBJECT_SELF, nCasterLevel);
            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            }
            else
            {
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE);
            }

           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }
}




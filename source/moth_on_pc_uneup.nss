#include "x2_inc_switches"
#include "x3_inc_horse"
#include "_inc_items"
#include "moth_inc_spells"
#include "tk_hips_inc"

void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC = GetPCItemLastUnequippedBy();
    // Mounted benefits control

    if (GetWeaponRanged(oItem))
    {
        DeleteLocalInt(oPC,"bX3_M_ARCHERY");
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    if(GetBaseItemType(oItem) == BASE_ITEM_CREATUREITEM)
    {
        string sTag = GetTag(oItem);
        if(sTag == "SHF_DEATH_SLAAD_PROPERTIES") //The player unshifted from death slaad shape.  Let's restore their previous movement speed.
        {
            int nAppearance = GetLocalInt(oPC, "DEFAULT_APPEARANCE"); //J. Persinne; restore the player's default appearance.
            SetCreatureAppearanceType(oPC, nAppearance);
            return;
        }
        else if(sTag == "SHF_RAKSHASA_PROPERTIES") //The player unshifted from rakshasa shape. Remove true seeing VFX if they have it.
        {
            effect eEffect = GetFirstEffect(oPC);
            while(GetIsEffectValid(eEffect))
            {
                if(GetEffectSpellId(eEffect) == SPELL_DISPEL_MAGIC)
                {
                    RemoveEffect(oPC, eEffect);
                    return;
                }
                eEffect = GetNextEffect(oPC);
            }
            return;
        }
        else if(sTag == "SHF_EPIC_KOBOLD_COMM_PROPERTIES" || //Update HiPS.
            sTag == "SHF_KOBOLD_COMMANDO_PROPERTIES" ||
            sTag == "SHF_SPECTRE_PROPERTIES")
        {
            DelayCommand(0.1, TK_HiPS_OnFeatChange(oPC));
            return;
        }

        string sBlueprint = GetResRef(oItem);

        if(sBlueprint == "shapeshifterred" || sBlueprint == "shapeshifterfir" || sBlueprint == "shapeshifterbal" || sBlueprint == "shapeshiftersla" || sBlueprint == "irongolem")
        {
            //Shapechange Spell hide; clean the old hide to prevent stacking properties exploits.
            DelayCommand(0.5, MothAddNewSkin(oPC));
            DelayCommand(1.0, MothUpdateHideFeats(oPC, FALSE));
        }
    }
    else if(GetAppearanceType(oPC) <= 6)
        HandleItemDamageImmunities(oPC, oItem, FALSE);
}

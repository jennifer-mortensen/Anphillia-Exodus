#include "x2_inc_spellhook"
#include "_inc_xp"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCurrentAbilityUses = GetLocalInt(OBJECT_SELF, "CURRENT_LIGHT_CASTINGS");

    if(nCurrentAbilityUses > 0)
    {
        nCurrentAbilityUses--;
        SetLocalInt(OBJECT_SELF, "CURRENT_LIGHT_CASTINGS", nCurrentAbilityUses);
        SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You now have " + IntToString(nCurrentAbilityUses) + " use(s) of light left.</c>");
    }
    else
    {
        FloatingTextStringOnCreature("<cþŒ >*You must rest in order to replenish your racial light spell(s) per day.*</c>", OBJECT_SELF, FALSE);
        return;
    }

    int nDuration = GetECLAdjustedHitDice(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();

    int nMetaMagic;
    if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM && ! CIGetIsCraftFeatBaseItem(oTarget))
    {
        if (!IPGetIsItemEquipable(oTarget))
        {
             FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
            return;
        }
        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_WHITE);

        if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
        {
            IPRemoveMatchingItemProperties(oTarget,ITEM_PROPERTY_LIGHT,DURATION_TYPE_TEMPORARY);
        }
        //nDuration = GetCasterLevel(OBJECT_SELF);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(nDuration));
    }
    else
    {
        effect eVis = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        //nDuration = GetCasterLevel(OBJECT_SELF);

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    }

}


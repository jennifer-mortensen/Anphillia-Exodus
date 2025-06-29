//Applies light blindness effects to oPC.
void ApplyLightBlindnessEffects(object oPC);
//Applies special subrace feats to oPC's hide.
void ApplySubraceFeats(object oPC);
//Returns TRUE if oPC has a subrace that suffers from light blindness.
int GetIfLightBlindnessApplies(object oPC);
//Returns TRUE if oPC is currently affected by light blindness.
int GetIfLightBlindnessHasBeenApplied(object oPC);
//Returns TRUE if oPC is in an exterior area and it is currently daytime (hours 6-17).
int GetIsInLightBlindnessArea(object oPC);
//Applies light blindness effects to oPC if he mets to conditions for light blindness. Call this function on transition and when time changes to day to night, and vice versa.
void HandleLightBlindness(object oPC);
//Refreshes oPC's special subrace spells.
void RefreshSubraceSpells(object oPC);
//Removes light blindness effects from oPC
void RemoveLightBlindnessEffects(object oPC);

//Applies light blindness effects to oPC.
void ApplyLightBlindnessEffects(object oPC)
{
    object oLightBlindnessApplier = GetObjectByTag("LIGHT_BLINDNESS_APPLIER");
    SetLocalObject(oLightBlindnessApplier, "OBJECT_TO_AFFECT", oPC);
    ExecuteScript("exe_lightblind", oLightBlindnessApplier); //We must execute light blindness from the light applier in order for it to be read as the effect creator.
}

//Applies special subrace feats to oPC's hide.
void ApplySubraceFeats(object oPC)
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    if(!GetIsObjectValid(oHide))
        return;

    string sSubrace = GetSubRace(oPC);
    if(sSubrace == "")
        return;

    if(sSubrace == "Drow")
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(55), oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide); //Drow have darkvision.
    }
    else if(sSubrace == "Half-Drow")
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide); //Half-Drow have darkvision.
    }
    else if(sSubrace == "Deep Halfling")
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide); //Deep Halflings have darkvision.
    }
    else if(sSubrace == "Aasimar")
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(56), oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide); //Aaasimar have darkvision.
    }
    else if(sSubrace == "Tiefling")
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(55), oHide); //<-- dm tool 1, which handles darkness
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide); //Tieflings have darkvision.
    }
}

//Returns TRUE if oPC has a subrace that suffers from light blindness.
int GetIfLightBlindnessApplies(object oPC)
{
    int nLightBlindness = GetLocalInt(oPC, "SUFFERS_FROM_LIGHT_BLINDNESS");
    if(nLightBlindness)
        return TRUE;
    return FALSE;
}

//Returns TRUE if oPC is currently affected by light blindness.
int GetIfLightBlindnessHasBeenApplied(object oPC)
{
    int nLightBlindness = GetLocalInt(oPC, "LIGHT_BLINDNESS_APPLIED");
    if(nLightBlindness)
        return TRUE;
    return FALSE;
}

//Returns TRUE if oPC is in an exterior area and it is currently daytime (hours 6-17).
int GetIsInLightBlindnessArea(object oPC)
{
    object oArea = GetArea(oPC);
    if(GetIsDay() && !GetIsAreaInterior(oArea))
        return TRUE;
    return FALSE;
}

//Applies light blindness effects to oPC if he mets to conditions for light blindness. Call this function on transition and when time changes to day to night, and vice versa.
void HandleLightBlindness(object oPC)
{
    if(!GetLocalInt(oPC, "SUFFERS_FROM_LIGHT_BLINDNESS"))
        return;
    RemoveLightBlindnessEffects(oPC);
    if(GetIfLightBlindnessApplies(oPC) && GetIsInLightBlindnessArea(oPC))
        ApplyLightBlindnessEffects(oPC);
}

//Refreshes oPC's special subrace spells.
void RefreshSubraceSpells(object oPC)
{
    int nDarknessCastings = GetLocalInt(oPC, "DARKNESS_CASTINGS_PER_DAY");
    int nLightCastings = GetLocalInt(oPC, "LIGHT_CASTINGS_PER_DAY");

    if(nDarknessCastings)
    {
        SetLocalInt(oPC, "CURRENT_DARKNESS_CASTINGS", nDarknessCastings);
    }
    if(nLightCastings)
    {
        SetLocalInt(oPC, "CURRENT_LIGHT_CASTINGS", nLightCastings);
    }
}

//Removes light blindness effects from oPC
void RemoveLightBlindnessEffects(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    object oEffectCreator = GetEffectCreator(eEffect);

    while(GetIsEffectValid(eEffect))
    {
        if(GetTag(oEffectCreator) == "LIGHT_BLINDNESS_APPLIER")
            RemoveEffect(oPC, eEffect);
        eEffect = GetNextEffect(oPC);
        oEffectCreator = GetEffectCreator(eEffect);
    }
    DeleteLocalInt(oPC, "LIGHT_BLINDNESS_APPLIED");
}

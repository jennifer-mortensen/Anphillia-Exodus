void main()
{
    object oPC = GetLocalObject(OBJECT_SELF, "OBJECT_TO_AFFECT");
    string sSubrace = GetSubRace(oPC);
    effect eAbilityPenalty;

    if(sSubrace == "Duergar" || sSubrace == "Whisper Gnome" || sSubrace == "Wood Elf")
        eAbilityPenalty = EffectAbilityDecrease(ABILITY_CHARISMA, 2);
    else if(sSubrace == "Wild Dwarf")
         eAbilityPenalty = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 2);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eAbilityPenalty), oPC);
    DeleteLocalObject(OBJECT_SELF, "OBJECT_TO_AFFECT");
}

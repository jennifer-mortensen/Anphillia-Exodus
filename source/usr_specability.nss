//J. Persinne;
//This User Defined Event has a Post Spawn hook that reads an integer variable from the caller, "CREATURE_SPECIAL_ABILITY", and instantly casts the spell corresponding to its value
//on the caller.  The intent is for this script to be used with custom spell-like abilities.
void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if(nEvent == 1511) //Post Spawn Event
    {
        int nAbility = GetLocalInt(OBJECT_SELF, "CREATURE_SPECIAL_ABILITY");
        AssignCommand(OBJECT_SELF, ActionCastSpellAtObject(nAbility, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }
}

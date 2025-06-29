#include "_inc_spawn"

//J. Persinne; this script will read variables off of the creature to apply special effects and abilities. The spawn script must be configured to trigger the post
//spawn event for this script to work.  Read the entries in "_inc_spawn" for details.
void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if(nEvent == 1511) //Post Spawn Event
    {
        ApplySpawnInDamageBonuses();
        ApplySpawnInDamageImmunities();
        ApplySpawnInSpecialAbilities();
        ApplySpawnInVisualEffects();
    }
}

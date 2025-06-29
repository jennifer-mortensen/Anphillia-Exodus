void main()
{
   object oModule = GetModule();

   // GENERAL SETTINGS

   /* This sets the improved rest-script active or inactive.
   It is used to randomly teleport monsters that are in the area to a player
   that rests unguarded (= no other neutral/friendly creature near).
   NO creatures are created, if the area is empty, then resting is save */
   SetLocalInt(oModule, "ANPH_REST_SURPRISE_ACTIVE", FALSE);

   /* If Rest-Surprise is active, this sets the percentage chance that a
   player that rests alone attracts one or more monsters */
   SetLocalInt(oModule, "ANPH_REST_SURPRISE_CHANCE", 70);

   /* If Rest-Surprise is active, this sets the minimum number of creatures
   to jump to the player */
   SetLocalInt(oModule, "ANPH_REST_SURPRISE_MIN", 1);

   /* If Rest-Surprise is active, this sets the maximum number of creatures
   to jump to the player */
   SetLocalInt(oModule, "ANPH_REST_SURPRISE_MAX", 4);

   /* The fatigue script determines if a player is running for a long time
   and applies the "slow" effect depending on constitution of the player. */
   SetLocalInt(oModule, "ANPH_FATIGUE", FALSE);

   /* This sets racial restrictions for the factions on or off. The Drow faction
   always is restricted.
   If true, the following restrictions apply:
   Cleaven: no Half-Orcs
   Axfell: no Elves or Half-Elves */
   SetLocalInt(oModule, "ANPH_RACIAL_RESTRICTIONS", FALSE);

   /* This sets the alignment restrictions for the factions on or off.
   Drow Faction always is restricted.
   If true, the following restrictions apply:
   Cleaven: no Chaotic Evil
   Axfell: no Lawful Good */
   SetLocalInt(oModule, "ANPH_ALIGNMENT_RESTRICTIONS", FALSE);

   /* If set to TRUE, characters that don't kill things for a set amount of time
   gain RP XP automatically */
   SetLocalInt(oModule, "ANPH_ROLEPLAY_XP", FALSE);

   /* This specifies the number of beats a character has to remain non-killing
   to be awarded with XP */
   SetLocalInt(oModule, "ANPH_ROLEPLAY_INTERVAL", 5);

   /* This sets the base RP XP a character gains for being idle the set amount
   of time. A random of 10 and his level*2 is added to this value */
   SetLocalInt(oModule, "ANPH_ROLEPLAY_BASEXP", 200+d8(10));

   /* This sets the maximum amount of combat experience a character can recieve
   in a rest period. */
   SetLocalInt(oModule, "ANPH_MAX_XP_PER_REST", 5000);

   /* If this is set to FALSE, pickpocketed items do not drop on death */
   SetLocalInt(oModule, "ANPH_DROP_STOLEN_ITEMS_ON_DEATH", FALSE);

   // CnR SETTINGS

   /* This setting activates/deactivates CnR (Craftable natural Resources).
   Once turned on, it's a bad idea to turn it off again ;) */
   SetLocalInt(oModule, "ANPH_CNR_ACTIVE", FALSE);
   //SetLocalInt(oModule, "ANPH_CNR_ACTIVE", TRUE);

   /* This setting sets the maximum level attainable in CnR. If you want to set
   no limit, use 255 as the value */
   SetLocalInt(oModule, "ANPH_CNR_MAX_LEVEL", 60);

   // FACTION SETTINGS

   /* These settings set the factions joinable by players. If set to TRUE, the
   join portals will be in the initial dream area, if set to FALSE, the portals
   are created in another area (a DM could jump players there to have the
   faction invitational) */

   // Cleaven
   SetLocalInt(oModule, "FACTION_01_ACCESSIBLE_FOR_PLAYERS", TRUE);
   // Axfell
   SetLocalInt(oModule, "FACTION_02_ACCESSIBLE_FOR_PLAYERS", TRUE);
   // Ranzington
   SetLocalInt(oModule, "FACTION_03_ACCESSIBLE_FOR_PLAYERS", FALSE);
   // Drow
   SetLocalInt(oModule, "FACTION_04_ACCESSIBLE_FOR_PLAYERS", FALSE);
   // Shilar
   SetLocalInt(oModule, "FACTION_05_ACCESSIBLE_FOR_PLAYERS", FALSE);

   /* The relations between the factions are hardcoded, and are as follows:
   Cleaven: Dislike Axfell and Drow
   Axfell: Dislike Cleaven and Drow
   Ranzington: Dislike Drow
   Shilar: Dislike Drow
   Drow: Dislike all other factions */
}

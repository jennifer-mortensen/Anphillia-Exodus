void main()
{
   object oOwner = OBJECT_SELF;
   object oTarget = OBJECT_SELF;
   int nRandomDelay = d20(2);
   int nHBCount = GetLocalInt(oOwner, "MOTHSTRIKEHB");
   nHBCount++;
   SetLocalInt(oOwner, "MOTHSTRIKEHB", nHBCount);
   if(nHBCount > nRandomDelay)
   {
        int nSpell = SPELL_CALL_LIGHTNING;
        switch (Random(8))
        {
        case 0: nSpell = SPELL_BALAGARNSIRONHORN; break;
        case 1: nSpell = SPELL_GREAT_THUNDERCLAP; break;
        case 2: nSpell = SPELL_ICE_STORM; break;
        case 3: nSpell = SPELL_IMPLOSION; break;
        case 4: nSpell = SPELL_NATURES_BALANCE; break;
        case 5: nSpell = SPELL_MASS_BLINDNESS_AND_DEAFNESS; break;
        case 6: nSpell = SPELL_FLAME_STRIKE; break;
        case 7: nSpell = SPELL_HAMMER_OF_THE_GODS; break;
        }
        AssignCommand(oOwner, ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   }
}

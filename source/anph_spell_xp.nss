

int GetSpellXP (int nSpellID)
{

    switch (nSpellID)
    {
    case 439:       // SPELL_ELECTRIC_JOLT
    case 416:       // SPELL_FLARE
    case 417:       // SPELL_SHIELD
    case 189:       // SPELL_VIRTUE
    case 84:       // SPELL_HOLY_AURA
    case 166:       // SPELL_SLOW
    case 192:       // SPELL_WEB
    case 165:       // SPELL_SLEEP
    case 136:       // SPELL_PROTECTION__FROM_CHAOS
    case 137:       // SPELL_PROTECTION_FROM_ELEMENTS
    case 138:       // SPELL_PROTECTION_FROM_EVIL
    case 139:       // SPELL_PROTECTION_FROM_GOOD
    case 140:       // SPELL_PROTECTION_FROM_LAW
    case 155:       // SPELL_SCARE
    case 151:       // SPELL_RESISTANCE
    case 144:       // SPELL_RAY_OF_FROST
    case 0:       // SPELL_ACID_FOG
    case 4:       // SPELL_BESTOW_CURSE
    case 5:       // SPELL_BLADE_BARRIER
    case 6:       // SPELL_BLESS
    case 9:       // SPELL_BULLS_STRENGTH
    case 13:       // SPELL_CATS_GRACE
    case 10:       // SPELL_BURNING_HANDS
    case 15:       // SPELL_CHARM_MONSTER
    case 20:       // SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE
    case 21:       // SPELL_CLARITY
    case 32:       // SPELL_CURE_LIGHT_WOUNDS
    case 33:       // SPELL_CURE_MINOR_WOUNDS
    case 24:       // SPELL_COLOR_SPRAY
    case 26:       // SPELL_CONFUSION
    case 30:       // SPELL_CREATE_UNDEAD
    case 36:       // SPELL_DARKNESS
    case 37:       // SPELL_DAZE
    case 41:       // SPELL_DISPEL_MAGIC
    case 47:       // SPELL_ELEMENTAL_SHIELD
    case 49:       // SPELL_ENDURANCE
    case 50:       // SPELL_ENDURE_ELEMENTS
    case 46:       // SPELL_DOOM
    case 42:       // SPELL_DIVINE_POWER
    case 51:       // SPELL_ENERGY_DRAIN
    case 53:       // SPELL_ENTANGLE
    case 66:       // SPELL_GREASE
    case 48:       // SPELL_ELEMENTAL_SWARM
    case 64:       // SPELL_GHOUL_TOUCH
    case 102:       // SPELL_MAGE_ARMOR
    case 94:       // SPELL_LESSER_DISPEL
    case 103:       // SPELL_MAGIC_CIRCLE_AGAINST_CHAOS
    case 104:       // SPELL_MAGIC_CIRCLE_AGAINST_EVIL
    case 105:       // SPELL_MAGIC_CIRCLE_AGAINST_GOOD
    case 106:       // SPELL_MAGIC_CIRCLE_AGAINST_LAW
    case 115:       // SPELL_MELFS_ACID_ARROW
    case 107:       // SPELL_MAGIC_MISSILE
    case 142:       // SPELL_RAISE_DEAD
    case 69:       // SPELL_GREATER_PLANAR_BINDING
    case 91:       // SPELL_INVISIBILITY_PURGE
    case 92:       // SPELL_INVISIBILITY_SPHERE
    case 143:       // SPELL_RAY_OF_ENFEEBLEMENT
    case 101:       // SPELL_LIGHTNING_BOLT
    case 129:       // SPELL_POISON
    case 191:       // SPELL_WALL_OF_FIRE
    case 183:       // SPELL_SUNBEAM
    case 171:       // SPELL_STINKING_CLOUD
    case 131:       // SPELL_POWER_WORD_KILL
    case 132:       // SPELL_POWER_WORD_STUN
    case 89:       // SPELL_INCENDIARY_CLOUD
        return 2;

    case 167:       // SPELL_SOUND_BURST
    case 156:       // SPELL_SEARING_LIGHT
    case 62:       // SPELL_FREEDOM_OF_MOVEMENT
    case 163:       // SPELL_SILENCE
    case 119:       // SPELL_MINOR_GLOBE_OF_INVULNERABILITY
    case 141:       // SPELL_PROTECTION_FROM_SPELLS
    case 83:       // SPELL_HOLD_PERSON
    case 80:       // SPELL_HEALING_CIRCLE
    case 157:       // SPELL_SEE_INVISIBILITY
    case 118:       // SPELL_MIND_FOG
    case 117:       // SPELL_MIND_BLANK
    case 96:       // SPELL_LESSER_PLANAR_BINDING
    case 95:       // SPELL_LESSER_MIND_BLANK
    case 99:       // SPELL_LESSER_SPELL_MANTLE
    case 98:       // SPELL_LESSER_SPELL_BREACH
    case 97:       // SPELL_LESSER_RESTORATION
    case 90:       // SPELL_INVISIBILITY
    case 34:       // SPELL_CURE_MODERATE_WOUNDS
    case 3:       // SPELL_BARKSKIN
    case 11:       // SPELL_CALL_LIGHTNING
    case 8:       // SPELL_BLINDNESS_AND_DEAFNESS
    case 16:       // SPELL_CHARM_PERSON
    case 17:       // SPELL_CHARM_PERSON_OR_ANIMAL
    case 31:       // SPELL_CURE_CRITICAL_WOUNDS
    case 23:       // SPELL_CLOUDKILL
    case 27:       // SPELL_CONTAGION
    case 28:       // SPELL_CONTROL_UNDEAD
    case 29:       // SPELL_CREATE_GREATER_UNDEAD
    case 38:       // SPELL_DEATH_WARD
    case 40:       // SPELL_DISMISSAL
    case 43:       // SPELL_DOMINATE_ANIMAL
    case 44:       // SPELL_DOMINATE_MONSTER
    case 45:       // SPELL_DOMINATE_PERSON
    case 52:       // SPELL_ENERVATION
    case 54:       // SPELL_FEAR
    case 55:       // SPELL_FEEBLEMIND
    case 58:       // SPELL_FIREBALL
    case 59:       // SPELL_FLAME_ARROW
    case 60:       // SPELL_FLAME_LASH
    case 61:       // SPELL_FLAME_STRIKE
    case 65:       // SPELL_GLOBE_OF_INVULNERABILITY
    case 67:       // SPELL_GREATER_DISPELLING
    case 57:       // SPELL_FIRE_STORM
    case 78:       // SPELL_HASTE
    case 76:       // SPELL_HAMMER_OF_THE_GODS
    case 111:       // SPELL_MASS_CHARM
    case 113:       // SPELL_MASS_HASTE
    case 120:       // SPELL_GHOSTLY_VISAGE
    case 188:       // SPELL_VAMPIRIC_TOUCH
    case 145:       // SPELL_REMOVE_BLINDNESS_AND_DEAFNESS
    case 186:       // SPELL_TRUE_SEEING
    case 172:       // SPELL_STONESKIN
    case 121:       // SPELL_ETHEREAL_VISAGE
    case 160:       // SPELL_SHADOW_SHIELD
    case 127:       // SPELL_PHANTASMAL_KILLER
    case 81:       // SPELL_HOLD_ANIMAL
    case 125:       // SPELL_NEGATIVE_ENERGY_PROTECTION
    case 128:       // SPELL_PLANAR_BINDING
    case 168:       // SPELL_SPELL_RESISTANCE
    case 447:       // SPELL_ISAACS_LESSER_MISSILE_STORM
        return 4;

    case 440:       // SPELL_FIREBRAND
    case 82:       // SPELL_HOLD_MONSTER
    case 135:       // SPELL_PRISMATIC_SPRAY
    case 169:       // SPELL_SPELL_MANTLE
    case 88:       // SPELL_IMPROVED_INVISIBILITY
    case 74:       // SPELL_GREATER_STONESKIN
    case 114:       // SPELL_MASS_HEAL
    case 14:       // SPELL_CHAIN_LIGHTNING
    case 18:       // SPELL_CIRCLE_OF_DEATH
    case 19:       // SPELL_CIRCLE_OF_DOOM
    case 25:       // SPELL_CONE_OF_COLD
    case 35:       // SPELL_CURE_SERIOUS_WOUNDS
    case 39:       // SPELL_DELAYED_BLAST_FIREBALL
    case 56:       // SPELL_FINGER_OF_DEATH
    case 164:       // SPELL_SLAY_LIVING
    case 63:       // SPELL_GATE
    case 77:       // SPELL_HARM
    case 79:       // SPELL_HEAL
    case 87:       // SPELL_IMPLOSION
    case 154:       // SPELL_SANCTUARY
    case 134:       // SPELL_PREMONITION
    case 194:       // SPELL_WORD_OF_FAITH
    case 72:       // SPELL_GREATER_SPELL_BREACH
    case 73:       // SPELL_GREATER_SPELL_MANTLE
    case 110:       // SPELL_MASS_BLINDNESS_AND_DEAFNESS
    case 448:       // SPELL_ISAACS_GREATER_MISSILE_STORM
        return 7;


    case 173:       // SPELL_STORM_OF_VENGEANCE
    case 116:       // SPELL_METEOR_SWARM
    case 190:       // SPELL_WAIL_OF_THE_BANSHEE
    case 122:       // SPELL_MORDENKAINENS_DISJUNCTION
    case 193:       // SPELL_WEIRD
    case 185:       // SPELL_TIME_STOP
    case 153:       // SPELL_RESURRECTION
        return 10;


    case 495:       //SPELLABILITY_BREATH_PETRIFY
    case 496:       //SPELLABILITY_TOUCH_PETRIFY
    case 497:       //SPELLABILITY_GAZE_PETRIFY
        return 6;

    default:
        // just a guess..
        return 4;
    }
    return 0;
}



#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevelBonus = MothGetCasterLevel(OBJECT_SELF);
    int nSpellID = GetSpellId();
    switch (nSpellID)
    {
/*Minor*/     case 431: spellsInflictTouchAttack(d8(), nLevelBonus, 8+nLevelBonus, 246, VFX_IMP_HEALING_G, nSpellID); break;
/*Light*/     case 432: case 609: spellsInflictTouchAttack(d8(2), 25+nLevelBonus, 16+nLevelBonus, 246, VFX_IMP_HEALING_G, nSpellID); break;
/*Moderate*/  case 433: case 610: spellsInflictTouchAttack(d8(3), 30+nLevelBonus, 24+nLevelBonus, 246, VFX_IMP_HEALING_G, nSpellID); break;
/*Serious*/   case 434: case 611: spellsInflictTouchAttack(d8(4), 35+nLevelBonus, 32+nLevelBonus, 246, VFX_IMP_HEALING_G, nSpellID); break;
/*Critical*/  case 435: case 612: spellsInflictTouchAttack(d10(5), 40+nLevelBonus, 50+nLevelBonus, 246, VFX_IMP_HEALING_G, nSpellID); break;

    }
}

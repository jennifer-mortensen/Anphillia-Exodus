//#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_TailorRecipes()
{

//-------------------------------- CLOTHES -----------------------------------//

    ATS_Recipe_NewRecipe("Normal Clothes", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOTHES, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(10);
    ATS_Recipe_ClothsL(1, 100);

//-------------------------------- BELTS -------------------------------------//

    ATS_Recipe_NewRecipe("Lesser Belts", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 02);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(25);
    ATS_Recipe_ClothsM(1, 100);

//-------------------------------- GLOVES ------------------------------------//

    ATS_Recipe_NewRecipe("Lesser Gloves", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_GLOVES, 02);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsS(2, 100);

//-------------------------------- ARMORS ------------------------------------//

    ATS_Recipe_NewRecipe("Padded Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 02);
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Leather Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 01);
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Studded Leather Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 03);
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_ClothsL(2, 100);
    ATS_Recipe_AddMaterial("ATS_C_A901_N_COP", 10, 100);   // Copper Studs

    ATS_Recipe_NewRecipe("Hide Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 04);
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Monk's Outfits", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 05);
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

    ATS_Recipe_NewRecipe("Mage's Armors", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_ARMOR, 06);
    ATS_Recipe_SetMinSkill(10);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

//-------------------------------- DYES --------------------------------------//

    ATS_Recipe_NewRecipe("Make Dyes", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_Flowers(1, 100);

//-------------------------------- CLOTHS ------------------------------------//

    ATS_Recipe_NewRecipe("Make Small Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 97);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_SLH", 1); // Small Harden Hide
    ATS_Recipe_Dyes(1, 100);

    ATS_Recipe_NewRecipe("Make Medium Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 98);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_MLH", 1); // Medium Harden Hide
    ATS_Recipe_Dyes(1, 100);

    ATS_Recipe_NewRecipe("Make Large Cloths", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 99);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_LLH", 1); // Large Harden Hide
    ATS_Recipe_Dyes(1, 100);

//-------------------------------- BAGS --------------------------------------//

    ATS_Recipe_NewRecipe("Normal Bags", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BAGS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsM(1, 100);

//-------------------------------- CLOAKS ------------------------------------//

    ATS_Recipe_NewRecipe("Lesser Cloaks", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_CLOAKS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsL(2, 100);

//-------------------------------- BOOTS ------------------------------------//

    ATS_Recipe_NewRecipe("Lesser Boots", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BOOTS, 01);
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_ClothsS(2, 100);

//-------------------------------- CLOTH PADDING SOLD WITH BLACKSMITH --------//
// Need to modify Item's Blueprint ResRef and Tag to match... as well as to
// modify the ats_recipes where it is needed in armor creation

    ATS_Recipe_NewRecipe("Make Cloth Padding", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 02);
    ATS_Recipe_SetSingleType("ATS_C_T902_N_CLO");
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_MLH", 2); // Medium Harden Hide

//-------------------------------- CRAFTED STUDDED LEATHER ARMOR WITH TANNER -//
// Need to modify Item's Blueprint ResRef and Tag to match... as well as to
// modify the ats_recipes where it is needed in armor creation

    ATS_Recipe_NewRecipe("Crafted Studded Leather Armor", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_MISC, 03);
    ATS_Recipe_SetSingleType("ATS_C_T903_N_CLO");
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_C_L201_N_LLH", 2); // Large Harden Hides
    ATS_Recipe_AddMaterial("ATS_C_A901_N_COP", 10, 100);   // Copper Studs

}
//void main(){}

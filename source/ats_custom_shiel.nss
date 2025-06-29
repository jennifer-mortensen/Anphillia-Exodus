#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomShield()
{
//small shield
ATS_Recipe_NewRecipe("Small shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 67);
ATS_Recipe_SetMinSkill(10);
ATS_Recipe_SetMaxSkill(30);
ATS_Recipe_Ingots(4);
//Large shield
ATS_Recipe_NewRecipe("Large shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 68);
ATS_Recipe_SetMinSkill(40);
ATS_Recipe_SetMaxSkill(70);
ATS_Recipe_Ingots(7);
//Tower Shield
ATS_Recipe_NewRecipe("Tower Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 69);
ATS_Recipe_SetMinSkill(60);
ATS_Recipe_SetMaxSkill(90);
ATS_Recipe_Ingots(15);
//Young Druid Shield
ATS_Recipe_NewRecipe("Young Druid Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 21);
ATS_Recipe_SetSingleType("ATS_C_A221_N_COP");
ATS_Recipe_SetMinSkill(50);
ATS_Recipe_SetMaxSkill(55);
ATS_Recipe_AddMaterial("ATS_C_A267_E_COP",1,5);  //Exceptional Copper Small Shield
ATS_Recipe_AddMaterial("ATS_C_L102_N_SLH",1,50); //Tanned Small Black Leather
//Young Barbarian Shield
ATS_Recipe_NewRecipe("Young Barbarian Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 22);
ATS_Recipe_SetSingleType("ATS_C_A222_N_COP");
ATS_Recipe_SetMinSkill(50);
ATS_Recipe_SetMaxSkill(55);
ATS_Recipe_AddMaterial("ATS_C_A268_E_COP",1,5);  //Exceptional Copper Large Shield
ATS_Recipe_AddMaterial("ATS_C_L102_N_MLH",1,50); //Tanned Med. Black Leather
//Young Ranger Shield
ATS_Recipe_NewRecipe("Young Ranger Shield", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_SHIELD, 23);
ATS_Recipe_SetSingleType("ATS_C_A223_N_COP");
ATS_Recipe_SetMinSkill(55);
ATS_Recipe_SetMaxSkill(60);
ATS_Recipe_AddMaterial("ATS_C_A269_E_COP",1,5);  //Exceptional Copper Tower Shield
ATS_Recipe_AddMaterial("ATS_C_L102_N_LLH",1,50); //Tanned Lrg. Black Leather
}
//void main(){}

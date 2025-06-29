#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomBlunt()
{
//Mace
ATS_Recipe_NewRecipe("Mace", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 01);
ATS_Recipe_SetMinSkill(15);
ATS_Recipe_SetMaxSkill(35);
ATS_Recipe_Ingots(3);
//Warhammer
ATS_Recipe_NewRecipe("Warhammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 30);
ATS_Recipe_SetMinSkill(35);
ATS_Recipe_SetMaxSkill(70);
ATS_Recipe_Ingots(9);
//Morningstar
ATS_Recipe_NewRecipe("Morningstar", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 33);
ATS_Recipe_SetMinSkill(45);
ATS_Recipe_SetMaxSkill(80);
ATS_Recipe_Ingots(9);
//Light Hammer
ATS_Recipe_NewRecipe("Light Hammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 35);
ATS_Recipe_SetMinSkill(15);
ATS_Recipe_SetMaxSkill(50);
ATS_Recipe_Ingots(5);
//Heavy Flail
ATS_Recipe_NewRecipe("Heavy Flail", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 36);
ATS_Recipe_SetMinSkill(80);
ATS_Recipe_SetMaxSkill(110);
ATS_Recipe_Ingots(16);
//Light Flail
ATS_Recipe_NewRecipe("Light Flail", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 37);
ATS_Recipe_SetMinSkill(55);
ATS_Recipe_SetMaxSkill(90);
ATS_Recipe_Ingots(13);
//Holy Mace
ATS_Recipe_NewRecipe("Holy Mace", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 21);
ATS_Recipe_SetSingleType("ATS_C_W221_N_BRO");
ATS_Recipe_SetMinSkill(135);
ATS_Recipe_SetMaxSkill(140);
ATS_Recipe_AddMaterial("ATS_C_W201_E_BRO",1,5);  //Exceptional Bronze Mace
ATS_Recipe_AddMaterial("ATS_C_G001_E_AMY",3,100); //Ideal Cut Amethyst
//Malachite Hammer
ATS_Recipe_NewRecipe("Malachite Hammer", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 22);
ATS_Recipe_SetSingleType("ATS_C_W222_N_BRO");
ATS_Recipe_SetMinSkill(140);
ATS_Recipe_SetMaxSkill(145);
ATS_Recipe_AddMaterial("ATS_C_W235_E_BRO",1,5);  //Exceptional Bronze Light Hammer
ATS_Recipe_AddMaterial("ATS_C_G001_E_MAL",3,100); //Ideal Cut Malachite
//Guiding Light (Morningstar)
ATS_Recipe_NewRecipe("Guiding Light", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLUNTS, 34);
ATS_Recipe_SetSingleType("ATS_C_W234_E_RUB");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W233_E_RUB",1,5);  //Exceptional Rubicite Morningstar
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,90); //Red Dragons blood
}
//void main(){}

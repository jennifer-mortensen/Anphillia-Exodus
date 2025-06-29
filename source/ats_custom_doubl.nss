#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomDouble()
{
//Diremace
ATS_Recipe_NewRecipe("Diremace", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 77);
ATS_Recipe_SetMinSkill(85);
ATS_Recipe_SetMaxSkill(120);
ATS_Recipe_Ingots(25);
//Double Axe
ATS_Recipe_NewRecipe("Double Axe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 78);
ATS_Recipe_SetMinSkill(95);
ATS_Recipe_SetMaxSkill(130);
ATS_Recipe_Ingots(35);
//Two-Bladed Sword
ATS_Recipe_NewRecipe("Two-Bladed Sword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 35);
ATS_Recipe_SetMinSkill(90);
ATS_Recipe_SetMaxSkill(125);
ATS_Recipe_Ingots(30);
//Ice Talon (Two-Bladed sword)
ATS_Recipe_NewRecipe("Ice Talon", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 37);
ATS_Recipe_SetSingleType("ATS_C_W637_E_SYE");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W635_E_SYE",1,5);  //Exceptional Syenite 2-blade sword
ATS_Recipe_AddMaterial("ATS_R_MISC_N_ZNT",3,90); //Frozen Heart
//Fleshrender (Doubleaxe)
ATS_Recipe_NewRecipe("Fleshrender", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 30);
ATS_Recipe_SetSingleType("ATS_C_W630_E_VER");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W678_E_VER",1,5);  //Exceptional Ver Doubleaxe
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",3,90); //Slaad's Tongue
//Crushbone (Diremace)
ATS_Recipe_NewRecipe("Crushbone", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 31);
ATS_Recipe_SetSingleType("ATS_C_W631_E_SIL");
ATS_Recipe_SetMinSkill(395);
ATS_Recipe_SetMaxSkill(445);
ATS_Recipe_AddMaterial("ATS_C_W677_E_SIL",1,5);  //Exceptional Silver Diremace
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13",3,90); //Skeletons Knuckles
//Stormbrand (bastard sword)
ATS_Recipe_NewRecipe("Stormbrand", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 38);
ATS_Recipe_SetSingleType("ATS_C_W138_N_GOL");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W131_E_GOL",1,5);  //Exceptional Gold Bastardsword
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",3,90); //Blue Dragons blood
//Quicksilver (Short Sword)
ATS_Recipe_NewRecipe("Quicksilver", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 40);
ATS_Recipe_SetSingleType("ATS_C_W140_N_MIT");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W160_E_MIT",1,5);  //Exceptional Mithril Shortsword
ATS_Recipe_AddMaterial("ATS_R_MISC_N_DST",3,90); //Fairy dust
//Parameus (Greatsword)
ATS_Recipe_NewRecipe("Parameus", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 41);
ATS_Recipe_SetSingleType("ATS_C_W141_E_SIL");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W175_E_SIL",1,5);  //Exceptional Silver Greatsword
ATS_Recipe_AddMaterial("ATS_R_MISC_N_PAR",3,90); //Essense of Parameus
//Natures Bane (Scimiter)
ATS_Recipe_NewRecipe("Natures Bane", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_DOUBLE, 36);
ATS_Recipe_SetSingleType("ATS_C_W136_N_VER");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W135_E_VER",1,5);  //Exceptional Verdicite Scimiter
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",3,90); //Balors blood
}
//void main(){}

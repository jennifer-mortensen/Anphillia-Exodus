#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomBelt()
{
//Belt-Greater-Aqua
ATS_Recipe_NewRecipe("Greater Aqua", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 21);
ATS_Recipe_SetSingleType("ATS_C_T021_N_C01");  //Greater Aqua
ATS_Recipe_SetMinSkill(220);
ATS_Recipe_SetMaxSkill(230);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C01",1,100); //Aqua Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",1,100); //Slaad's Tongue
ATS_Recipe_AddMaterial("NW_IT_MRING002",1,70); //Ring of Elemental Resist
//Belt-Greater-Black
ATS_Recipe_NewRecipe("Greater Black", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 22);
ATS_Recipe_SetSingleType("ATS_C_T022_N_C02");  //Greater Black
ATS_Recipe_SetMinSkill(225);
ATS_Recipe_SetMaxSkill(235);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C02",1,100); //Black Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",1,100); //Slaad's Tongue
ATS_Recipe_AddMaterial("NW_IT_MPOTION017",2,100); //Potion of Fox's Cunning
//Belt-Greater-Blue
ATS_Recipe_NewRecipe("Greater Blue", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 23);
ATS_Recipe_SetSingleType("ATS_C_T023_N_C03");  //Greater Blue
ATS_Recipe_SetMinSkill(230);
ATS_Recipe_SetMaxSkill(240);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C03",1,100); //Black Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",1,100); //Slaad's Tongue
ATS_Recipe_AddMaterial("NW_IT_MPOTION014",2,100); //Potion of Cat's Grace
//Belt-Greater-Bronze
ATS_Recipe_NewRecipe("Greater Bronze", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 24);
ATS_Recipe_SetSingleType("ATS_C_T024_N_C05");  //Greater Bronze
ATS_Recipe_SetMinSkill(240);
ATS_Recipe_SetMaxSkill(250);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C05",2,100); //Bronze Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Brown
ATS_Recipe_NewRecipe("Greater Brown", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 25);
ATS_Recipe_SetSingleType("ATS_C_T025_N_C04");  //Greater Brown
ATS_Recipe_SetMinSkill(245);
ATS_Recipe_SetMaxSkill(255);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C04",2,100); //Brown Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Gold
ATS_Recipe_NewRecipe("Greater Gold", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 26);
ATS_Recipe_SetSingleType("ATS_C_T026_N_C06");  //Greater Gold
ATS_Recipe_SetMinSkill(250);
ATS_Recipe_SetMaxSkill(260);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C06",2,100); //Gold Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Grey
ATS_Recipe_NewRecipe("Greater Grey", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 27);
ATS_Recipe_SetSingleType("ATS_C_T027_N_C07");  //Greater Grey
ATS_Recipe_SetMinSkill(255);
ATS_Recipe_SetMaxSkill(265);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C07",2,100); //Grey Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Green
ATS_Recipe_NewRecipe("Greater Green", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 28);
ATS_Recipe_SetSingleType("ATS_C_T028_N_C08");  //Greater Green
ATS_Recipe_SetMinSkill(260);
ATS_Recipe_SetMaxSkill(270);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C08",2,100); //Green Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Lime
ATS_Recipe_NewRecipe("Greater Lime", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 29);
ATS_Recipe_SetSingleType("ATS_C_T029_N_C09");  //Greater Lime
ATS_Recipe_SetMinSkill(265);
ATS_Recipe_SetMaxSkill(275);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C09",2,100); //Lime Medium Cloth Double
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
//Belt-Greater-Maroon
ATS_Recipe_NewRecipe("Greater Maroon", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 30);
ATS_Recipe_SetSingleType("ATS_C_T030_N_C10");  //Greater Maroon
ATS_Recipe_SetMinSkill(270);
ATS_Recipe_SetMaxSkill(280);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C10",1,100); //Maroon Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,100); //Slaad's Tongue
ATS_Recipe_AddMaterial("NW_IT_NOVEL001",1,100); //Ring of Wood Elves
//Belt-Greater-Navy
ATS_Recipe_NewRecipe("Greater Navy", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 31);
ATS_Recipe_SetSingleType("ATS_C_T031_N_C11");  //Greater Navy
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C11",1,100); //Navy Medium Cloth
ATS_Recipe_AddMaterial("X2_IT_SPDVSCR603",1,100); //Scroll Blade Barrier
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-Olive
ATS_Recipe_NewRecipe("Greater Olive", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 32);
ATS_Recipe_SetSingleType("ATS_C_T032_N_C12");  //Greater Olive
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C12",1,100); //Olive Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_SPARSCR707",1,100); //Scroll Control Undead
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-Purple
ATS_Recipe_NewRecipe("Greater Purple", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 33);
ATS_Recipe_SetSingleType("ATS_C_T033_N_C13");  //Greater Purple
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C13",1,100); //Purple Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_SPDVSCR702",1,100); //Scroll Resurrection
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-Red
ATS_Recipe_NewRecipe("Greater Red", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 34);
ATS_Recipe_SetSingleType("ATS_C_T034_N_C14");  //Greater Red
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C14",1,100); //Red Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_SPARSCR401",1,100); //Scroll Minor Globe of Invuln
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-Silver
ATS_Recipe_NewRecipe("Greater Silver", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 35);
ATS_Recipe_SetSingleType("ATS_C_T035_N_C15");  //Greater Silver
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C15",1,100); //Silver Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_SPDVSCR401",1,100); //Scroll Restoration
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-Teal
ATS_Recipe_NewRecipe("Greater Teal", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 36);
ATS_Recipe_SetSingleType("ATS_C_T036_N_C16");  //Greater Teal
ATS_Recipe_SetMinSkill(275);
ATS_Recipe_SetMaxSkill(285);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C16",1,100); //Teal Medium Cloth
ATS_Recipe_AddMaterial("NW_IT_SPARSCR416",1,100); //Scroll Elemental Shield
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,100); //Blue Dragon's Blood
//Belt-Greater-White
ATS_Recipe_NewRecipe("Greater White", ATS_CRAFT_TYPE_TAILOR, ATS_CRAFT_PART_BELTS, 37);
ATS_Recipe_SetSingleType("ATS_C_T037_N_C17");  //Greater Teal
ATS_Recipe_SetMinSkill(280);
ATS_Recipe_SetMaxSkill(290);
ATS_Recipe_AddMaterial("ATS_C_T998_N_C17",1,100); //White Medium Cloth
ATS_Recipe_AddMaterial("SY_I_RING_051",1,100); //Least Ring of Regen
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",2,100); //Balor's Blood
}
//void main(){}

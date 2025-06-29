#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomHelm()
{
//Helm
ATS_Recipe_NewRecipe("Helm", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 30);
ATS_Recipe_SetMinSkill(10);
ATS_Recipe_SetMaxSkill(40);
ATS_Recipe_Ingots(6);
//Helm of the Relentless Warrior
ATS_Recipe_NewRecipe("Relentless Warrior", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 31);
ATS_Recipe_SetSingleType("ATS_C_A131_N_SIL");
ATS_Recipe_SetMinSkill(430);
ATS_Recipe_SetMaxSkill(460);
ATS_Recipe_AddMaterial("ATS_C_A101_E_SIL",1,100);  //Excep. Silver Helm
ATS_Recipe_AddMaterial("restoredia",3,100); //tiny diamond powder
ATS_Recipe_AddMaterial("ATS_R_MISC_N_DST",1,100); //Fairy Dust
//Negator
ATS_Recipe_NewRecipe("Negator", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 32);
ATS_Recipe_SetSingleType("ATS_C_A132_N_MIT");
ATS_Recipe_SetMinSkill(455);
ATS_Recipe_SetMaxSkill(475);
ATS_Recipe_AddMaterial("ATS_C_A130_E_MIT",1,100);  //Excep. Mythril Helm
ATS_Recipe_AddMaterial("ATS_C_B001_N_RUB",5,100); //Rubicite Ingots
ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA",5,100); //Shadow Ingots
ATS_Recipe_AddMaterial("pearlinfusion",2,100); //Pearl Infusion
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,80); //Red Dragons blood
//Amberax
ATS_Recipe_NewRecipe("Amberax", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_HELMET, 33);
ATS_Recipe_SetSingleType("ATS_C_A133_N_MIT");
ATS_Recipe_SetMinSkill(455);
ATS_Recipe_SetMaxSkill(475);
ATS_Recipe_AddMaterial("ATS_C_A130_E_MIT",1,100);  //Excep. Mythril Helm
ATS_Recipe_AddMaterial("ATS_C_B001_N_GOL",5,100); //Gold Ingots
ATS_Recipe_AddMaterial("x2_it_dyeM08",1,60); //Gold Metal Dye
ATS_Recipe_AddMaterial("pearlinfusion",2,100); //Pearl Infusion
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,80); //Red Dragons blood
}
//void main(){}


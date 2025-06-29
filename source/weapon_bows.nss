/*
void ATS_FletchingRecipies()
{
    // Basic Arrow
    ATS_Recipe_NewRecipe("Basic Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 01);
    ATS_Recipe_SetSingleType("ATS_C_F001_N_ARR");  // Crafted Basic Arrow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(30);
    ATS_Recipe_AddMaterial("ATS_R_FBHE_N_ARR", 1, 100);   // Basic Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Hooked Arrow
    ATS_Recipe_NewRecipe("Hooked Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 02);
    ATS_Recipe_SetSingleType("ATS_C_F002_N_ARR");  // Crafted Hooked Arrow
    ATS_Recipe_SetMinSkill(25);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_FBHO_N_ARR", 1, 100);   // Hooked Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch

    // Bladed Arrow
    ATS_Recipe_NewRecipe("Bladed Crafted Arrow", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 03);
    ATS_Recipe_SetSingleType("ATS_C_F003_N_ARR");  // Crafted Hooked Arrow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_FBBL_N_ARR", 1, 100);   // Bladed Head
    ATS_Recipe_AddMaterial("ATS_R_FBSH_N_ARR", 1, 100);   // Basic Shaft
    ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR", 1, 100);   // Basic Fletch
}


void ATS_BowyeringRecipies()
{

// Shortbows C0 ************************************

    // Rough Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_OAK");  // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(0);
    ATS_Recipe_SetMaxSkill(20);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ELM");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(40);
    ATS_Recipe_SetMaxSkill(60);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C001_N_ASH");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(80);
    ATS_Recipe_SetMaxSkill(100);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smooth Oak Hemp Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_OAK");  // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(20);
    ATS_Recipe_SetMaxSkill(40);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Elm Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ELM");  // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(60);
    ATS_Recipe_SetMaxSkill(80);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Ash Hemp Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C002_N_ASH");  // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(100);
    ATS_Recipe_SetMaxSkill(120);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife


    // Rough Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Rough Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_OAK");  // Rough Oak Hemp Bow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ELM");  // Rough Elm Hemp Bow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C003_N_ASH");  // Rough Ash Hemp Bow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smooth Oak Silk Shortbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_OAK");  // Smooth Oak Hemp Bow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Elm Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ELM");  // Smooth Elm Hemp Bow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smooth Ash Silk Shortbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Shortbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C004_N_ASH");  // Smooth Ash Hemp Bow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife


// Longbows  C1 ************************************

    // Rough Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 01);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_OAK");  // Rough Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(15);
    ATS_Recipe_SetMaxSkill(35);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ELM");  // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(55);
    ATS_Recipe_SetMaxSkill(75);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Rough Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C101_N_ASH");  // Rough Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(95);
    ATS_Recipe_SetMaxSkill(115);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String

    // Smoothed Oak Hemp Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_OAK");  // Smooth Oak Hemp LongBow
    ATS_Recipe_SetMinSkill(35);
    ATS_Recipe_SetMaxSkill(55);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Elm Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ELM");  // Smooth Elm Hemp LongBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Ash Hemp Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C102_N_ASH");  // Smooth Ash Hemp LongBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR", 1, 100);   // Hemp String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Rough Oak Silk Longbow
    ATS_Recipe_NewRecipe("Rough Oak Hemp Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 03);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_OAK");  // Rough Oak Silk LongBow
    ATS_Recipe_SetMinSkill(30);
    ATS_Recipe_SetMaxSkill(50);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Elm Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ELM");  // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(70);
    ATS_Recipe_SetMaxSkill(90);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Rough Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Rough Ash Hemp Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C103_N_ASH");  // Rough Elm Silk LongBow
    ATS_Recipe_SetMinSkill(110);
    ATS_Recipe_SetMaxSkill(130);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String

    // Smoothed Oak Silk Longbow
    ATS_Recipe_NewRecipe("Smooth Oak Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 04);
    ATS_Recipe_SetSingleType("ATS_C_C104N_OAK");  // Smooth Oak Silk Longbow
    ATS_Recipe_SetMinSkill(50);
    ATS_Recipe_SetMaxSkill(70);
    ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA", 1, 100);   // Long Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Elm Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ELM");  // Smooth Elm Silk LongBow
    ATS_Recipe_SetMinSkill(90);
    ATS_Recipe_SetMaxSkill(110);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Smoothed Ash Silk Longbow
    ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Longbow", TRUE);
    ATS_Recipe_SetSingleType("ATS_C_C104_N_ASH");  // Smooth Ash Silk LongBow
    ATS_Recipe_SetMinSkill(130);
    ATS_Recipe_SetMaxSkill(150);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long Ash Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Composite Smoothed Elm Silk Longbow
    ATS_Recipe_NewRecipe("Composite Smooth Elm Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 21);
    ATS_Recipe_SetSingleType("ATS_C_C121_N_ELM");  // Composite Smooth Elm Silk LongBow
    ATS_Recipe_SetMinSkill(145);
    ATS_Recipe_SetMaxSkill(160);
    ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA", 1, 100);   // Long Elm Stave
    ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Composite Smoothed Ash Silk Longbow
    ATS_Recipe_NewRecipe("Composite Smooth Ash Silk Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 22);
    ATS_Recipe_SetSingleType("ATS_C_C122_N_ASH");  // Composite Smooth Ash Silk LongBow
    ATS_Recipe_SetMinSkill(160);
    ATS_Recipe_SetMaxSkill(175);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long ash Stave
    ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    // Composite Iron Maple Longbow
    ATS_Recipe_NewRecipe("Composite Iron Maple Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 23);
    ATS_Recipe_SetSingleType("ATS_C_C123_N_ASH");  // Composite Iron Maple LongBow
    ATS_Recipe_SetMinSkill(173);
    ATS_Recipe_SetMaxSkill(188);
    ATS_Recipe_AddMaterial("ATS_C_F031_N_ARR", 1, 100);   // Long Iron Maple Stave
    ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    //Shadow Longbow
    ATS_Recipe_NewRecipe("Shadow Longbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 24);
    ATS_Recipe_SetSingleType("ATS_C_C124_N_ASH");
    ATS_Recipe_SetMinSkill(180);
    ATS_Recipe_SetMaxSkill(190);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long ash Stave
    ATS_Recipe_AddMaterial("ATS_C_B001_N_BLA",5,100); //Shadow Ingots
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife

    //Dead Reputation
    ATS_Recipe_NewRecipe("Dead Reputation", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW, 25);
    ATS_Recipe_SetSingleType("ATS_C_C125_N_ASH");
    ATS_Recipe_SetMinSkill(188);
    ATS_Recipe_SetMaxSkill(200);
    ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA", 1, 100);   // Long ash Stave
    ATS_Recipe_AddMaterial("ATS_C_B001_N_SIL",5,100); //Silver Ingots
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13",5,80); //Skeletons Knuckles

// Crossbows  C2 ************************************

//Iron Oak Light Crossbow
ATS_Recipe_NewRecipe("Iron Oak Light", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 21);
ATS_Recipe_SetSingleType("ATS_C_C221_N_OAK");  //Iron Oak Light Crossbow
ATS_Recipe_SetMinSkill(120);
ATS_Recipe_SetMaxSkill(135);
ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA",2,100); //Short Oak Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

//Iron Elm Light Crossbow
ATS_Recipe_NewRecipe("Iron Elm Light", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 22);
ATS_Recipe_SetSingleType("ATS_C_C222_N_ELM");  //Iron Elm Light Crossbow
ATS_Recipe_SetMinSkill(130);
ATS_Recipe_SetMaxSkill(145);
ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA",2,100); //Short Elm Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

//Iron Ash Light Crossbow
ATS_Recipe_NewRecipe("Iron Ash Light", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 23);
ATS_Recipe_SetSingleType("ATS_C_C223_N_ASH");  //Iron Ash Light Crossbow
ATS_Recipe_SetMinSkill(140);
ATS_Recipe_SetMaxSkill(155);
ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA",2,100); //Short Ash Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

//Iron Oak Heavy Crossbow
ATS_Recipe_NewRecipe("Iron Oak Heavy", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 24);
ATS_Recipe_SetSingleType("ATS_C_C224_N_OAK");  //Iron Oak Heavy Crossbow
ATS_Recipe_SetMinSkill(140);
ATS_Recipe_SetMaxSkill(155);
ATS_Recipe_AddMaterial("ATS_R_CLAK_N_STA",2,100); //Long Oak Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

//Iron Elm Heavy Crossbow
ATS_Recipe_NewRecipe("Iron Elm Heavy", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 25);
ATS_Recipe_SetSingleType("ATS_C_C225_N_ELM");  //Iron Elm Heavy Crossbow
ATS_Recipe_SetMinSkill(150);
ATS_Recipe_SetMaxSkill(165);
ATS_Recipe_AddMaterial("ATS_R_CLLM_N_STA",2,100); //Long Elm Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

//Iron Ash Heavy Crossbow
ATS_Recipe_NewRecipe("Iron Ash Heavy", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_CROSSBOW, 26);
ATS_Recipe_SetSingleType("ATS_C_C226_N_ASH");  //Iron Ash Heavy Crossbow
ATS_Recipe_SetMinSkill(160);
ATS_Recipe_SetMaxSkill(175);
ATS_Recipe_AddMaterial("ATS_R_CLSH_N_STA",2,100); //Long Ash Staves
ATS_Recipe_AddMaterial("ATS_IRONXBOW",1,100); //Iron Crossbow Components
ATS_Recipe_AddMaterial("ATS_R_CHMP_N_STR",1,100); //Hemp String

// Battlebows  C3 ************************************

// Specials  C4 ************************************

    // Ranger Oak Shortbow
    ATS_Recipe_NewRecipe("Ranger Oak Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_402_N_OAK");  // Ranger Oak ShortBow
    ATS_Recipe_SetMinSkill(75);
    ATS_Recipe_SetMaxSkill(95);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);   // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife


    // Ranger Elm Shortbow
    ATS_Recipe_NewRecipe("Ranger Elm Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SPECIALBOW, 02);
    ATS_Recipe_SetSingleType("ATS_C_402_N_ELM");  // Ranger Elm ShortBow
    ATS_Recipe_SetMinSkill(115);
    ATS_Recipe_SetMaxSkill(135);
    ATS_Recipe_SetClassRestriction(CLASS_TYPE_RANGER);
    ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
    ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Silk String
    ATS_Recipe_AddMaterial("ATS_R_CBRP_N_POT", 1, 75);   // Bowyer Essence
    ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife
}
*/

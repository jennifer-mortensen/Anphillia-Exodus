void main()
{
    object oItem=GetItemActivated();
    string sItemTag=GetTag(oItem);
    if(sItemTag == "MothGlowGreen")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowPixie")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_PIXIEDUST);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowRed")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowYellow")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_YELLOW);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowPurple")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_PURPLE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowBrown")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BROWN);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowBlue")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BLUE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowBubbles")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_BUBBLES);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowSmoke")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowSmoke2")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowBark")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowStone")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowSong")
    {
        effect ePer = EffectVisualEffect(VFX_DUR_BARD_SONG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowButter")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_BUTTERFLY,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowBat")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_BAT,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowBird")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_BIRD,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowDemon")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_DEMON,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowDragon")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowNoWings")
    {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowBoneTail")
    {
     SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureTailType(CREATURE_TAIL_TYPE_BONE,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowDevilTail")
    {
     SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureTailType(CREATURE_TAIL_TYPE_DEVIL,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowLizardTail")
    {
     SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureTailType(CREATURE_TAIL_TYPE_LIZARD,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowFoxTail")
    {
     SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,GetItemActivatedTarget());
     DelayCommand(1.0,SetCreatureTailType(193,GetItemActivatedTarget()));
    }
    if(sItemTag == "MothGlowNoneTail")
    {
     SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,GetItemActivatedTarget());
    }
    if(sItemTag == "MothGlowImmortal")
    {
     SetImmortal(GetItemActivatedTarget(),TRUE);
             if(GetIsPC(GetItemActivatedTarget())==TRUE)
             {
             effect ePer = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT);
             ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,GetItemActivatedTarget());
             }
    }
    if(sItemTag == "MothGlowMortal")
    {
     SetImmortal(GetItemActivatedTarget(),FALSE);
    }
}

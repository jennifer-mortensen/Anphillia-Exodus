void main()
{
    object oAltar = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oBlocker = GetObjectByTag("mothblockboulder");
    object oDoor = GetObjectByTag("MaelstromDoor2");
    SetLocked(oDoor,FALSE);
    AssignCommand(oDoor,ActionOpenDoor(oDoor));
    location lLocation = GetLocation(oBlocker);
    DelayCommand(1.8,SetUseableFlag(oAltar,FALSE));
    DelayCommand(0.5,DestroyObject(oBlocker));

    effect eVisual1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVisual2 = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eVisual3 = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eVisual = EffectLinkEffects(eVisual1,eVisual2);
    eVisual = EffectLinkEffects(eVisual,eVisual3);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oAltar);

    effect eCrumble1 = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eCrumble2 = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eCrumble = EffectLinkEffects(eCrumble1,eCrumble2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVisual,lLocation);

    object oWaypointLight1 = GetWaypointByTag("mothmaelight1");
    location lLocation1 = GetLocation(oWaypointLight1);
    object oLight1 = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lightshft007",lLocation1);

    object oWaypointLight2 = GetWaypointByTag("mothmaelight2");
    location lLocation2 = GetLocation(oWaypointLight2);
    object oLight2 = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lightshft007",lLocation2);

    object oWaypointLight3 = GetWaypointByTag("mothmaelight3");
    location lLocation3 = GetLocation(oWaypointLight3);
    object oLight3 = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lightshft007",lLocation3);

    object oWaypointLight4 = GetWaypointByTag("mothmaelight4");
    location lLocation4 = GetLocation(oWaypointLight4);
    object oLight4 = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lightshft007",lLocation4);

    object oWaypointLight5 = GetWaypointByTag("mothmaelight5");
    location lLocation5 = GetLocation(oWaypointLight5);
    object oLight5 = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lightshft007",lLocation5);

    effect eLight1 = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eLight2 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eLight = EffectLinkEffects(eLight1,eLight2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLight,lLocation1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLight,lLocation2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLight,lLocation3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLight,lLocation4);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLight,lLocation5);

    object oPortalWaypoint = GetWaypointByTag("mothmaelportal");
    location lLocation6 = GetLocation(oPortalWaypoint);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE,"mothmaelportal",lLocation6);

    effect ePortal1 = EffectVisualEffect(460);
    effect ePortal2 = EffectVisualEffect(481);
    effect ePortal = EffectLinkEffects(ePortal1,ePortal2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePortal,lLocation6);
}

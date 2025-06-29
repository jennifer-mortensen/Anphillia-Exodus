void spawnRanged(int iRanged){
    location lTarget;
    object oTarget;
    int i = 1;

    for(i; i <iRanged+1; i++){
        oTarget = GetWaypointByTag("DMC_Ranged" + IntToString(i));
        lTarget = GetLocation(oTarget);
        CreateObject(OBJECT_TYPE_CREATURE, "mephdrow014", lTarget);
        CreateObject(OBJECT_TYPE_CREATURE, "drowrogue006", lTarget);

    }

}


void spawnMelee(int iMelee){
    location lTarget;
    object oTarget;
    int i = 1;

    for(i; i <iMelee+1; i++){
        oTarget = GetWaypointByTag("DMC_Melee" + IntToString(i));
        lTarget = GetLocation(oTarget);
        CreateObject(OBJECT_TYPE_CREATURE, "mephdrow011", lTarget);
    }
}

void spawnPlacables(){
    location lTarget;
    object oTarget;

    oTarget = GetWaypointByTag("barricade_spawn");
    lTarget = GetLocation(oTarget);
    CreateObject(OBJECT_TYPE_CREATURE, "zep_barricade", lTarget);

}



void spawnArea(){

    int iRanged = 22;
    int iMelee = 13;

    spawnRanged(iRanged);
    spawnMelee(iMelee);
    spawnPlacables();


}


void main()
{
    int DoOnce = GetLocalInt(OBJECT_SELF, "DoneOnce");
    if (DoOnce==TRUE) return;
    SetLocalInt(OBJECT_SELF, "DoneOnce", TRUE);
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;
    /* 5d4 roll for minutes, so 5 to 20 mintue
        wait before uber deathspawn */
    float waitSeconds = 5.0 * d4() * 60.0;


    DelayCommand(10.0,spawnArea());


}

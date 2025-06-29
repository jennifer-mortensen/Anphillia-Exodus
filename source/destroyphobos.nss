void main()
{
    object oCreature = GetEnteringObject();

    if(GetTag(oCreature) == "Phobos" || GetTag(oCreature) == "phoboscleaven"){
        FloatingTextStringOnCreature("I cannot pass beyond the gate! AAAAaaaahhhhgg!", oCreature, FALSE);
        DestroyObject(oCreature, 2.0f);
    }
}

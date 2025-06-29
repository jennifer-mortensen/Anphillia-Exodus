void main()
{

if(GetLocalInt(GetModule(), "ent_spawn"))
{
    return;
}
SetLocalInt(GetModule(), "ent_spawn", 1);

int number = d10();
location lLocation = GetLocation(GetWaypointByTag("ent" + IntToString(number)));
CreateObject(OBJECT_TYPE_CREATURE, "ent", lLocation);

int number2 = d10();
while(number2 == number)
{
    number2 = d10();
}
lLocation = GetLocation(GetWaypointByTag("ent" + IntToString(number2)));
CreateObject(OBJECT_TYPE_CREATURE, "ent", lLocation);
}

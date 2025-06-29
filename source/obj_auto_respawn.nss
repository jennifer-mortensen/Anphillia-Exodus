/*
  Hook this to the OnDeath event for objects that require respawn on death.
 */

void main()
{
    float facing = GetFacing(OBJECT_SELF);
    location loc = GetLocation(OBJECT_SELF);
    int objType = GetObjectType(OBJECT_SELF);
    AssignCommand(GetLastAttacker(OBJECT_SELF), ClearAllActions(TRUE));
    CreateObject(objType, GetResRef(OBJECT_SELF), loc, FALSE);
}

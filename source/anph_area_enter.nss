#include "anph_db_inc"
void main()
{
    object oPC = GetEnteringObject ();
    if (oPC == OBJECT_INVALID)
        oPC = GetLocalObject(GetModule(), "Enterer");
    object oArea = GetArea (oPC);
    if (GetIsDM(oPC))
       return;
    if (!GetLocalInt (oPC, "FromFugue"))
    {
        SetLocalObject(oPC, "LastArea", OBJECT_SELF);
    } else {
        DeleteLocalInt (oPC, "FromFugue");
    }
}

#include "hc_inc"
#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"
#include "anphrez_inc"
//////////

void main ()
{
    object oPC = GetPCSpeaker ();
    AnphRez (oPC);
}

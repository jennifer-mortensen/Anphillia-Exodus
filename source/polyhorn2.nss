#include "anph_inc"
void main()
{
  object oPC = GetPCSpeaker();
  AnphSendWarningCall0(oPC);
}

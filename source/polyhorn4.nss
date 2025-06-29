#include "anph_inc"
void main()
{
  object oPC = GetPCSpeaker();
  AnphSendWarningCall2(oPC);
}

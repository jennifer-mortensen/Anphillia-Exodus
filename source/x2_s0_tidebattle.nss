#include "anph_inc"
void main()
{
    int nSpell = GetSpellId();
    if(nSpell == 803)
    {
     AnphSendWarningCall0(OBJECT_SELF);
    }
    else if(nSpell == 804)
    {
     AnphSendWarningCall1(OBJECT_SELF);
    }
    else if (nSpell == 805)
    {
     AnphSendWarningCall2(OBJECT_SELF);
    }
}

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/3;
    if(!MyResistSpell(OBJECT_SELF, oTarget))
    {
       MothPetrify(OBJECT_SELF,oTarget,nDuration,GetSpellId(),MothDC());
    }
}



#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
    return;
    }
    object oTarget = GetSpellTargetObject();
    spellApplyMindBlank(oTarget, GetSpellId());
}

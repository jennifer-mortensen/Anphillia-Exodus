#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (!MothDecreaseOnHitSpellChance())
    {
        return;
    }
    DoSpellBreach(GetSpellTargetObject(), 2, 3, GetSpellId());
}

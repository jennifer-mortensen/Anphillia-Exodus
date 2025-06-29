#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    MothDoMissileStorm(2, nCasterLvl, SPELL_ISAACS_LESSER_MISSILE_STORM);
}



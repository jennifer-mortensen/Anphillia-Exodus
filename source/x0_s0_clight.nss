#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDamage =  MothGetCasterLevel(OBJECT_SELF)/2;
    location lTarget = GetSpellTargetLocation();
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 419, TRUE));
    MothDoMissileStormContinualFlame(lTarget,nDamage, 20, 419, VFX_IMP_MIRV_FLAME, VFX_IMP_FLAME_M, DAMAGE_TYPE_DIVINE, TRUE, TRUE);
}

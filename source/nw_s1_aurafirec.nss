#include "NW_I0_SPELLS"
void main()
{
    int nHD = GetHitDice(GetAreaOfEffectCreator())/2;
    int nDC = 10 + nHD/2;
    int nDamage;
    int nDamSave;
    int nDamageType = DAMAGE_TYPE_FIRE;
    int nSaveType = SAVING_THROW_TYPE_FIRE;
    int nSave = SAVING_THROW_REFLEX;
    int nImp = VFX_IMP_FLAME_S;
    if(GetTag(GetAreaOfEffectCreator())=="mothgreater3b")
    {
     nDamageType = DAMAGE_TYPE_NEGATIVE;
     nSaveType = SAVING_THROW_TYPE_NEGATIVE;
     nSave = SAVING_THROW_FORT;
     nImp = VFX_IMP_NEGATIVE_ENERGY;
    }
    effect eDam;
    effect eVis = EffectVisualEffect(nImp);
    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget, GetAreaOfEffectCreator()))
        {
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_FIRE));
            nDamage = d2(nHD);
            if(MySavingThrow(nSave, oTarget, nDC, nSaveType))
            {
                nDamage = nDamage / 2;
            }
            eDam = EffectDamage(nDamage, nDamageType);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
        oTarget = GetNextInPersistentObject();
    }
}

#include "x0_i0_spells"
#include "moth_inc_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    int nId = GetSpellId();
    object oTarget = GetSpellTargetObject();
    object oMyCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
    int nLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    int nDuration = MothGetCasterLevel(OBJECT_SELF)*2;
    if (GetIsObjectValid(oMyCompanion) && GetIsObjectValid(oTarget))
    {
        if (oTarget == oMyCompanion)
        {
            if (nId == 617)
            {
                RemoveSpellEffects(618, OBJECT_SELF, oTarget);
                RemoveSpellEffects(617, OBJECT_SELF, oTarget);
                MothBuffCompanion(oTarget, VFX_IMP_FROST_L, DAMAGE_TYPE_COLD, DAMAGE_BONUS_1d6, nLevel,nDuration,VFX_DUR_GLOW_WHITE,2,9.0);
            }
            else
            if (nId == 618)
            {
                RemoveSpellEffects(618, OBJECT_SELF, oTarget);
                RemoveSpellEffects(617, OBJECT_SELF, oTarget);
                MothBuffCompanion(oTarget, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE, DAMAGE_BONUS_1d6, nLevel,nDuration,VFX_DUR_GLOW_LIGHT_RED,2,9.0);
            }
        }
        else
        {
            SpeakStringByStrRef(40076);
        }
    }
    else
    {
        SpeakStringByStrRef(40076);
    }
}

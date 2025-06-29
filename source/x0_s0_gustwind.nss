#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "_inc_gen"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    float fDelay2 = GetRandomDelay();
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    float fDelay1 = GetDistanceBetweenLocations(lTarget, GetLocation(oCaster))/20;
    DelayCommand(0.3,TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lTarget, 1, fDelay1, 1.0f, 1.5f));
    DelayCommand(0.6,TLVFXPillar(VFX_FNF_LOS_NORMAL_30,lTarget, 1, fDelay1, 1.4f, 1.5f));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_AREA_OF_EFFECT);
    while (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
           string sAoE;
           sAoE = GetTag(oTarget);
           if (sAoE=="VFX_PER_FOG_OF_BEWILDERMENT"||
               sAoE=="VFX_MOB_NIGHTMARE_SMOKE"||
               sAoE=="VFX_PER_FOGSTINK"||
               sAoE=="VFX_PER_FOGMIND"||
               sAoE=="VFX_PER_FOGFIRE"||
               sAoE=="VFX_PER_FOGKILL"||
               sAoE=="VFX_PER_GREASE"||
               sAoE=="VFX_PER_STONEHOLD"||
               sAoE=="VFX_PER_FOGACID")
            {
               DestroyObject(oTarget,1.0);
            }
        }
        else
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
        {
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                {
                    if (GetLocked(oTarget) == FALSE)
                    {
                        if (GetIsOpen(oTarget) == FALSE)
                        {
                            AssignCommand(oTarget, ActionOpenDoor(oTarget));
                        }
                        else
                            AssignCommand(oTarget, ActionCloseDoor(oTarget));
                    }
                }
                if(!MyResistSpell(oCaster, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()))
                {
                    effect eKnockdown = EffectKnockdown();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));
                    DelayCommand(fDelay+fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                 }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }
}

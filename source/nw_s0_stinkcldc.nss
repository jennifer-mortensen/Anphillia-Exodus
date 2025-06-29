#include "X0_I0_SPELLS"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    float fDelay;
    int nDuration = MothGetCasterLevel(oCaster);
    if (nDuration > 21)
    {
       nDuration = 21;
    }
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            if(!MyResistSpell(oCaster, oTarget, fDelay))
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_STINKING_CLOUD));
                nDamage = d4(nDuration);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = 4 * nDuration;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_ACID, oCaster, fDelay))
                {
                 nDamage = nDamage/2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}

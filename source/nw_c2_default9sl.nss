#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff();
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 30;
    GenerateNPCTreasure();
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(463), OBJECT_SELF));
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(6), GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectModifyAttacks(1), OBJECT_SELF));
}



#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int iTimer = GetLocalInt(OBJECT_SELF, "FocusSpell");
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No School focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now. The spell is lost.</c>");
    return;
    }
    if (iTimer == FALSE)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Evocation Focus is lost.</c>"));
    MothDoMissileStorm(3, nCasterLvl, SPELL_ISAACS_GREATER_MISSILE_STORM);
    SetLocalInt(OBJECT_SELF, "FocusSpell", TRUE);
    DelayCommand(33.0, DeleteLocalInt(OBJECT_SELF, "FocusSpell"));
    DelayCommand(33.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    }
}



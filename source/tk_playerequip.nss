// If your module doesn't have an OnPlayerEquipItem script, use this.
// Otherwise, merge this with your existing script.

#include "tk_hips_inc"

void main()
{
    TK_HiPS_OnFeatChange(GetPCItemLastEquippedBy());
}

// For those who don't know how to merge:
//
// 1) Copy line 4 (begins with #include) to the beginning of your existing
//    script, before any functions.
//
// 2) Copy line 8 (begins with TK_HiPS_) to the end of the main() function
//    in your existing script.
//
// For the more advanced:
// The TK_HiPS_ function should be called after any possible way for a
// character to acquire feats because of equipping; it doesn't need to
// be dead last. It is OK if this function call is followed by something
// that causes another OnPlayerEquipItem event to fire (such as when equipping
// one item causes another item to be equipped, if that's done in a way that
// fires a new event).
// Naturally, "GetPCItemLastEquippedBy()" can be replaced by a variable that
// stores the return value of that function.
// As of HotU, the default OnPlayerEquipItem script is x2_mod_def_equ.nss,
// which contains code for intelligent weapons and tag-based scripting. If
// you use neither of these (double-check!), you don't need the default
// script.

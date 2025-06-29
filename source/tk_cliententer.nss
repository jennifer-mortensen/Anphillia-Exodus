// If your module doesn't have an OnClientEnter script, use this.
// Otherwise, merge this with your existing script.

#include "tk_hips_inc"

void main()
{
    TK_HiPS_OnClientEnter(GetEnteringObject());
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
// The TK_HiPS_ function should be called after any possible way for an
// incoming character to acquire feats (and levels); it doesn't need to
// be dead last.
// Naturally, "GetEnteringObject()" can be replaced by a variable that
// stores the return value of that function.

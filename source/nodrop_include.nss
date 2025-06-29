//// This wont recompile right because its an include = normal
// after changing this though,
//you will need to recompile mad_unaquire and mad_aquire


// To Determine if a item is a SUBRACE item (will automatically make it no drop)
int GetIsSubraceItem(object oTarget)
{
    string strResRef = GetResRef(oTarget);
    if(// Must be resref right below this, not -->  ||
strResRef == "drowdark"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
||
strResRef == "your_resref_here"
    // Must be resref right above this, not -->  ||
    )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}





/*
By: mad_andrew

Include script for no-drop items.
Also requires OnAcquire script "nodrop_acquire",
and a OnUnAcquire script "nodrop_unacquire",
to work.

Will not compile, this is normal.
After changing it recompile other 2 required scripts.

Insert your own resrefs and TAGs for items you want to be no-drop.
*/
int GetIsNoDrop(object oObject)
{
string strResRef = GetResRef(oObject);
string strTag = GetTag(oObject);
/*
Use resref normally because tags may change due to other scripts
storing info in the tags.

Use TAG (or both) if you intent the no-drop item to be for sale in a store,
which is really weird, but hey, its your mod.
Can't use resref for this because items bought in a store have no resref
(if infinite).
*/
if(
strResRef == "testitem"                         //resref example

||//BETWEEN each item, not at beginning or end.

strResRef == "put_resref_here_normally"                         //resref example

||//BETWEEN each item, not at beginning or end.

strResRef == "put_resref_here_normally"                         //resref example

||//BETWEEN each item, not at beginning or end.

strTag == "PUT_TAG_HERE_-_USE_ONLY_IF_ITS_IN_A_STORE"              //TAG example

||//BETWEEN each item, not at beginning or end.

strTag == "PUT_TAG_HERE_-_USE_ONLY_IF_ITS_IN_A_STORE"              //TAG example

||//BETWEEN each item, not at beginning or end.

strTag == "PUT_TAG_HERE_-_USE_ONLY_IF_ITS_IN_A_STORE"              //TAG example
)
{
    return TRUE;
}
else if(GetIsSubraceItem(oObject) == TRUE)
{
    return TRUE;
}
else
{
    return FALSE;
}
}

//void main(){}


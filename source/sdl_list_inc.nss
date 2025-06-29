// sdl_list

/////////////////////////////////////
// Functions
/////////////////////////////////////

int list_create(object store, string name);
int list_delete(object store, string name);

// Newly created iterator points to the head of the list
string list_iterator_get(object store, string name);
string list_iterator_head(object store, string name);
string list_iterator_tail(object store, string name);

// To use: iterator=list_iterator_next/previous(store,name,iterator);
string list_iterator_next(object store, string name, string iterator);
string list_iterator_previous(object store, string name, string
iterator);

// Get object iterator is pointing to
string list_get_string(object store, string name, string iterator);
object list_get_object(object store, string name, string iterator);
int list_get_int(object store, string name, string iterator);
float list_get_float(object store, string name, string iterator);

// Add entry to the end of the list
int list_add_rear_string(object store, string name, string entry);
int list_add_rear_object(object store, string name, object entry);
int list_add_rear_int(object store, string name, int entry);
int list_add_rear_float(object store, string name, float entry);

// Add entry to the front of the list
int list_add_front_string(object store, string name, string entry);
int list_add_front_object(object store, string name, object entry);
int list_add_front_int(object store, string name, int entry);
int list_add_front_float(object store, string name, float entry);

// Add entry after iterator
int list_add_string(object store, string name, string entry, string
iterator);
int list_add_object(object store, string name, object entry, string
iterator);
int list_add_int(object store, string name, int entry, string
iterator);
int list_add_float(object store, string name, float entry, string
iterator);

// Remove entry at iterator
int list_remove(object store, string name, string iterator);

// Returns an iterator or NULL if not in list
string list_find_string(object store, string name, string entry);
string list_find_object(object store, string name, object entry);
string list_find_int(object store, string name, int entry);
string list_find_float(object store, string name, float entry);

void list_debug_string(object store, string name);
void list_debug_object(object store, string name);

// TRUE if empty
int list_is_empty(object store, string name);

int SDL_SUCCESS = 1;
int SDL_ERROR_ALREADY_EXISTS = 1001;
int SDL_ERROR_DOES_NOT_EXIST = 1002;
int SDL_ERROR_OUT_OF_BOUNDS = 1003;
int SDL_ERROR_NO_ZERO_SIZE = 1004;

int SDL_ERROR_ITERATOR_INVALID = 1010;

/////////////////////////////////////
// Implementation
/////////////////////////////////////

string NULL="NULL";

int list_create(object store, string name)
{
    if (GetLocalString(store,name+"_HEAD")!="")
        return SDL_ERROR_ALREADY_EXISTS;

    SetLocalString(store,name+"_HEAD",NULL);
    SetLocalString(store,name+"_TAIL",NULL);

    // Sets counter representing variable name for new nodes
    SetLocalInt(store,name,0);

    return SDL_SUCCESS;
}

int list_delete(object store, string name)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    while (!list_is_empty(store,name))
        list_remove(store,name,list_iterator_get(store,name));

    DeleteLocalString(store,name+"_HEAD");
    DeleteLocalString(store,name+"_TAIL");

    return SDL_SUCCESS;
}

string list_iterator_get(object store, string name)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    return GetLocalString(store,name+"_HEAD");
}

string list_iterator_head(object store, string name)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    return GetLocalString(store,name+"_HEAD");
}

string list_iterator_tail(object store, string name)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    return GetLocalString(store,name+"_TAIL");
}

string list_iterator_next(object store, string name, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    if (iterator==NULL)
        return NULL;

    return GetLocalString(store,iterator+"_NEXT");
}

string list_iterator_previous(object store, string name, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    if (iterator==NULL)
        return NULL;

    if (iterator==GetLocalString(store,name+"_HEAD"))
        return NULL;

    string previous=list_iterator_get(store,name);

    while ((GetLocalString(store,previous+"_NEXT")!=iterator) && (previous!=NULL))
        previous=GetLocalString(store,previous+"_NEXT");

    return previous;
}

string list_get_string(object store, string name, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    return GetLocalString(store,iterator);
}

object list_get_object(object store, string name, string iterator)
{
/*    if (GetLocalString(store,name+"_HEAD")=="")
        return;
*/
    return GetLocalObject(store,iterator+"_OBJECT");
}

int list_get_int(object store, string name, string iterator)
{
    return StringToInt(list_get_string(store,name,iterator));
}

float list_get_float(object store, string name, string iterator)
{
    return StringToFloat(list_get_string(store,name,iterator));
}

int list_add_rear_string(object store, string name, string entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string tail=GetLocalString(store,name+"_TAIL");

    // create new entry
    SetLocalString(store,name_new,entry);
    SetLocalString(store,name_new+"_NEXT",NULL);

    if (tail!=NULL)
        SetLocalString(store,tail+"_NEXT",name_new);
    else
        SetLocalString(store,name+"_HEAD",name_new);

    SetLocalString(store,name+"_TAIL",name_new);

    return SDL_SUCCESS;
}

int list_add_rear_object(object store, string name, object entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string tail=GetLocalString(store,name+"_TAIL");

    // create new entry
    SetLocalString(store,name_new,GetName(entry));
    SetLocalObject(store,name_new+"_OBJECT",entry);
    SetLocalString(store,name_new+"_NEXT",NULL);

    if (tail!=NULL)
        SetLocalString(store,tail+"_NEXT",name_new);
    else
        SetLocalString(store,name+"_HEAD",name_new);

    SetLocalString(store,name+"_TAIL",name_new);

    return SDL_SUCCESS;
}

int list_add_rear_int(object store, string name, int entry)
{
    return list_add_rear_string(store,name,IntToString(entry));
}

int list_add_rear_float(object store, string name, float entry)
{
    return list_add_rear_string(store,name,FloatToString(entry));
}

int list_add_front_string(object store, string name, string entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string head=GetLocalString(store,name+"_HEAD");

    // create new entry
    SetLocalString(store,name_new,entry);
    SetLocalString(store,name_new+"_NEXT",head);

    if (head==NULL)
        SetLocalString(store,name+"_TAIL",name_new);

    SetLocalString(store,name+"_HEAD",name_new);

    return SDL_SUCCESS;
}

int list_add_front_object(object store, string name, object entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string head=GetLocalString(store,name+"_HEAD");

    // create new entry
    SetLocalString(store,name_new,GetName(entry));
    SetLocalObject(store,name_new+"_OBJECT",entry);
    SetLocalString(store,name_new+"_NEXT",head);

    if (head==NULL)
        SetLocalString(store,name+"_TAIL",name_new);

    SetLocalString(store,name+"_HEAD",name_new);

    return SDL_SUCCESS;
}

int list_add_front_int(object store, string name, int entry)
{
    return list_add_front_string(store,name,IntToString(entry));
}

int list_add_front_float(object store, string name, float entry)
{
    return list_add_front_string(store,name,FloatToString(entry));
}

int list_add_string(object store, string name, string entry, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    if (iterator==NULL)
    {
        list_add_front_string(store,name,entry);
        return SDL_SUCCESS;
    }

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string head=GetLocalString(store,name+"_HEAD");

    // create new entry
    SetLocalString(store,name_new,entry);
    SetLocalString(store,name_new+"_NEXT",GetLocalString(store,iterator+"_NEXT"));

    // set iterator to point to new entry
    SetLocalString(store,iterator+"_NEXT",name_new);

    // check to see if we inserted the tail
    if (GetLocalString(store,name+"_TAIL")==iterator)
        SetLocalString(store,name+"_TAIL",name_new);

    return SDL_SUCCESS;
}

int list_add_object(object store, string name, object entry, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    if (iterator==NULL)
    {
        list_add_front_object(store,name,entry);
        return SDL_SUCCESS;
    }

    // Get counter for new nodes and iterate
    int counter=GetLocalInt(store,name);
    SetLocalInt(store,name,counter+1);

    string name_new=name+"_"+IntToString(counter);
    string head=GetLocalString(store,name+"_HEAD");

    // create new entry
    SetLocalString(store,name_new,GetName(entry));
    SetLocalObject(store,name_new,entry);
    SetLocalString(store,name_new+"_NEXT",GetLocalString(store,iterator+"_NEXT"));

    // set iterator to point to new entry
    SetLocalString(store,iterator+"_NEXT",name_new);

    // check to see if we inserted the tail
    if (GetLocalString(store,name+"_TAIL")==iterator)
        SetLocalString(store,name+"_TAIL",name_new);

    return SDL_SUCCESS;
}

int list_add_int(object store, string name, int entry, string iterator)
{
    return list_add_string(store,name,IntToString(entry),iterator);
}

int list_add_float(object store, string name, float entry, string iterator)
{
    return list_add_string(store,name,FloatToString(entry),iterator);
}

int list_remove(object store, string name, string iterator)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return SDL_ERROR_DOES_NOT_EXIST;

    if (iterator==NULL)
        return SDL_SUCCESS;

    // check if we're removing the head and tail
    string head=GetLocalString(store,name+"_HEAD");
    string tail=GetLocalString(store,name+"_TAIL");
    if ((head==iterator) && (tail==iterator))
    {
        SetLocalString(store,name+"_HEAD",NULL);
        SetLocalString(store,name+"_TAIL",NULL);
    }

    // check if we're removing the head
    else if (head==iterator)
        SetLocalString(store,name+"_HEAD",GetLocalString(store,head+"_NEXT"));

    // check if we're removing the tail
    else if (tail==iterator)
        SetLocalString(store,name+"+TAIL",list_iterator_previous(store,name,iterator));

    // remove entry
    string previous=list_iterator_previous(store,name,iterator);
    if (previous!=NULL)
        SetLocalString(store,previous+"_NEXT",GetLocalString(store,iterator+"_NEXT"));

    DeleteLocalString(store,name);
    DeleteLocalString(store,name+"_NEXT");
    DeleteLocalObject(store,name+"_OBJECT");

    return SDL_SUCCESS;
}

string list_find_string(object store, string name, string entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    string iterator=list_iterator_get(store,name);

    while (iterator!=NULL)
    {
        if (GetLocalString(store,iterator)==entry)
            return iterator;

        iterator=list_iterator_next(store,name,iterator);
    }

    return NULL;
}

string list_find_object(object store, string name, object entry)
{
    if (GetLocalString(store,name+"_HEAD")=="")
        return NULL;

    string iterator=list_iterator_get(store,name);

    while (iterator!=NULL)
    {
        if (GetLocalObject(store,iterator+"_OBJECT")==entry)
            return iterator;

        iterator=list_iterator_next(store,name,iterator);
    }

    return NULL;
}

string list_find_int(object store, string name, int entry)
{
    return list_find_string(store,name,IntToString(entry));
}

string list_find_float(object store, string name, float entry)
{
    return list_find_string(store,name,FloatToString(entry));
}

int list_is_empty(object store, string name)
{
    return (GetLocalString(store,name+"_HEAD")=="") ||
        (GetLocalString(store,name+"_HEAD")==NULL);
}

void list_debug_string(object store, string name)
{
    string it=list_iterator_get(store,name);

    while (it!=NULL)
    {
        SendMessageToPC(GetFirstPC(),list_get_string(store,name,it));
        it=list_iterator_next(store,name,it);
    }
}

void list_debug_object(object store, string name)
{
    string it=list_iterator_get(store,name);

    while (it!=NULL)
    {
        SendMessageToPC(GetFirstPC(),GetName(list_get_object(store,name,it)));
        it=list_iterator_next(store,name,it);
    }

}



////////////////////////////////////////////////////////////////////////////////
// (c) Mr. Figglesworth 2002
// This code is licensed under beerware.  You are allowed to freely use it
// and modify it in any way.  Your only two obligations are: (1) at your option,
// to buy the author a beer if you ever meet him; and (2) include the
// copyright notice and license in any redistribution of this code or
// alterations of it.
//
// Full credit for how the array gets implemented goes to the guy who wrote
// the article and posted it on the NWNVault (I couldn't find your article
// to give you credit :( ).  And, of course, to bioware.  Great job!
////////////////////////////////////////////////////////////////////////////////


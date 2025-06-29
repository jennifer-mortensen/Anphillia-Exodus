//External script for database initialization.  Call this for scripts that have too many resources to include the database file and execute the
//database initialization function directly.

#include "_inc_db"

void main()
{
    InitializePCDatabaseVariables(OBJECT_SELF);
}

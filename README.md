# Oracle DBA Practical Project

Student Oracle Database Administration project organized in four phases. The project contains SQL scripts and report files that demonstrate basic Oracle DBA operations: instance inspection, startup modes, tablespace creation, user security, and storage verification.

## Features

- Inspect Oracle SGA information, memory areas, background processes, and initialization parameters.
- Generate a PFILE from the active SPFILE and start the database through `NOMOUNT`, `MOUNT`, and `OPEN` states.
- Create permanent and temporary tablespaces for data, indexes, and temporary segments.
- Add a second datafile to an existing tablespace.
- Create a security profile with session, password, failed-login, and idle-time limits.
- Create an application role and grant basic development privileges.
- Create the `DEV_AHMED_AZIZ` user with tablespace quota and assigned profile.
- Verify created profiles, roles, users, tablespaces, datafiles, tempfiles, and quotas.
- Create and query a simple `TEST_STOCKAGE` table to confirm storage in the expected tablespace.
- Check and unlock the application user account.

## Technologies

- Oracle Database / Oracle XE
- SQL and Oracle SQL*Plus commands
- Oracle data dictionary views such as `DBA_TABLESPACES`, `DBA_DATA_FILES`, `DBA_USERS`, `DBA_PROFILES`, and `DBA_TS_QUOTAS`
- Dynamic performance views such as `V$SGAINFO`, `V$SGASTAT`, `V$BGPROCESS`, and `V$PARAMETER`

## Project Structure

```text
.
|-- Script complet - Ben Ghorbel Ahmed Aziz - L2-DSI-EAD.sql
|-- Examen pratique - DBA - Ben Ghorbel Ahmed Aziz - L2-DSI-EAD.pdf
|-- Phase 1/
|   |-- Phase 1 - Ben Ghorbel Ahmed Aziz.sql
|   `-- Ben Ghorbel Ahmed Aziz.pdf
|-- Phase 2/
|   |-- Phase 2 - Ben Ghorbel Ahmed Aziz.sql
|   `-- Ben Ghorbel Ahmed Aziz.pdf
|-- Phase 3/
|   |-- Phase 3 - Ben Ghorbel Ahmed Aziz.sql
|   `-- Ben Ghorbel Ahmed Aziz.pdf
`-- Phase 4/
    |-- Phase 3 - Execution avec l'utilisateur DEV_AHMED_AZIZ - Ben Ghorbel Ahmed Aziz.sql
    |-- Phase 3 - Verification du statut du compte et unlock - Ben Ghorbel Ahmed Aziz.sql
    `-- Ben Ghorbel Ahmed Aziz.docx
```

The root SQL file is the complete script combining the main work from all phases. The phase folders keep the same work separated by project stage, with supporting report documents.

## Prerequisites

- Oracle Database or Oracle XE installed locally.
- SQL*Plus, SQL Developer, or another Oracle SQL client.
- DBA access for administrative commands, for example a connection as `SYS AS SYSDBA` or another privileged DBA user.
- A valid local directory for Oracle database files. The scripts currently use Windows paths under:

```text
C:\Users\ahmed\Oracle SQL\
```

Change these paths before running the scripts if your Oracle environment uses another location.

## Setup and Run

1. Open SQL*Plus or SQL Developer.
2. Connect with a DBA account.

```sql
CONNECT sys/<password> AS SYSDBA
```

3. Run the scripts in phase order:

```text
Phase 1/Phase 1 - Ben Ghorbel Ahmed Aziz.sql
Phase 2/Phase 2 - Ben Ghorbel Ahmed Aziz.sql
Phase 3/Phase 3 - Ben Ghorbel Ahmed Aziz.sql
Phase 4/Phase 3 - Verification du statut du compte et unlock - Ben Ghorbel Ahmed Aziz.sql
```

4. Connect as the application user for the Phase 4 execution script:

```sql
CONNECT DEV_AHMED_AZIZ/dev_ahmed
```

5. Run:

```text
Phase 4/Phase 3 - Execution avec l'utilisateur DEV_AHMED_AZIZ - Ben Ghorbel Ahmed Aziz.sql
```

Alternatively, review and run the complete script from the project root:

```text
Script complet - Ben Ghorbel Ahmed Aziz - L2-DSI-EAD.sql
```

## Important Notes

- Several commands require DBA privileges, especially startup/shutdown operations, tablespace creation, profile creation, role creation, and user administration.
- `SHUTDOWN IMMEDIATE`, `STARTUP`, `ALTER DATABASE MOUNT`, and `ALTER DATABASE OPEN` affect the whole Oracle instance. Run them only in a local or training database.
- The tablespace datafile and tempfile paths are environment-specific and may need to be changed.
- The scripts are intended for academic practice and manual execution, not automated deployment.


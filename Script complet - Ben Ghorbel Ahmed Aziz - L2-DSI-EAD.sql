// Projet final SGBD Oracle - Phase 1

//Audit des composants de la SGA
SELECT name, bytes
FROM v$sgainfo;

//Affichage detaille des zones de la SGA
SELECT pool, name, bytes
FROM v$sgastat
ORDER BY pool, name;

// Liste des processus d'arriere-plan actifs
SELECT name, description
FROM v$bgprocess
WHERE paddr <> '00'
ORDER BY name;

//Verification des parametres d'initialisation
SHOW PARAMETER spfile;
SHOW PARAMETER shared_pool_size;
SHOW PARAMETER sga_target;

SELECT name, value, issys_modifiable
FROM v$parameter
WHERE name IN ('spfile', 'shared_pool_size', 'sga_target');

//Generation du fichier PFILE a partir du SPFILE actif
CREATE PFILE='C:\Users\ahmed\Oracle SQL\init_educorp.ora'
FROM SPFILE;

//Arret propre de la base
SHUTDOWN IMMEDIATE;

//Demarrage avec le nouveau PFILE en mode NOMOUNT
STARTUP NOMOUNT PFILE='C:\Users\ahmed\Oracle SQL\init_educorp.ora';

/*A ce niveau :
 - Oracle lit le fichier PFILE.
 - Oracle alloue la memoire SGA.
 - Oracle demarre les processus d'arriere-plan.
 - La base n'est pas encore montee.*/
 
 
 //Passage de NOMOUNT vers MOUNT
 ALTER DATABASE MOUNT;
 
 /*A ce niveau :
 - Oracle ouvre les fichiers de controle.
 - Oracle lit les informations sur les fichiers de donnees et les fichiers redo log.
 - La base n'est pas encore ouverte aux utilisateurs.*/
 
 //Passage de MOUNT vers OPEN
 ALTER DATABASE OPEN;
 
 /*
 A ce niveau :
 - Oracle ouvre les fichiers de donnees.
 - Oracle ouvre les fichiers de journalisation.
 - La base devient accessible aux utilisateurs autorises.
*/


// Projet final SGBD Oracle - Phase 2


//Creation du tablespace permanent pour les donnees
CREATE TABLESPACE AHMED_AZIZ_DATA
DATAFILE 'C:\Users\ahmed\Oracle SQL\ahmed_aziz_data01.dbf'
SIZE 50M
AUTOEXTEND ON NEXT 5M MAXSIZE 200M;

//Creation du tablespace permanent pour les index
CREATE TABLESPACE AHMED_AZIZ_INDEX
DATAFILE 'C:\Users\ahmed\Oracle SQL\ahmed_aziz_index01.dbf'
SIZE 20M;

//Creation du tablespace temporaire
CREATE TEMPORARY TABLESPACE AHMED_AZIZ_TEMP
TEMPFILE 'C:\Users\ahmed\Oracle SQL\ahmed_aziz_temp01.tmp'
SIZE 30M;

//Ajout d'un deuxieme fichier de donnees au tablespace DATA
ALTER TABLESPACE AHMED_AZIZ_DATA
ADD DATAFILE 'C:\Users\ahmed\Oracle SQL\ahmed_aziz_data02.dbf'
SIZE 25M;

//Verification des tablespaces crées
SELECT tablespace_name, status, contents
FROM dba_tablespaces
WHERE tablespace_name IN ('AHMED_AZIZ_DATA', 'AHMED_AZIZ_INDEX', 'AHMED_AZIZ_TEMP');

//Verification des fichiers de données
SELECT tablespace_name, file_name, bytes/1024/1024 AS taille_mo, autoextensible
FROM dba_data_files
WHERE tablespace_name IN ('AHMED_AZIZ_DATA', 'AHMED_AZIZ_INDEX');

// Verification du fichier temporaire
SELECT tablespace_name, file_name, bytes/1024/1024 AS taille_mo
FROM dba_temp_files
WHERE tablespace_name = 'AHMED_AZIZ_TEMP';


// Projet final SGBD Oracle - Phase 3

//Activation des limitations de ressources du profil Necessaire pour appliquer SESSIONS_PER_USER et IDLE_TIME.
ALTER SYSTEM SET resource_limit = TRUE SCOPE = MEMORY;

//Creation du profil de securite
CREATE PROFILE PROFIL_AHMED_AZIZ
LIMIT
SESSIONS_PER_USER 2
PASSWORD_LIFE_TIME 60
FAILED_LOGIN_ATTEMPTS 3
IDLE_TIME 15;

//Creation du role applicatif
CREATE ROLE ROLE_AHMED_AZIZ;

//Attribution des privileges systeme necessaires au role 
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE
TO ROLE_AHMED_AZIZ;

//Creation de l'utilisateur applicatif principal
CREATE USER DEV_AHMED_AZIZ
IDENTIFIED BY dev_ahmed
DEFAULT TABLESPACE AHMED_AZIZ_DATA
TEMPORARY TABLESPACE AHMED_AZIZ_TEMP
QUOTA 30M ON AHMED_AZIZ_DATA
PROFILE PROFIL_AHMED_AZIZ;

//Attribution du role a l'utilisateur
GRANT ROLE_AHMED_AZIZ TO DEV_AHMED_AZIZ;

//Verification du profil
SELECT profile, resource_name, limit
FROM dba_profiles
WHERE profile = 'PROFIL_AHMED_AZIZ'
ORDER BY resource_name;

//Verification du role et de ses privileges
SELECT role
FROM dba_roles
WHERE role = 'ROLE_AHMED_AZIZ';

SELECT grantee, privilege
FROM dba_sys_privs
WHERE grantee = 'ROLE_AHMED_AZIZ'
ORDER BY privilege;

//Verification de l'utilisateur
SELECT username, account_status, default_tablespace, temporary_tablespace, profile
FROM dba_users
WHERE username = 'DEV_AHMED_AZIZ';

//Verification du quota
SELECT username, tablespace_name, bytes/1024/1024 AS utilise_mo,
       max_bytes/1024/1024 AS quota_mo
FROM dba_ts_quotas
WHERE username = 'DEV_AHMED_AZIZ';

// Projet final SGBD Oracle - Phase 4

//Creation d'une table de test
CREATE TABLE TEST_STOCKAGE
(
    ID NUMBER,
    NOM VARCHAR2(50)
)
TABLESPACE AHMED_AZIZ_DATA;

//Insertion de lignes de test
INSERT INTO TEST_STOCKAGE VALUES (1, 'Test stockage 1');
INSERT INTO TEST_STOCKAGE VALUES (2, 'Test stockage 2');
COMMIT;

//Verification de la table
DESC TEST_STOCKAGE;

SELECT *
FROM TEST_STOCKAGE;

//Verification de l'emplacement physique de la table
SELECT segment_name, segment_type, tablespace_name
FROM user_segments
WHERE segment_name = 'TEST_STOCKAGE';

//Verification du statut du compte
SELECT username, account_status, lock_date
FROM dba_users
WHERE username = 'DEV_AHMED_AZIZ';

//Deverrouillage du compte par le DBA
ALTER USER DEV_AHMED_AZIZ ACCOUNT UNLOCK;

//Verification apres deverrouillage
SELECT username, account_status, lock_date
FROM dba_users
WHERE username = 'DEV_AHMED_AZIZ';


//fichier init:
xe.__db_cache_size=243269632
xe.__java_pool_size=4194304
xe.__large_pool_size=4194304
xe.__oracle_base='C:\oraclexe\app\oracle'#ORACLE_BASE set from environment
xe.__pga_aggregate_target=432013312
xe.__sga_target=641728512
xe.__shared_io_pool_size=0
xe.__shared_pool_size=377487360
xe.__streams_pool_size=0
*.audit_file_dest='C:\oraclexe\app\oracle\admin\XE\adump'
*.compatible='11.2.0.0.0'
*.control_files='C:\oraclexe\app\oracle\oradata\XE\control.dbf'
*.db_name='XE'
*.DB_RECOVERY_FILE_DEST_SIZE=10G
*.DB_RECOVERY_FILE_DEST='C:\oraclexe\app\oracle\fast_recovery_area'
*.diagnostic_dest='C:\oraclexe\app\oracle\.'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=XEXDB)'
*.job_queue_processes=4
*.memory_target=1024M
*.open_cursors=300
*.remote_login_passwordfile='EXCLUSIVE'
*.sessions=20
*.shared_servers=4
*.undo_management='AUTO'
*.undo_tablespace='UNDOTBS1'

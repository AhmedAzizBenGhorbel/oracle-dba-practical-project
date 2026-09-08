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


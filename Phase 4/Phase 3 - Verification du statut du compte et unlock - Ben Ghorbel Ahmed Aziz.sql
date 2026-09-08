// Projet final SGBD Oracle - Phase 

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

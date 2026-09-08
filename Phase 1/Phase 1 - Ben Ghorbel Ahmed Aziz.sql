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
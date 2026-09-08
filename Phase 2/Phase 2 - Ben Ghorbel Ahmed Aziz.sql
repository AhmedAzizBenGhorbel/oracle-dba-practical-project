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

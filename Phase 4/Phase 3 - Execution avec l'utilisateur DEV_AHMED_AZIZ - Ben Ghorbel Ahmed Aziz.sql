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
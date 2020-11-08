--1
--Quines columnes t´e la taula Pacients?

DESCRIBE Pacients;

--2
--Obtenir totes les dades de la taula Pacients.

SELECT * FROM Pacients;

--3
--Mostrar el codi, DNI, nom, cognoms i g`enere (en aquest ordre) de tot el personal m`edic, ordenat per cognoms i nom.

SELECT codi, DNI, nom, cognoms, genere FROM PersonalMedic ORDER BY cognoms,nom;

--4
--Donar nom i cognoms (etiquetat com a Nom) i c/e de tots els familiars que tenen compte a gmail o hotmail.

SELECT nom ||' '|| cognoms AS Nom, email FROM Familiars WHERE email LIKE '%gmail.com' OR email LIKE '%hotmail.com';

--5
--Donar DNI, nom i cognoms de tot el personal m`edic amb un sou entre 3000 i 4000 euros (inclosos).

SELECT DNI, nom, cognoms FROM PersonalMedic WHERE 3000<=sou AND sou<=4000;

--6
--trobar tota la informaci´o dels pacients que han estat operats sense acompanyant.

SELECT * FROM Pacients p WHERE p.codi NOT IN (SELECT a.pacient FROM Acompanyants a);

--7
SELECT numSerie, to_char(dataFabricacio,'DD-MM-YYYY') as Fabricacio, round(preu,0) as Preu FROM Protesis WHERE model LIKE 'Esp%' ORDER BY dataFabricacio ASC;

--8
SELECT nom||' '|| cognoms AS "NomMetge", email AS "c/e" FROM PersonalMedic WHERE email LIKE '%.com' and TipologiaProfessional='DOC';

--9
SELECT nom, cognoms, floor(months_between(current_date, dataAlta)/12) AS antiguitat FROM PersonalMedic ORDER BY antiguitat DESC;

--10
SELECT nom, cognoms, dataAlta, floor(months_between(current_date,dataAlta)) AS mesosAntiguitat, sou, (sou*0.01)*floor(months_between(current_date,dataAlta)) AS pagaExtra FROM PersonalMedic WHERE floor(months_between(current_date,dataAlta)/12)>=4 ORDER BY dataAlta DESC; 

--11
SELECT codi, nom, cognoms, CASE WHEN TipologiaProfessional='DOC' THEN 'Doctor' WHEN TipologiaProfessional='AUXINF' THEN 'Auxiliar infermeria' WHEN TipologiaProfessional='INF' THEN 'Infermeria' ELSE 'Altres' END AS tipusFeina FROM PersonalMedic;

--12
SELECT codi, nom, cognoms, dataAlta, nom||'_'||replace(cognoms,' ','_')||extract(YEAR from dataAlta)||'@hospitalTal.com' AS novaAdreca FROM PersonalMedic;
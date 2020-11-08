--13
SELECT model, round(AVG(preu),2) as MitjanaPREU FROM Protesis GROUP BY model;

--14
SELECT acompanyant, count(*) as Nvisites FROM Visites GROUP BY acompanyant ORDER BY Nvisites DESC,acompanyant DESC;

--15
SELECT model, round(AVG(preu),2) as MitjanaPREU FROM Protesis WHERE numSerie LIKE '%6%6%' GROUP BY model;

--16
SELECT extract(YEAR from data)||' '||extract(MONTH from data) AS "MES", COUNT(*) AS "Intervencions" FROM Intervencions GROUP BY extract(MONTH from data), extract(YEAR from data);

--17
SELECT extract(YEAR from data)||' '||extract(MONTH from data) AS "MES", COUNT(*) AS "Intervencions" FROM Intervencions GROUP BY extract(MONTH from data), extract(YEAR from data) ORDER BY MES ASC;

--18
SELECT tipologiaProfessional, MAX(sou) AS "SouMax", MIN(sou) AS "SouMin", ((MAX(sou)-Min(sou))/MIN(sou))*100 as "% de diferencia" FROM PersonalMedic HAVING MAX(sou)>=(MIN(sou)*1.25) GROUP BY tipologiaProfessional;

--19
SELECT codi||' '||DNI||' '||nom||' '||cognoms as Informacio, dataNaixement,FLOOR(months_between(current_date,dataNaixement)/12) as EDAT from Pacients ORDER BY FLOOR(months_between(current_date,dataNaixement)/12) ASC;

--20
SELECT genere, (COUNT(email)*100)/COUNT(*) FROM Pacients GROUP BY genere;

--21
SELECT lloc, COUNT(*), MAX(data) FROM Visites GROUP BY lloc;

--22
SELECT lloc, COUNT(*), MAX(data), CASE
WHEN acompanyant IS NOT NULL THEN 'AMB'
ELSE 'SENSE'
END AS acompanyant FROM Visites GROUP BY lloc, CASE 
WHEN acompanyant IS NOT NULL THEN 'AMB' 
ELSE 'SENSE' END;

--23
SELECT codi, SUBSTR(nom,0,5) as nomCurt, cognoms FROM Familiars WHERE LENGTH(nom)>=5;

--24
SELECT poblacio, COUNT(*) as Doctors FROM PersonalMedic where tipologiaProfessional='DOC' GROUP BY poblacio HAVING COUNT(*)>1;

--26
SELECT * FROM Pacients WHERE cognoms LIKE 'H%l%s' OR cognoms LIKE 'M%l%s';

--29
SELECT grauRebuig, count(*) FROM Revisions where grauRebuig>=3 GROUP BY grauRebuig ORDER BY grauRebuig asc;

--30
SELECT genere, AVG(months_between(current_date,dataNaixement)/12) AS MITJANAedat FROM Pacients GROUP by genere;

--31
SELECT pacient, COUNT(*) FROM Visites WHERE months_between(current_date,data)<=12 GROUP by pacient;

--32
SELECT numSerie, model, preu, dataFabricacio ,ADD_MONTHS(dataFabricacio,60) AS Revisio FROM Protesis WHERE model LIKE 'Mal%' ORDER BY ADD_MONTHS(dataFabricacio,60);

--33
SELECT numSerie, CASE 
WHEN extract(YEAR from dataFabricacio)<2020 THEN 'old'||'-'||model
ELSE model
END AS nomModel, preu, dataFabricacio FROM Protesis;

--35
SELECT SUBSTR(email,INSTR(email,'@'),15) AS "DOMINI", count(*) from Familiars GROUP BY SUBSTR(email,INSTR(email,'@'),15);

--36
SELECT nom, CASE 
WHEN INSTR(cognoms,' ')>0 THEN SUBSTR(cognoms,0,INSTR(cognoms,' '))
ELSE cognoms
END AS PrimerCognom,
CASE  
WHEN INSTR(cognoms,' ')>0 THEN SUBSTR(cognoms,INSTR(cognoms,' ')+1,LENGTH(cognoms)-INSTR(cognoms,' ')+1)
ELSE 'NULL'
END AS SegonCognom
FROM Pacients;

--37
SELECT SUBSTR(numSerie,0,1)||'-'||SUBSTR(numSerie,2,LENGTH(numSerie)-1), model, dataFabricacio, round((preu*100)/121,2) AS PreuSenseIVA FROM Protesis ORDER BY round((preu*100)/121,2) DESC;

--40
SELECT extract(YEAR from data), CASE 
WHEN SUBSTR(protesi,0,1) = 'E' THEN 'Espatlla'
WHEN SUBSTR(protesi,0,1) = 'M' THEN 'Maluc'
ELSE 'Genoll'
END AS tipus, COUNT(*) AS intervencions FROM Intervencions GROUP by extract(YEAR from data),CASE 
WHEN SUBSTR(protesi,0,1) = 'E' THEN 'Espatlla'
WHEN SUBSTR(protesi,0,1) = 'M' THEN 'Maluc'
ELSE 'Genoll'
END ;
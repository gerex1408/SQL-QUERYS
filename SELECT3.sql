--41
SELECT i.codi, MAX(r.grauRebuig) AS MaxrebuigDetectat FROM Intervencions i JOIN Revisions r ON i.codi=r.intervencio GROUP BY i.codi ORDER BY MAX(r.grauRebuig) DESC, i.codi ASC;

--42
SELECT i.codi, MAX(r.grauRebuig) AS MaxrebuigDetectat, p.nom, p.cognoms 
FROM Intervencions i JOIN Pacients p ON i.pacient=p.codi
JOIN Revisions r on i.codi=r.intervencio
GROUP BY i.codi, p.nom, p.cognoms
ORDER BY MaxrebuigDetectat DESC, p.cognoms, p.nom;

--43
SELECT i.codi, MAX(r.grauRebuig) AS MaxrebuigDetectat, p.nom, p.cognoms
FROM Intervencions i JOIN Pacients p ON i.pacient=p.codi
JOIN Revisions r ON r.intervencio=i.codi
WHERE r.data - i.data <= 45
GROUP BY i.codi,p.nom,p.cognoms
ORDER BY MaxrebuigDetectat DESC, p.cognoms,p.nom;

--44
SELECT pm.nom, pm.cognoms, CASE
WHEN pm.genere='H' THEN tp.nomHome
ELSE tp.nomDona
END AS TipologiaGenere, pm.sou
FROM PersonalMedic pm JOIN TipologiesPersonal tp ON pm.tipologiaProfessional=tp.codi
ORDER BY pm.nom ASC, pm.cognoms ASC;

--45
SELECT DISTINCT pm.nom, pm.cognoms
FROM Intervencions i JOIN ProfessionalsIntervencio pin ON i.codi=pin.intervencio
JOIN PersonalMedic pm ON pin.personal=pm.codi
WHERE tipologiaProfessional='INF' and extract(YEAR from i.data)=2019;

--46
SELECT mp.tipus, COUNT(*) AS quantitat, AVG(p.preu) AS mitjanaPreu FROM ModelsProtesis mp JOIN Protesis p ON mp.codi=p.model
GROUP BY mp.tipus;

--47
SELECT mp.tipus, COUNT(*) AS quantitat, AVG(p.preu) AS mitjanaPreu
FROM Protesis p JOIN ModelsProtesis mp ON p.model=mp.codi
JOIN TipologiesProtesis tp ON tp.codi=mp.tipus
WHERE p.numSerie IN (SELECT protesi FROM Intervencions)
GROUP BY mp.tipus
ORDER BY mp.tipus DESC; 

--48
SELECT v.codi, p.nom||' '||p.cognoms AS Pacient, CASE
WHEN a.nom IS NULL THEN 'NULL'
ELSE a.nom||' '||a.cognoms 
END AS Acompanyant
FROM Visites v JOIN Intervencions i ON v.codi=i.visitaDecisio 
LEFT OUTER JOIN Pacients p ON v.pacient = p.codi 
LEFT OUTER JOIN Familiars a ON v.acompanyant= a.codi
ORDER BY v.codi;

--49
SELECT v.codi, p.nom||' '||p.cognoms AS Pacient, CASE
WHEN a.nom IS NULL THEN 'NULL'
ELSE a.nom||' '||a.cognoms 
END AS Acompanyant,
r.relacio
FROM Visites v JOIN Intervencions i ON v.codi=i.visitaDecisio 
LEFT OUTER JOIN Pacients p ON v.pacient = p.codi 
LEFT OUTER JOIN Familiars a ON v.acompanyant= a.codi
LEFT OUTER JOIN Acompanyants r ON a.codi=r.familiar
ORDER BY v.codi;

--50
SELECT DISTINCT p.nom, p.cognoms 
FROM Pacients p JOIN Visites v ON v.pacient=p.codi
JOIN ProfessionalsVisita pv ON v.codi=pv.visita
WHERE pv.personal IN (SELECT pv.personal FROM ProfessionalsVisita pv
JOIN Visites v ON v.codi=pv.visita
JOIN Pacients p ON p.codi=v.pacient
WHERE p.nom='Ariadna' and p.cognoms= 'Pi Petit');

--51
SELECT tp.descripcio, mp.descripcio, MAX(r.grauRebuig)
FROM Revisions r JOIN Intervencions i ON r.intervencio=i.codi
JOIN Protesis p ON i.protesi=p.numSerie
JOIN ModelsProtesis mp ON p.model=mp.codi
JOIN TipologiesProtesis tp ON mp.tipus=tp.codi
GROUP BY tp.descripcio, mp.descripcio
ORDER BY tp.descripcio, MAX(r.grauRebuig);

--52
SELECT p.nom AS nom, p.cognoms AS cognoms, pm.codi AS respo, i.data AS data
FROM pacients p JOIN intervencions i ON p.codi = i.pacient
JOIN PersonalMedic pm ON i.responsable = pm.codi
WHERE pm.nom LIKE 'David'
ORDER BY data DESC;

--53
SELECT p.nom AS nom, p.cognoms AS cognoms, pm.codi AS respo, i.data AS data, pm.nom||' '||pm.cognoms as nomMetge, months_between(pm.dataAlta,i.data)
FROM pacients p JOIN intervencions i ON p.codi = i.pacient
JOIN PersonalMedic pm ON i.responsable = pm.codi
WHERE pm.nom LIKE 'David'
ORDER BY data DESC;

--54
SELECT p.CODI, p.DNI, p.GENERE, p.NOM, p.COGNOMS, p.ADRECA, p.CODIPOSTAL as CODIP, p.POBLACIO, p.EMAIL, p.TELEFON, p.TIPOLOGIAPROFESSIONAL as TIPOLOGIAP, p.SOU, p.DD_LAT
FROM PERSONALMEDIC p
WHERE ((SELECT count(INTERVENCIO) FROM PROFESSIONALSINTERVENCIO WHERE p.CODI = PERSONAL GROUP BY PERSONAL) < 5) and (p.TIPOLOGIAPROFESSIONAL = 'DOC' or p.TIPOLOGIAPROFESSIONAL = 'INF');

--56
select trunc(((current_date-p.dataNaixement)/365)/10)*10 as agrupats, count(*)
from Intervencions i JOIN Pacients p ON i.pacient=p.codi
group by trunc(((current_date-p.dataNaixement)/365)/10)*10
order by agrupats desc;

--58
SELECT pm.nom, pm.cognoms, pm.sou, tipologiaprofessional,
(SELECT AVG(sou) 
FROM personalmedic p
GROUP BY tipologiaprofessional
HAVING pm.tipologiaprofessional=p.tipologiaprofessional) 
AS SOUMITJATIPOLOGA
FROM personalmedic pm
WHERE pm.sou>=
(SELECT avg(sou) 
FROM personalmedic p
GROUP BY tipologiaprofessional
HAVING pm.tipologiaprofessional=p.tipologiaprofessional);



--1
select PROF_NOM,PROF_COGNOM_1,PROF_COGNOM_2  from PROFESSOR 
where PROF_DATA_NAIXEMENT=  (select max(PROF_DATA_NAIXEMENT) from PROFESSOR );

--2
SELECT assig_curs, assig_semestre, assig_nom, assig_credits
FROM Assignatures
ORDER BY assig_curs, assig_semestre, assig_credits DESC;

--3
SELECT assig_nom, assig_credits 
FROM Assignatures JOIN Matricula ON assig_codi=matr_assig_codi
where matr_alum_dni=111;

--4
SELECT prof_nom||' '||prof_cognom_1||' '||PROF_COGNOM_2 as professor
FROM Professor JOIN Departament ON prof_dept_codi=dept_codi
WHERE dept_ubicacio LIKE 'POLITECNICA%' and floor(months_between(current_date,PROF_DATA_NAIXEMENT)/12)>50;

--5
SELECT ASSIGNATURES.ASSIG_NOM, ALUMNES.ALUMN_NOM FROM ASSIGNATURES 
JOIN MATRICULA ON ASSIGNATURES.ASSIG_CODI=MATRICULA.MATR_ASSIG_CODI
JOIN ALUMNES ON ALUMNES.ALUMN_DNI= MATRICULA.MATR_ALUM_DNI
WHERE ASSIG_CODI 
IN(SELECT ASSIGPROF_ASSIG_CODI
    FROM ASSIGNATURES_PROFESSOR
            WHERE ASSIGPROF_PROF_DNI IN 
            (SELECT PROF_DNI FROM PROFESSOR  WHERE PROF_NOM='PERE' AND PROF_COGNOM_1='VIDAL'));

--6
SELECT prof_nom||' '||PROF_COGNOM_1||' '||PROF_COGNOM_2 as professor, assig_credits
FROM Assignatures JOIN Professor ON prof_dni=assig_dni_professor_resp
GROUP BY prof_nom||' '||PROF_COGNOM_1||' '||PROF_COGNOM_2,assig_credits
HAVING count(*)<=2;

--7
SELECT alumn_nom, alumn_cognom_1, alumn_cognom_2, alumn_telefon
FROM ALUMNES LEFT OUTER JOIN MATRICULA ON matr_alum_dni=alumn_dni
GROUP BY alumn_nom, alumn_cognom_1, alumn_cognom_2,alumn_telefon
HAVING count(matr_assig_codi)=0;

--8
select prof_dni,prof_cognom_1,prof_cognom_2,prof_telefon 
from PROFESSOR 
where PROF_DNI not in( select ASSIG_DNI_PROFESSOR_RESP from ASSIGNATURES );

--9
select matr_convocatoria,count(*)as N_Aprovats from assignatures a
join Matricula m on m.matr_assig_codi=a.assig_codi
where Assig_nom='ENGINYERIA DEL SOFTWARE I' and MATR_NOTA>=5
group by matr_convocatoria;

--10
select PROF_NOM,PROF_COGNOM_1,PROF_COGNOM_2 from PROFESSOR where PROF_CODI_POSTAL is NULL

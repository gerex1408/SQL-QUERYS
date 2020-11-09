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


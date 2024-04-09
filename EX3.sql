SELECT * FROM patent LIMIT 20;

SELECT COUNT(*) FROM patent;

SELECT COUNT(DISTINCT patent_id) FROM patent;

SELECT num_claims, COUNT(*) AS obs FROM patent GROUP BY num_claims;
SELECT num_claims, COUNT(*) AS obs FROM patent GROUP BY num_claims ORDER BY obs DESC;

SELECT patent_type, COUNT(*) AS obs FROM patent GROUP BY patent_type;

SELECT COUNT(*) FROM assignee;

SELECT COUNT(DISTINCT assignee_id) FROM assignee;
-- permet d'éviter les doublons

SELECT assignee_type, COUNT(*) AS obs FROM assignee GROUP BY assignee_type;

SELECT * FROM patent AS p
JOIN patent_assignee AS pa ON p.patent_id = pa.patent_id

SELECT a.assignee_id, a.disambig_assignee_organization, assignee_type, COUNT(*) as nb_patents
FROM patent AS p
JOIN patent_assignee AS pa ON p.patent_id = pa.patent_id
JOIN assignee AS a ON pa.assignee_id = a.assignee_id
GROUP BY a.assignee_id
ORDER BY nb_patents DESC
LIMIT 10;

CREATE TEMP TABLE temp_assignee AS
SELECT a.assignee_id, a.disambig_assignee_organization, assignee_type, COUNT(*) as nb_patents
FROM patent AS p
JOIN patent_assignee AS pa ON p.patent_id = pa.patent_id
JOIN assignee AS a ON pa.assignee_id = a.assignee_id
GROUP BY a.assignee_id

CREATE INDEX IF NOT EXISTS temp.patent_id_idx ON temp_assignee (assignee_id);
CREATE INDEX IF NOT EXISTS temp.nb_patent_idx ON temp_assignee (nb_patents);

SELECT * FROM temp_assignee ORDER BY nb_patents DESC LIMIT 10;

SELECT cpc_class, COUNT(*) AS obs
FROM cpc_current
GROUP BY cpc_class
ORDER BY cpc_class DESC LIMIT 6;


--- What are the most common technological classes of patents?

selECT cpc_class, COUNT (*)AS cpc_class_cnt FROM CPC 
GROUP BY cpc_class ORDER BY cpc_class_cnt DESC LIMIT 5;

--- How many classes does a patent have on average? (distribution of classes or average)?

SELECT AVG(class_cnt) FROM
(SELECT patent_id, COUNT (*) AS class_cnt FROM cpc
GROUP BY patent_id);
CREATE temp TABLE tmp_class_cnt AS
SELECT patent_id, COUNT (*) AS class_cnt FROM cpc
GROUP BY patent_id;
SELECT AVG(class_cnt) FROM tmp_class_cnt;

--- number of distinct cpc-classes in table cpc-current.

SELECT COUNT(DISTINCT cpc_class) FROM cpc;

--- How common is it that one patent spans several sections, subsections, or groups?

SELECT section_cnt, COUNT (*) FROM
(SELECT patent_id, COUNT(DISTINCT cpc_section) AS section_cnt 
FROM cpc GROUP BY patent_id) AS result1
GROUP BY section_cnt ORDER BY section_cnt;

CREATE TABLE tmp_cpc_section_cnts AS
SELECT patent_id, COUNT(DISTINCT cpc_section) AS section_cnt 
FROM cpc GROUP BY patent_id;
SELECT section_cnt, COUNT (*)FROM tmp_cpc_section_cnts 
GROUP BY section_cnt ORDER BY section_cnt;

-- compte le nombre de valeurs distinctes dans la colonne cpc_section pour chaque patent_id


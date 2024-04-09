CREATE TABLE "patent" (
patent_id integer NOT NULL,
patent_type varchar(100) DEFAULT NULL,
patent_date date DEFAULT NULL,
patent_title mediumtext DEFAULT NULL,
patent_abstract	mediumtext DEFAULT NULL,
wipo_kind varchar(10) DEFAULT NULL,
num_claims int(11) DEFAULT NULL,
withdrawn int(11) DEFAULT NULL,
filename varchar(120) DEFAULT NULL,
PRIMARY KEY(patent_id)
)

CREATE TABLE "assignee" (
assignee_id varchar(36) NOT NULL,
assignee_type int(4),
disambig_assignee_individual_name_first	varchar(96),
disambig_assignee_individual_name_last varchar(96),
disambig_assignee_organization varchar(256),
PRIMARY KEY(assignee_id)
)

CREATE TABLE "patent_assignee" (
patent_id varchar(20) NOT NULL,
assignee_id varchar(36) NOT NULL,
location_id varchar(50),
PRIMARY KEY(patent_id, assignee_id)
)

CREATE TABLE "cpc_current" (
patent_id varchar(20) NOT NULL,
cpc_section	varchar(10),
cpc_class	varchar(20),
cpc_subclass varchar(20),
cpc_group varchar(32),
cpc_type varchar(36),
cpc_sequence	int(11) NOT NULL,
PRIMARY KEY(patent_id, cpc_sequence)
)

SELECT COUNT(*)FROM patent;
--Total rows of patent 

SELECT * FROM patent WHERE num_claims >10 

CREATE INDEX "patent_num_claims_idx" ON "patent" (
"num_claims"
);

SELECT * FROM patent WHERE num_claims <40;

SELECT * FROM patent LIMIT 10;
SELECT * FROM patent WHERE patent_id < 10000010;
SELECT * FROM patent WHERE patent_date > '2019-01-01';








-- Assignee id avec le plus de brevet 
SELECT assignee_id, count (*) As nbrpatent 
FROM patent_assignee
Group by assignee_id
ORDER By nbrpatent DESC;

-- Combien de brevets par an? Quelle année a le plus : 2019
--SUBST permet de donner les 4 premiers caractères de la date 
SELECT SUBSTR(patent_date, 1, 4) AS annee, COUNT(*) AS nombre_brevets
FROM patent
GROUP BY SUBSTR(patent_date, 1, 4)
ORDER BY nombre_brevets DESC;
--Date avec le plus brevet 
SELECT patent_date, count(*) As patentperyear
from patent 
group by patent_date
ORDER by patentperyear DESC;

SELECT cpc_section, count(disctinct As aze
from cpc
group by cpc_section
order by aze DEsc; 
BEGIN; 

DROP TABLE IF EXISTS "person";

CREATE TABLE "person"(
	"person_id" Integer NOT NULL PRIMARY KEY,
	"name" Text NOT NULL,
	"gender" Integer NOT NULL DEFAULT 0, -- ISO/IEC 5218
	"father_id" Integer,
	"mother_id" Integer,
	CONSTRAINT "lnk_father" 
    FOREIGN KEY ("father_id") 
    REFERENCES "person"("person_id")
		ON DELETE Set NULL
		ON UPDATE Set NULL,
	CONSTRAINT "lnk_mother" 
    FOREIGN KEY ("mother_id") 
    REFERENCES "person"("person_id")
		ON DELETE Set NULL
		ON UPDATE Set NULL,

	CONSTRAINT "unique_id" UNIQUE ("person_id"));


DROP TABLE IF EXISTS "family_relation";

CREATE TABLE "family_relation"(
	"husband_id" Integer NOT NULL,
	"wife_id" Integer NOT NULL,
	CONSTRAINT "lnk_husband" 
    FOREIGN KEY ( "husband_id" )
    REFERENCES "person"("person_id")
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT "lnk_wife" 
    FOREIGN KEY ("wife_id") 
    REFERENCES "person"("person_id")
		ON DELETE RESTRICT
		ON UPDATE CASCADE,

	CONSTRAINT "unique_wife_id" UNIQUE ( "wife_id" ),
	CONSTRAINT "unique_husband_id" UNIQUE ( "husband_id" ) );

CREATE UNIQUE INDEX family_relation_index ON 
  family_relation("husband_id", "wife_id");


-- Dump data of "person" ----------------------------------
INSERT INTO `person` 
(`person_id`, `name`, `gender`, `father_id`, `mother_id`)
VALUES
  ('1', 'Олексій', '1', NULL, NULL),
  ('2', 'Віктор', '1', 8, 18),
  ('3', 'Богдан', '1', NULL, NULL),
  ('4', 'Максим', '1', NULL, NULL),
  ('5', 'Іван', '1', NULL, NULL),
  ('6', 'Петро', '1', 3, 13),
  ('7', 'Василь', '1', 3, 13),
  ('8', 'Григорій', '1', 4, 15),
  ('9', 'Анатолій', '1', 5, 16),
  ('10', 'Олександр', '1', 17, 6),
  ('11', 'Сергій', '1', 10, 20),
  ('12', 'Оксана', '2', NULL, NULL),
  ('13', 'Зінаїда', '2', NULL, NULL),
  ('14', 'Олена', '2', 1, 12),
  ('15', 'Валерія', '2', NULL, NULL),
  ('16', 'Лариса', '2', NULL, NULL),
  ('17', 'Галина', '2', 1, 12),
  ('18', 'Марина', '2', 5, 16),
  ('19', 'Світлана', '2', 5, 16),
  ('20', 'Наталія', '2', 8, 18),
  ('21', 'Катерина', '2', 10, 20);


-- Dump data of "family_relation" -------------------------
INSERT INTO 
`family_relation` (`husband_id`, `wife_id`)
VALUES
  (1, 12),
  (3, 13),
  (4, 15),
  (5, 16),
  (6, 17),
  (8, 18),
  (10, 20);


END; 

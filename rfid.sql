/*
** rfid database
*/

CREATE TABLE category (
    categoryid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT UNIQUE
);

CREATE TABLE object (
    objectid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    categoryid INTEGER REFERENCES category(categoryid),
    description TEXT
);

CREATE TABLE tag (
    tagindex INTEGER NOT NULL PRIMARY KEY,
    tagid VARCHAR(32) NOT NULL UNIQUE,
    objectid INTEGER REFERENCES object(objectid),
    description TEXT
);

CREATE TABLE antenna (
    antid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT
);

CREATE TABLE area (
    areaid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    border INTEGER[]
);

CREATE TABLE detection (
    tagid VARCHAR(32) NOT NULL REFERENCES tag(tagid),
    antid INTEGER NOT NULL REFERENCES antenna(antid),
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE location (
    objectid INTEGER NOT NULL REFERENCES object(objectid),
    areaid INTEGER NOT NULL REFERENCES area(areaid),
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    direction INTEGER
);


/*
** Index
*/
CREATE INDEX detection_index_by_time ON detection(time);
CREATE INDEX location_index_by_time ON location(time);
CREATE INDEX tag_index_by_tagid ON tag(tagid);

/*
** user: rfid privilege
*/
GRANT CONNECT ON DATABASE rfid TO rfid;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE object TO rfid;
GRANT SELECT, UPDATE ON TABLE tag TO rfid;
GRANT SELECT ON TABLE antenna TO rfid;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE category TO rfid;
GRANT SELECT ON TABLE area TO rfid;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE detection TO rfid;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE location TO rfid;
/*GRANT ALL PRIVILEGES ON TABLE location TO rfid;*/

/*
** user: sensor privilege
*/
GRANT CONNECT ON DATABASE rfid TO sensor;

GRANT SELECT ON TABLE tag TO sensor;
GRANT INSERT ON TABLE detection TO sensor;

/*
** ADD DATA   
*/

/*
** 10 areas
*/
DO $$
DECLARE
    i INTEGER := 0;
    areaNum INTEGER := 10;
BEGIN
    WHILE i < areaNum LOOP
        INSERT INTO area DEFAULT VALUES;
        i := i + 1;
    END LOOP;
END$$;

/*
** 20 antennas
*/
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');
INSERT INTO antenna(description) VALUES('');

/*
** 290 tags
*/
INSERT INTO tag(tagindex, tagid) VALUES (1, 'e2801170000002161d2da08c');
INSERT INTO tag(tagindex, tagid) VALUES (2, 'e2801170000002161d2da0ac');
INSERT INTO tag(tagindex, tagid) VALUES (3, 'e2801170000002161d2dc2bc');
INSERT INTO tag(tagindex, tagid) VALUES (4, 'e2801170000002161d2dc2fc');
INSERT INTO tag(tagindex, tagid) VALUES (5, 'e2801170000002161d2da0fc');
INSERT INTO tag(tagindex, tagid) VALUES (6, 'e2801170000002161d2dc27c');
INSERT INTO tag(tagindex, tagid) VALUES (7, 'e2801170000002161d2dc26c');
INSERT INTO tag(tagindex, tagid) VALUES (8, 'e2801170000002161d2da0ec');
INSERT INTO tag(tagindex, tagid) VALUES (9, 'e2801170000002161d2da0dc');
INSERT INTO tag(tagindex, tagid) VALUES (10, 'e2801170000002161d2dc23c');
INSERT INTO tag(tagindex, tagid) VALUES (11, 'e2801170000002161d2dc22c');
INSERT INTO tag(tagindex, tagid) VALUES (12, 'e2801170000002161d2dd46c');
INSERT INTO tag(tagindex, tagid) VALUES (13, 'e2801170000002161d2dc29c');
INSERT INTO tag(tagindex, tagid) VALUES (14, 'e2801170000002161d2dd47c');
INSERT INTO tag(tagindex, tagid) VALUES (15, 'e2801170000002161d2e2aeb');
INSERT INTO tag(tagindex, tagid) VALUES (16, 'e2801170000002161d2da0dd');
INSERT INTO tag(tagindex, tagid) VALUES (17, 'e2801170000002161d2e3cab');
INSERT INTO tag(tagindex, tagid) VALUES (18, 'e2801170000002161d2e3c9b');
INSERT INTO tag(tagindex, tagid) VALUES (19, 'e2801170000002161d2d5acd');
INSERT INTO tag(tagindex, tagid) VALUES (20, 'e2801170000002161d2d6c5d');
INSERT INTO tag(tagindex, tagid) VALUES (21, 'e2801170000002161d2d6c1c');
INSERT INTO tag(tagindex, tagid) VALUES (22, 'e2801170000002161d2d6c6c');
INSERT INTO tag(tagindex, tagid) VALUES (23, 'e2801170000002161d2da01c');
INSERT INTO tag(tagindex, tagid) VALUES (24, 'e2801170000002161d2e081c');
INSERT INTO tag(tagindex, tagid) VALUES (25, 'e2801170000002161d2da09c');
INSERT INTO tag(tagindex, tagid) VALUES (26, 'e2801170000002161d2da00c');
INSERT INTO tag(tagindex, tagid) VALUES (27, 'e2801170000002161d2e2a4b');
INSERT INTO tag(tagindex, tagid) VALUES (28, 'e2801170000002161d2da0bc');
INSERT INTO tag(tagindex, tagid) VALUES (29, 'e2801170000002161d2e2a3b');
INSERT INTO tag(tagindex, tagid) VALUES (30, 'e2801170000002161d2e2a2b');
INSERT INTO tag(tagindex, tagid) VALUES (31, 'e2801170000002161d2da07d');
INSERT INTO tag(tagindex, tagid) VALUES (32, 'e2801170000002161d2da0cc');
INSERT INTO tag(tagindex, tagid) VALUES (33, 'e2801170000002161d2da0fd');
INSERT INTO tag(tagindex, tagid) VALUES (34, 'e2801170000002161d2d6c7d');
INSERT INTO tag(tagindex, tagid) VALUES (35, 'e2801170000002161d2da06d');
INSERT INTO tag(tagindex, tagid) VALUES (36, 'e2801170000002161d2da08d');
INSERT INTO tag(tagindex, tagid) VALUES (37, 'e2801170000002161d2da0cd');
INSERT INTO tag(tagindex, tagid) VALUES (38, 'e2801170000002161d2d6ced');
INSERT INTO tag(tagindex, tagid) VALUES (39, 'e2801170000002161d2d6cad');
INSERT INTO tag(tagindex, tagid) VALUES (40, 'e2801170000002161d2da0bd');
INSERT INTO tag(tagindex, tagid) VALUES (41, 'e2801170000002161d2dc2dc');
INSERT INTO tag(tagindex, tagid) VALUES (42, 'e2801170000002161d2d6c6d');
INSERT INTO tag(tagindex, tagid) VALUES (43, 'e2801170000002161d2dd4cc');
INSERT INTO tag(tagindex, tagid) VALUES (44, 'e2801170000002161d2da02c');
INSERT INTO tag(tagindex, tagid) VALUES (45, 'e2801170000002161d2d6cdd');
INSERT INTO tag(tagindex, tagid) VALUES (46, 'e2801170000002161d2da03c');
INSERT INTO tag(tagindex, tagid) VALUES (47, 'e2801170000002161d2d5a4d');
INSERT INTO tag(tagindex, tagid) VALUES (48, 'e2801170000002161d2d5aed');
INSERT INTO tag(tagindex, tagid) VALUES (49, 'e2801170000002161d2d6cbd');
INSERT INTO tag(tagindex, tagid) VALUES (50, 'e2801170000002161d2da01d');
INSERT INTO tag(tagindex, tagid) VALUES (51, 'e2801170000002161d2e08cb');
INSERT INTO tag(tagindex, tagid) VALUES (52, 'e2801170000002161d2dc26d');
INSERT INTO tag(tagindex, tagid) VALUES (53, 'e2801170000002161d2d5a9d');
INSERT INTO tag(tagindex, tagid) VALUES (54, 'e2801170000002161d2e3c4b');
INSERT INTO tag(tagindex, tagid) VALUES (55, 'e2801170000002161d2e2a8b');
INSERT INTO tag(tagindex, tagid) VALUES (56, 'e2801170000002161d2da07c');
INSERT INTO tag(tagindex, tagid) VALUES (57, 'e2801170000002161d2d5acc');
INSERT INTO tag(tagindex, tagid) VALUES (58, 'e2801170000002161d2e3c6b');
INSERT INTO tag(tagindex, tagid) VALUES (59, 'e2801170000002161d2d6a9e');
INSERT INTO tag(tagindex, tagid) VALUES (60, 'e2801170000002161d2e3c1b');
INSERT INTO tag(tagindex, tagid) VALUES (61, 'e2801170000002161d2dc28d');
INSERT INTO tag(tagindex, tagid) VALUES (62, 'e2801170000002161d2d5a8c');
INSERT INTO tag(tagindex, tagid) VALUES (63, 'e2801170000002161d2d5a7c');
INSERT INTO tag(tagindex, tagid) VALUES (64, 'e2801170000002161d2d6cec');
INSERT INTO tag(tagindex, tagid) VALUES (65, 'e2801170000002161d2d6c7c');
INSERT INTO tag(tagindex, tagid) VALUES (66, 'e2801170000002161d2d5a3c');
INSERT INTO tag(tagindex, tagid) VALUES (67, 'e2801170000002161d2d6c5c');
INSERT INTO tag(tagindex, tagid) VALUES (68, 'e2801170000002161d2d5a4c');
INSERT INTO tag(tagindex, tagid) VALUES (69, 'e2801170000002161d2d5a6c');
INSERT INTO tag(tagindex, tagid) VALUES (70, 'e2801170000002161d2d5a5c');
INSERT INTO tag(tagindex, tagid) VALUES (71, 'e2801170000002161d2e2a9b');
INSERT INTO tag(tagindex, tagid) VALUES (72, 'e2801170000002161d2e2acb');
INSERT INTO tag(tagindex, tagid) VALUES (73, 'e2801170000002161d2d5adc');
INSERT INTO tag(tagindex, tagid) VALUES (74, 'e2801170000002161d2dd4ab');
INSERT INTO tag(tagindex, tagid) VALUES (75, 'e2801170000002161d2d5abd');
INSERT INTO tag(tagindex, tagid) VALUES (76, 'e2801170000002161d2dd43b');
INSERT INTO tag(tagindex, tagid) VALUES (77, 'e2801170000002161d2dd48b');
INSERT INTO tag(tagindex, tagid) VALUES (78, 'e2801170000002161d2d6ace');
INSERT INTO tag(tagindex, tagid) VALUES (79, 'e2801170000002161d2dd45b');
INSERT INTO tag(tagindex, tagid) VALUES (80, 'e2801170000002161d2dd44b');
INSERT INTO tag(tagindex, tagid) VALUES (81, 'e2801170000002161d2d6a6e');
INSERT INTO tag(tagindex, tagid) VALUES (82, 'e2801170000002161d2d6c2c');
INSERT INTO tag(tagindex, tagid) VALUES (83, 'e2801170000002161d2dc24c');
INSERT INTO tag(tagindex, tagid) VALUES (84, 'e2801170000002161d2dc28c');
INSERT INTO tag(tagindex, tagid) VALUES (85, 'e2801170000002161d2dd40c');
INSERT INTO tag(tagindex, tagid) VALUES (86, 'e2801170000002161d2dd42c');
INSERT INTO tag(tagindex, tagid) VALUES (87, 'e2801170000002161d2e080c');
INSERT INTO tag(tagindex, tagid) VALUES (88, 'e2801170000002161d2dd49c');
INSERT INTO tag(tagindex, tagid) VALUES (89, 'e2801170000002161d2d5a5d');
INSERT INTO tag(tagindex, tagid) VALUES (90, 'e2801170000002161d2d6c0c');
INSERT INTO tag(tagindex, tagid) VALUES (91, 'e2801170000002161d2d6c3d');
INSERT INTO tag(tagindex, tagid) VALUES (92, 'e2801170000002161d2dc2bd');
INSERT INTO tag(tagindex, tagid) VALUES (93, 'e2801170000002161d2dc22d');
INSERT INTO tag(tagindex, tagid) VALUES (94, 'e2801170000002161d2dc25d');
INSERT INTO tag(tagindex, tagid) VALUES (95, 'e2801170000002161d2dc2cd');
INSERT INTO tag(tagindex, tagid) VALUES (96, 'e2801170000002161d2dc21c');
INSERT INTO tag(tagindex, tagid) VALUES (97, 'e2801170000002161d2d6c2d');
INSERT INTO tag(tagindex, tagid) VALUES (98, 'e2801170000002161d2d6cfd');
INSERT INTO tag(tagindex, tagid) VALUES (99, 'e2801170000002161d2dc20d');
INSERT INTO tag(tagindex, tagid) VALUES (100, 'e2801170000002161d2da0ad');
INSERT INTO tag(tagindex, tagid) VALUES (101, 'e2801170000002161d2d6ccd');
INSERT INTO tag(tagindex, tagid) VALUES (102, 'e2801170000002161d2d5aad');
INSERT INTO tag(tagindex, tagid) VALUES (103, 'e2801170000002161d2d5afd');
INSERT INTO tag(tagindex, tagid) VALUES (104, 'e2801170000002161d2d6c4d');
INSERT INTO tag(tagindex, tagid) VALUES (105, 'e2801170000002161d2d5a6d');
INSERT INTO tag(tagindex, tagid) VALUES (106, 'e2801170000002161d2d5a7d');
INSERT INTO tag(tagindex, tagid) VALUES (107, 'e2801170000002161d2dc2dd');
INSERT INTO tag(tagindex, tagid) VALUES (108, 'e2801170000002161d2dc24d');
INSERT INTO tag(tagindex, tagid) VALUES (109, 'e2801170000002161d2d5a8d');
INSERT INTO tag(tagindex, tagid) VALUES (110, 'e2801170000002161d2dc29d');
INSERT INTO tag(tagindex, tagid) VALUES (111, 'e2801170000002161d2dd4ec');
INSERT INTO tag(tagindex, tagid) VALUES (112, 'e2801170000002161d2dd4ac');
INSERT INTO tag(tagindex, tagid) VALUES (113, 'e2801170000002161d2e3c8b');
INSERT INTO tag(tagindex, tagid) VALUES (114, 'e2801170000002161d2e2aab');
INSERT INTO tag(tagindex, tagid) VALUES (115, 'e2801170000002161d2dd4dc');
INSERT INTO tag(tagindex, tagid) VALUES (116, 'e2801170000002161d2dd49b');
INSERT INTO tag(tagindex, tagid) VALUES (117, 'e2801170000002161d2dd4fc');
INSERT INTO tag(tagindex, tagid) VALUES (118, 'e2801170000002161d2e2a5b');
INSERT INTO tag(tagindex, tagid) VALUES (119, 'e2801170000002161d2e2a6b');
INSERT INTO tag(tagindex, tagid) VALUES (120, 'e2801170000002161d2e3c5b');
INSERT INTO tag(tagindex, tagid) VALUES (121, 'e2801170000002161d2dc2ac');
INSERT INTO tag(tagindex, tagid) VALUES (122, 'e2801170000002161d2d6c0d');
INSERT INTO tag(tagindex, tagid) VALUES (123, 'e2801170000002161d2da05c');
INSERT INTO tag(tagindex, tagid) VALUES (124, 'e2801170000002161d2dc20c');
INSERT INTO tag(tagindex, tagid) VALUES (125, 'e2801170000002161d2d5a9c');
INSERT INTO tag(tagindex, tagid) VALUES (126, 'e2801170000002161d2d5aac');
INSERT INTO tag(tagindex, tagid) VALUES (127, 'e2801170000002161d2da06c');
INSERT INTO tag(tagindex, tagid) VALUES (128, 'e2801170000002161d2d5afc');
INSERT INTO tag(tagindex, tagid) VALUES (129, 'e2801170000002161d2dc2cc');
INSERT INTO tag(tagindex, tagid) VALUES (130, 'e2801170000002161d2d5aec');
INSERT INTO tag(tagindex, tagid) VALUES (131, 'e2801170000002161d2dc21d');
INSERT INTO tag(tagindex, tagid) VALUES (132, 'e2801170000002161d2da04c');
INSERT INTO tag(tagindex, tagid) VALUES (133, 'e2801170000002161d2d5add');
INSERT INTO tag(tagindex, tagid) VALUES (134, 'e2801170000002161d2da05d');
INSERT INTO tag(tagindex, tagid) VALUES (135, 'e2801170000002161d2da00d');
INSERT INTO tag(tagindex, tagid) VALUES (136, 'e2801170000002161d2dd41c');
INSERT INTO tag(tagindex, tagid) VALUES (137, 'e2801170000002161d2da09d');
INSERT INTO tag(tagindex, tagid) VALUES (138, 'e2801170000002161d2da02d');
INSERT INTO tag(tagindex, tagid) VALUES (139, 'e2801170000002161d2da03d');
INSERT INTO tag(tagindex, tagid) VALUES (140, 'e2801170000002161d2d5a3d');
INSERT INTO tag(tagindex, tagid) VALUES (141, 'e2801170000002161d2d5abc');
INSERT INTO tag(tagindex, tagid) VALUES (142, 'e2801170000002161d2d6cac');
INSERT INTO tag(tagindex, tagid) VALUES (143, 'e2801170000002161d2e3c2b');
INSERT INTO tag(tagindex, tagid) VALUES (144, 'e2801170000002161d2e2abb');
INSERT INTO tag(tagindex, tagid) VALUES (145, 'e2801170000002161d2e2a7b');
INSERT INTO tag(tagindex, tagid) VALUES (146, 'e2801170000002161d2e08ab');
INSERT INTO tag(tagindex, tagid) VALUES (147, 'e2801170000002161d2d6c4c');
INSERT INTO tag(tagindex, tagid) VALUES (148, 'e2801170000002161d2e2adb');
INSERT INTO tag(tagindex, tagid) VALUES (149, 'e2801170000002161d2e3c0b');
INSERT INTO tag(tagindex, tagid) VALUES (150, 'e2801170000002161d2dd4eb');
INSERT INTO tag(tagindex, tagid) VALUES (151, 'e2801170000002161d2d8d74');
INSERT INTO tag(tagindex, tagid) VALUES (152, 'e2801170000002161d2e2134');
INSERT INTO tag(tagindex, tagid) VALUES (153, 'e2801170000002161d2e2144');
INSERT INTO tag(tagindex, tagid) VALUES (154, 'e2801170000002161d2d8df4');
INSERT INTO tag(tagindex, tagid) VALUES (155, 'e2801170000002161d2df594');
INSERT INTO tag(tagindex, tagid) VALUES (156, 'e2801170000002161d2ddb64');
INSERT INTO tag(tagindex, tagid) VALUES (157, 'e2801170000002161d2db934');
INSERT INTO tag(tagindex, tagid) VALUES (158, 'e2801170000002161d2d7c4e');
INSERT INTO tag(tagindex, tagid) VALUES (159, 'e2801170000002161d2db944');
INSERT INTO tag(tagindex, tagid) VALUES (160, 'e2801170000002161d2db924');
INSERT INTO tag(tagindex, tagid) VALUES (161, 'e2801170000002161d2ddb04');
INSERT INTO tag(tagindex, tagid) VALUES (162, 'e2801170000002161d2ddbc4');
INSERT INTO tag(tagindex, tagid) VALUES (163, 'e2801170000002161d2ddb34');
INSERT INTO tag(tagindex, tagid) VALUES (164, 'e2801170000002161d2ddb84');
INSERT INTO tag(tagindex, tagid) VALUES (165, 'e2801170000002161d2ddb54');
INSERT INTO tag(tagindex, tagid) VALUES (166, 'e2801170000002161d2df5d4');
INSERT INTO tag(tagindex, tagid) VALUES (167, 'e2801170000002161d2ddb44');
INSERT INTO tag(tagindex, tagid) VALUES (168, 'e2801170000002161d2db9f4');
INSERT INTO tag(tagindex, tagid) VALUES (169, 'e2801170000002161d2ddb14');
INSERT INTO tag(tagindex, tagid) VALUES (170, 'e2801170000002161d2db9b4');
INSERT INTO tag(tagindex, tagid) VALUES (171, 'e2801170000002161d2df554');
INSERT INTO tag(tagindex, tagid) VALUES (172, 'e2801170000002161d2df524');
INSERT INTO tag(tagindex, tagid) VALUES (173, 'e2801170000002161d2df514');
INSERT INTO tag(tagindex, tagid) VALUES (174, 'e2801170000002161d2df544');
INSERT INTO tag(tagindex, tagid) VALUES (175, 'e2801170000002161d2ddbe4');
INSERT INTO tag(tagindex, tagid) VALUES (176, 'e2801170000002161d2df504');
INSERT INTO tag(tagindex, tagid) VALUES (177, 'e2801170000002161d2ddbb4');
INSERT INTO tag(tagindex, tagid) VALUES (178, 'e2801170000002161d2ddbd4');
INSERT INTO tag(tagindex, tagid) VALUES (179, 'e2801170000002161d2ddb74');
INSERT INTO tag(tagindex, tagid) VALUES (180, 'e2801170000002161d2ddb94');
INSERT INTO tag(tagindex, tagid) VALUES (181, 'e2801170000002161d2db9e4');
INSERT INTO tag(tagindex, tagid) VALUES (182, 'e2801170000002161d2df5a4');
INSERT INTO tag(tagindex, tagid) VALUES (183, 'e2801170000002161d2db9d4');
INSERT INTO tag(tagindex, tagid) VALUES (184, 'e2801170000002161d2db9a4');
INSERT INTO tag(tagindex, tagid) VALUES (185, 'e2801170000002161d2db9c4');
INSERT INTO tag(tagindex, tagid) VALUES (186, 'e2801170000002161d2db974');
INSERT INTO tag(tagindex, tagid) VALUES (187, 'e2801170000002161d2db994');
INSERT INTO tag(tagindex, tagid) VALUES (188, 'e2801170000002161d2db964');
INSERT INTO tag(tagindex, tagid) VALUES (189, 'e2801170000002161d2db984');
INSERT INTO tag(tagindex, tagid) VALUES (190, 'e2801170000002161d2df5c4');
INSERT INTO tag(tagindex, tagid) VALUES (191, 'e2801170000002161d2da04d');
INSERT INTO tag(tagindex, tagid) VALUES (192, 'e2801170000002161d2dc2ec');
INSERT INTO tag(tagindex, tagid) VALUES (193, 'e2801170000002161d2e3c3b');
INSERT INTO tag(tagindex, tagid) VALUES (194, 'e2801170000002161d2e084c');
INSERT INTO tag(tagindex, tagid) VALUES (195, 'e2801170000002161d2e083c');
INSERT INTO tag(tagindex, tagid) VALUES (196, 'e2801170000002161d2e082c');
INSERT INTO tag(tagindex, tagid) VALUES (197, 'e2801170000002161d2dd43c');
INSERT INTO tag(tagindex, tagid) VALUES (198, 'e2801170000002161d2dd4cb');
INSERT INTO tag(tagindex, tagid) VALUES (199, 'e2801170000002161d2d6a7e');
INSERT INTO tag(tagindex, tagid) VALUES (200, 'e2801170000002161d2e08eb');
INSERT INTO tag(tagindex, tagid) VALUES (201, 'e2801170000002161d2d73d5');
INSERT INTO tag(tagindex, tagid) VALUES (202, 'e2801170000002161d2d73c5');
INSERT INTO tag(tagindex, tagid) VALUES (203, 'e2801170000002161d2d8d24');
INSERT INTO tag(tagindex, tagid) VALUES (204, 'e2801170000002161d2d8dc4');
INSERT INTO tag(tagindex, tagid) VALUES (205, 'e2801170000002161d2d8d44');
INSERT INTO tag(tagindex, tagid) VALUES (206, 'e2801170000002161d2d73f4');
INSERT INTO tag(tagindex, tagid) VALUES (207, 'e2801170000002161d2d8d14');
INSERT INTO tag(tagindex, tagid) VALUES (208, 'e2801170000002161d2d73e4');
INSERT INTO tag(tagindex, tagid) VALUES (209, 'e2801170000002161d2d8d04');
INSERT INTO tag(tagindex, tagid) VALUES (210, 'e2801170000002161d2d73e5');
INSERT INTO tag(tagindex, tagid) VALUES (211, 'e2801170000002161d2d6c9c');
INSERT INTO tag(tagindex, tagid) VALUES (212, 'e2801170000002161d2d6c8c');
INSERT INTO tag(tagindex, tagid) VALUES (213, 'e2801170000002161d2d6cbc');
INSERT INTO tag(tagindex, tagid) VALUES (214, 'e2801170000002161d2d6cdc');
INSERT INTO tag(tagindex, tagid) VALUES (215, 'e2801170000002161d2d6cfc');
INSERT INTO tag(tagindex, tagid) VALUES (216, 'e2801170000002161d2d6ccc');
INSERT INTO tag(tagindex, tagid) VALUES (217, 'e2801170000002161d2d6c1d');
INSERT INTO tag(tagindex, tagid) VALUES (218, 'e2801170000002161d2dc27d');
INSERT INTO tag(tagindex, tagid) VALUES (219, 'e2801170000002161d2dd44c');
INSERT INTO tag(tagindex, tagid) VALUES (220, 'e2801170000002161d2d6c3c');
INSERT INTO tag(tagindex, tagid) VALUES (221, 'e2801170000002161d2e2114');
INSERT INTO tag(tagindex, tagid) VALUES (222, 'e2801170000002161d2df5e4');
INSERT INTO tag(tagindex, tagid) VALUES (223, 'e2801170000002161d2e2104');
INSERT INTO tag(tagindex, tagid) VALUES (224, 'e2801170000002161d2df5b4');
INSERT INTO tag(tagindex, tagid) VALUES (225, 'e2801170000002161d2e2124');
INSERT INTO tag(tagindex, tagid) VALUES (226, 'e2801170000002161d2ddba4');
INSERT INTO tag(tagindex, tagid) VALUES (227, 'e2801170000002161d2df5f4');
INSERT INTO tag(tagindex, tagid) VALUES (228, 'e2801170000002161d2e2184');
INSERT INTO tag(tagindex, tagid) VALUES (229, 'e2801170000002161d2d7334');
INSERT INTO tag(tagindex, tagid) VALUES (230, 'e2801170000002161d2d7364');
INSERT INTO tag(tagindex, tagid) VALUES (231, 'e2801170000002161d2d8d64');
INSERT INTO tag(tagindex, tagid) VALUES (232, 'e2801170000002161d2d8d84');
INSERT INTO tag(tagindex, tagid) VALUES (233, 'e2801170000002161d2d8d34');
INSERT INTO tag(tagindex, tagid) VALUES (234, 'e2801170000002161d2d8d54');
INSERT INTO tag(tagindex, tagid) VALUES (235, 'e2801170000002161d2db914');
INSERT INTO tag(tagindex, tagid) VALUES (236, 'e2801170000002161d2d8de4');
INSERT INTO tag(tagindex, tagid) VALUES (237, 'e2801170000002161d2d8da4');
INSERT INTO tag(tagindex, tagid) VALUES (238, 'e2801170000002161d2d8dd4');
INSERT INTO tag(tagindex, tagid) VALUES (239, 'e2801170000002161d2d8db4');
INSERT INTO tag(tagindex, tagid) VALUES (240, 'e2801170000002161d2db904');
INSERT INTO tag(tagindex, tagid) VALUES (241, 'e2801170000002161d2ddbf4');
INSERT INTO tag(tagindex, tagid) VALUES (242, 'e2801170000002161d2df564');
INSERT INTO tag(tagindex, tagid) VALUES (243, 'e2801170000002161d2df574');
INSERT INTO tag(tagindex, tagid) VALUES (244, 'e2801170000002161d2d7384');
INSERT INTO tag(tagindex, tagid) VALUES (245, 'e2801170000002161d2d7374');
INSERT INTO tag(tagindex, tagid) VALUES (246, 'e2801170000002161d2d73c4');
INSERT INTO tag(tagindex, tagid) VALUES (247, 'e2801170000002161d2d7394');
INSERT INTO tag(tagindex, tagid) VALUES (248, 'e2801170000002161d2d73b4');
INSERT INTO tag(tagindex, tagid) VALUES (249, 'e2801170000002161d2d73d4');
INSERT INTO tag(tagindex, tagid) VALUES (250, 'e2801170000002161d2d73a4');
INSERT INTO tag(tagindex, tagid) VALUES (251, 'e2801170000002161d2d73b5');
INSERT INTO tag(tagindex, tagid) VALUES (252, 'e2801170000002161d2d73a5');
INSERT INTO tag(tagindex, tagid) VALUES (253, 'e2801170000002161d2d7385');
INSERT INTO tag(tagindex, tagid) VALUES (254, 'e2801170000002161d2d6afe');
INSERT INTO tag(tagindex, tagid) VALUES (255, 'e2801170000002161d2d7365');
INSERT INTO tag(tagindex, tagid) VALUES (256, 'e2801170000002161d2d7354');
INSERT INTO tag(tagindex, tagid) VALUES (257, 'e2801170000002161d2d7345');
INSERT INTO tag(tagindex, tagid) VALUES (258, 'e2801170000002161d2d7395');
INSERT INTO tag(tagindex, tagid) VALUES (259, 'e2801170000002161d2d7375');
INSERT INTO tag(tagindex, tagid) VALUES (260, 'e2801170000002161d2d7355');
INSERT INTO tag(tagindex, tagid) VALUES (261, 'e2801170000002161d2dc2fb');
INSERT INTO tag(tagindex, tagid) VALUES (262, 'e2801170000002161d2e082b');
INSERT INTO tag(tagindex, tagid) VALUES (263, 'e2801170000002161d2e084b');
INSERT INTO tag(tagindex, tagid) VALUES (264, 'e2801170000002161d2dd45c');
INSERT INTO tag(tagindex, tagid) VALUES (265, 'e2801170000002161d2e08db');
INSERT INTO tag(tagindex, tagid) VALUES (266, 'e2801170000002161d2dd4fb');
INSERT INTO tag(tagindex, tagid) VALUES (267, 'e2801170000002161d2e08fb');
INSERT INTO tag(tagindex, tagid) VALUES (268, 'e2801170000002161d2e08bb');
INSERT INTO tag(tagindex, tagid) VALUES (269, 'e2801170000002161d2e2a1b');
INSERT INTO tag(tagindex, tagid) VALUES (270, 'e2801170000002161d2e085b');
INSERT INTO tag(tagindex, tagid) VALUES (271, 'e2801170000002161d2d6c8d');
INSERT INTO tag(tagindex, tagid) VALUES (272, 'e2801170000002161d2dd48c');
INSERT INTO tag(tagindex, tagid) VALUES (273, 'e2801170000002161d2d6c9d');
INSERT INTO tag(tagindex, tagid) VALUES (274, 'e2801170000002161d2dc2fd');
INSERT INTO tag(tagindex, tagid) VALUES (275, 'e2801170000002161d2dc2ad');
INSERT INTO tag(tagindex, tagid) VALUES (276, 'e2801170000002161d2dc23d');
INSERT INTO tag(tagindex, tagid) VALUES (277, 'e2801170000002161d2da0ed');
INSERT INTO tag(tagindex, tagid) VALUES (278, 'e2801170000002161d2dd41d');
INSERT INTO tag(tagindex, tagid) VALUES (279, 'e2801170000002161d2dd40d');
INSERT INTO tag(tagindex, tagid) VALUES (280, 'e2801170000002161d2dd41b');
INSERT INTO tag(tagindex, tagid) VALUES (281, 'e2801170000002161d2e087b');
INSERT INTO tag(tagindex, tagid) VALUES (282, 'e2801170000002161d2e083b');
INSERT INTO tag(tagindex, tagid) VALUES (283, 'e2801170000002161d2e088b');
INSERT INTO tag(tagindex, tagid) VALUES (284, 'e2801170000002161d2e081b');
INSERT INTO tag(tagindex, tagid) VALUES (285, 'e2801170000002161d2e080b');
INSERT INTO tag(tagindex, tagid) VALUES (286, 'e2801170000002161d2dd47b');
INSERT INTO tag(tagindex, tagid) VALUES (287, 'e2801170000002161d2dd4bb');
INSERT INTO tag(tagindex, tagid) VALUES (288, 'e2801170000002161d2e086b');
INSERT INTO tag(tagindex, tagid) VALUES (289, 'e2801170000002161d2dd4db');
INSERT INTO tag(tagindex, tagid) VALUES (290, 'e2801170000002161d2e089b');

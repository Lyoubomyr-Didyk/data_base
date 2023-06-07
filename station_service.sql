DROP TABLE IF EXISTS pdv;
DROP TABLE IF EXISTS fuel;
DROP TABLE IF EXISTS pdv_fuel_price;
DROP TABLE IF EXISTS pdv_fuel_stock;
DROP TABLE IF EXISTS service;
DROP TABLE IF EXISTS pdv_service;
DROP TABLE IF EXISTS hours;
DROP TABLE IF EXISTS closed;

CREATE TABLE pdv (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    latitude INTEGER,
    longitude INTEGER,
    address TEXT NOT NULL ,
    postal_code TEXT NOT NULL ,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    type TEXT CHECK ( type = 'A' OR type = 'R' ),
    automate_24 BOOLEAN NOT NULL
);

CREATE TABLE fuel (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT
);

CREATE TABLE pdv_fuel_price (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    value TEXT NOT NULL,
    date_update  DATE DEFAULT (datetime('now', 'localtime')),
    fuel_id INTEGER,
    pdv_id INTEGER,
    foreign key (fuel_id) references fuel (id),
    foreign key (pdv_id) references pdv (id)
);

CREATE TABLE pdv_fuel_stock (
    id INTEGER PRIMARY KEY NOT NULL,
    start DATETIME,
    end DATETIME,
    fuel_id INTEGER,
    pdv_id INTEGER,
    foreign key (fuel_id) references fuel (id),
    foreign key (pdv_id) references pdv (id)
);

CREATE TABLE service (
    name TEXT PRIMARY KEY NOT NULL
);

CREATE TABLE pdv_service(
    pdv_id INTEGER,
    service_name TEXT,
    PRIMARY KEY (pdv_id, service_name),
    foreign key (pdv_id) references pdv (id),
    foreign key (service_name) references service (name)
);

CREATE TABLE hours (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    day TEXT,
    closed BOOLEAN,
    opening_hours TEXT,
    closing_hours TEXT,
    pdv_id INTEGER,
    foreign key (pdv_id) references pdv (id)
);

CREATE TABLE closed (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    type TEXT CHECK ( type = 'definitely' OR type = 'temporarily' ),
    start DATETIME,
    end DATETIME,
    pdv_id INTEGER,
    foreign key (pdv_id) references pdv (id)

);

--------------------------------------------insert-----------------------------------------------------

-- insert pdv
INSERT INTO
    pdv (latitude, longitude, address, postal_code, city, country, type, automate_24)
VALUES (45.895879, 6.07599, '60 Route des Creuses', '74960', 'Annecy', 'France', 'R' , true),
       (45.907864, 6.14024, '18 Boulevard de la Rocade', '74000', 'Annecy', 'France', 'R' , true),
       (45.9066215, 6.1106541, '18 Rue de la Poterie', '74960', 'Cran-Gevrier', 'France', 'R' , true);


-- insert fuel
INSERT INTO
    fuel (name)
VALUES ('E10'),
       ('DIESEL'),
       ('SP98'),
       ('GPL'),
       ('E85');


-- insert pdv_fuel_price
INSERT INTO
    pdv_fuel_price (value, fuel_id, pdv_id)
VALUES ('1,799€', 1, 1),
       ('1,647€', 2, 1),
       ('1,889€', 3, 1),
       ('1,848€', 1, 2),
       ('1,179€', 5, 2),
       ('1,686€', 2, 2),
       ('0,929€', 4, 2),
       ('1,929€', 3, 2),
       ('1,848€', 1, 3),
       ('1,686€', 2, 3),
       ('1,928€', 3, 3);


-- insert service
INSERT INTO
    service (name)
VALUES ('24h24'),
       ('vente-de-gaz-domestique'),
       ('automate-cb'),
       ('station-de-gonflage');


-- insert pdv_service
INSERT INTO
    pdv_service (pdv_id, service_name)
VALUES (1, '24h24' ),
       (1, 'vente-de-gaz-domestique' ),
       (1, 'automate-cb' ),
       (2, '24h24' ),
       (3, '24h24' ),
       (3, 'automate-cb' ),
       (3, 'station-de-gonflage' );


-- insert pdv_fuel_stock
INSERT INTO
    pdv_fuel_stock (start, end, fuel_id, pdv_id)
VALUES ( datetime('2023-06-07 08:00:00'), datetime('now', '+5 days', 'localtime'), 2, 1 ),
       ( datetime('2023-06-07 08:00:00'), datetime('now', '+10 days', 'localtime'), 4, 2 );


-- insert closed
INSERT INTO
    closed ( type, start, end, pdv_id)
VALUES ('temporarily', datetime('2023-06-10 08:00:00'), datetime('2023-06-17 08:00:00'), 3 );


-- insert hours
INSERT INTO
    hours (day, closed, opening_hours, closing_hours, pdv_id )
VALUES ('Monday', false, '07:00', '22:00', 1);


SELECT * FROM  hours;

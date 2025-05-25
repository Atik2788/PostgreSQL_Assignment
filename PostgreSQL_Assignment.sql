-- Active: 1747503120726@@127.0.0.1@5432@conservation_db

-- creating database:
CREATE DATABASE conservation_db;



-- creating rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NUll
);
DROP TABLE rangers;
-- INSERT INTO rangers(name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');
SELECT * FROM rangers;



-- creating species table
CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE DEFAULT CURRENT_DATE,
    conservation_status VARCHAR(50) CHECK(conservation_status = 'Endangered' OR conservation_status = 'Vulnerable')
);
-- DROP TABLE species;
SELECT * from species;
-- INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



-- creating sightings table
CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(50),
    notes VARCHAR(100)
);
DROP TABLE sightings;
SELECT * FROM sightings;
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES
    (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
    (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
    (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
    (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);









-- Problem 1: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
-- Problem 1: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers(name, region) VALUES('Derek Fox', 'Coastal Plains')



-- Problem 2: Count unique species ever sighted.
-- Problem 2: Count unique species ever sighted.
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings;



-- Problem 3: Find all sightings where the location includes "Pass".
-- Problem 3: Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location ILIKE '%pass%';



-- Problem 4: List each ranger's name and their total number of sightings.
-- Problem 4: List each ranger's name and their total number of sightings.
SELECT name, count(sighting_id) as total_sightings FROM rangers
    JOIN sightings USING (ranger_id)
        GROUP BY name;



-- Problem 5: List species that have never been sighted.
-- Problem 5: List species that have never been sighted.
SELECT common_name FROM species
    WHERE NOT EXISTS  (
        SELECT 1
        FROM sightings
        WHERE species.species_id = sightings.species_id
    )



-- Problem 6: Show the most recent 2 sightings.
-- Problem 6: Show the most recent 2 sightings.
SELECT common_name, sighting_time, name FROM species
    JOIN sightings ON species.species_id = sightings.species_id
    JOIN rangers ON rangers.ranger_id = sightings.ranger_id
    ORDER BY sightings.sighting_time DESC LIMIT 2;



-- Problem 7: Update all species discovered before year 1800 to have status 'Historic'.
-- Problem 7: Update all species discovered before year 1800 to have status 'Historic'.
CREATE OR REPLACE FUNCTION update_conservation_status()
RETURNS void AS
$$
BEGIN
    -- Drop the CONSTRAINT ofspecies_conservation
    ALTER TABLE species
        DROP CONSTRAINT IF EXISTS species_conservation_status_check;

    -- Add new check CONSTRAINT ofspecies_conservation
    ALTER TABLE species
        ADD CONSTRAINT species_conservation_status_check
        CHECK (conservation_status IN('Endangered', 'Vulnerable', 'Historic'));

    -- Update the conservation_status
    UPDATE species 
        SET conservation_status = 'Historic' 
            WHERE species.discovery_date < DATE '1800-01-01';
END;
$$
LANGUAGE plpgsql;

-- run the function for replace conservation_status
SELECT update_conservation_status();



-- Problem 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
-- Problem 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id,
     CASE
        WHEN sighting_time::TIMESTAMP::TIME < TIME '12:00:00' THEN 'Morning'
        WHEN sighting_time::TIMESTAMP::TIME BETWEEN TIME '12:00:00' AND TIME '17:00:00' THEN 'Afternoon'
        WHEN sighting_time::TIMESTAMP::TIME > TIME '17:00:00' THEN 'Evening'
    END AS time_of_day
FROM sightings;


-- Problem 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name varcahr(80) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg NUMERIC(5,2) NOT NULL
);

-- Add a column 'species' of type 'string'
ALTER TABLE animals
ADD COLUMN species varchar(80);

-- Create owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(150),
    age INT
);

-- Create species table
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(150)
);

-- Add PRIMARY KEY to owners, and species tables
ALTER TABLE owners
ADD PRIMARY KEY(id);

ALTER TABLE species
ADD PRIMARY KEY(id);

-- Add required changes to animals table 
ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN IF EXISTS species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(80),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY(vet_id, species_id),
    CONSTRAINT fk_vet_id
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species
    FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date),
    CONSTRAINT fk_animal_id
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vet
    FOREIGN KEY(vet_id) REFERENCES vets(id)
);

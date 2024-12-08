drop table if exists publisher cascade;
drop table if exists book cascade;
drop table if exists books_authors;
drop table if exists author cascade;
drop table if exists "library" cascade;
drop table if exists book_issuance;
drop table if exists reader;

CREATE TABLE author (
    id SERIAL,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE book (
    id SERIAL,
    title VARCHAR(100),
    publisher_id INT,
    "edition" VARCHAR(100),
    publication_year INT,
    library_id INT
);

CREATE TABLE publisher (
    id SERIAL,
    "name" VARCHAR(100)
);

CREATE TABLE "library" (
    id SERIAL,
    "address" VARCHAR(100)
);

CREATE TABLE books_authors(
    author_id serial,
    book_id serial
);

CREATE TABLE book_issuance(
    id SERIAL,
    book_id INT,
    date_of_issue DATE,
    expected_return_date DATE,
    date_of_the_actual DATE,
    reader_id INT
);

CREATE TABLE reader (
    id SERIAL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    gender CHAR(1),
    education_level VARCHAR(50)
);

ALTER TABLE author
ADD PRIMARY KEY (id),
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE publisher
ADD PRIMARY KEY (id),
ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "library"
ADD PRIMARY KEY (id),
ALTER COLUMN address SET NOT NULL;

ALTER TABLE book
ADD PRIMARY KEY (id),
ALTER COLUMN title SET NOT NULL,
ALTER COLUMN edition SET NOT NULL,
ALTER COLUMN publication_year SET NOT NULL,
ADD FOREIGN KEY (publisher_id) REFERENCES publisher(id) ON DELETE cascade on update cascade,
ADD FOREIGN KEY (library_id) REFERENCES "library"(id) ON DELETE cascade on update cascade,
ADD CONSTRAINT publication_year CHECK (publication_year >= 1500);

ALTER TABLE books_authors
ADD PRIMARY KEY (author_id, book_id),
ADD FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE cascade on update cascade,
ADD FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE cascade on update cascade;

ALTER TABLE reader
ADD PRIMARY KEY (id),
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL,
ALTER COLUMN birth_date SET NOT NULL,
ALTER COLUMN gender SET NOT NULL,
ALTER COLUMN education_level SET NOT null,
ADD CONSTRAINT check_gender CHECK (gender IN ('M', 'W'));

ALTER TABLE book_issuance
ADD PRIMARY KEY (id),
ADD FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE cascade on update cascade,
ALTER COLUMN date_of_issue SET NOT NULL,
ALTER COLUMN expected_return_date SET NOT NULL,
ADD FOREIGN KEY (reader_id) REFERENCES reader(id) ON DELETE set null on update cascade;
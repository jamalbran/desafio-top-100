DROP DATABASE peliculas;
CREATE DATABASE peliculas;

\c peliculas;

\echo '1. Crear base de datos llamada películas.'

CREATE TABLE peliculas(
  id INT,
  pelicula VARCHAR,
  "Año Estreno" INT,
  Director VARCHAR,
  PRIMARY KEY (id)
);

CREATE TABLE reparto(
  id INT,
  Actor VARCHAR,
  FOREIGN KEY (id) REFERENCES peliculas(id)
);

\echo '2. Cargar ambos archivos a su tabla correspondiente.'

\COPY peliculas FROM 'peliculas.csv' CSV HEADER;

\COPY reparto FROM 'reparto.csv' CSV;

\echo '3. Obtener el ID de la película “Titanic”.'

SELECT pelicula, id FROM peliculas WHERE pelicula = 'Titanic';

\echo '4. Listar a todos los actores que aparecen en la película "Titanic".'

SELECT p.pelicula, r.Actor FROM reparto r
  LEFT JOIN peliculas p
    ON r.id = p.id
  WHERE p.pelicula = 'Titanic';

\echo '5. Consultar en cuántas películas del top 100 participa Harrison Ford.'

SELECT COUNT(DISTINCT id) peliculas_con_Harrison_Ford FROM reparto WHERE actor = 'Harrison Ford';

\echo '6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.'

SELECT * FROM peliculas 
  WHERE "Año Estreno" BETWEEN 1990 AND 1999
  ORDER BY pelicula ASC;

\echo '7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.'

SELECT pelicula, LENGTH(pelicula) AS longitud FROM peliculas;

\echo '8. Consultar cual es la longitud más grande entre todos los títulos de las películas.'

SELECT MAX(LENGTH(pelicula)) AS mayor_longitud_de_titulo FROM peliculas;

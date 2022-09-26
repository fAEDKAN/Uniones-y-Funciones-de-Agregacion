-- queremos conocer, por un lado, los títulos y el
-- nombre del género de todas las series de la base de datos. 
SELECT title, name
FROM series
INNER JOIN genres ON series.genre_id = genres.id;

-- Por otro, necesitamos listar los títulos de los episodios junto con el 
-- nombre y apellido de los actores que trabajan en cada
-- uno de ellos
SELECT episodes.title, actors.first_name, actors.last_name
FROM episodes
INNER JOIN actor_episode ON actor_episode.episode_id = episodes.id
INNER JOIN actors ON actors.id = actor_episode.actor_id;

-- Para nuestro próximo desafío necesitamos obtener a todos los actores 
-- o actrices (mostrar nombre y apellido) que han trabajado en cualquier 
-- película de la saga de la Guerra de las galaxias, pero ¡cuidado!: 
-- debemos asegurarnos de que solo se muestre una sola vez cada actor/actriz
SELECT actors.first_name, actors.last_name
FROM actors
INNER JOIN actor_movie ON actors.id = actor_movie.actor_id
INNER JOIN movies ON movies.id = actor_movie.movie_id
WHERE title LIKE "%Guerra%";

-- Debemos listar los títulos de cada película con su género correspondiente. 
-- En el caso de
-- que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda
-- podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista
SELECT title, IFNULL(name, 'no tiene género') AS género
FROM movies
LEFT JOIN genres ON movies.genre_id = genres.id;

-- Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
-- la particularidad de que a la columna que mostrará dicha cantidad la renombraremos:
-- “Duración”. 
SELECT series.title, DATEDIFF(series.end_date, series.release_date) AS Duración
FROM series;

-- Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres.
SELECT actors.first_name, actors.last_name
FROM actors
WHERE LENGTH(first_name) > 6
ORDER BY actors.first_name ASC;

-- Debemos mostrar la cantidad total de los episodios guardados en la base de datos.
SELECT COUNT(*) AS total
FROM episodes;

-- Para el siguiente desafío nos piden que obtengamos el título de todas las series y el total
-- de temporadas que tiene cada una de ellas.
SELECT series.title, COUNT(*) as temporadas
FROM series
INNER JOIN seasons ON series.id = seasons.serie_id
GROUP BY series.title;

-- Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
-- o igual a 3.
SELECT genres.name, COUNT(*) AS 'películas totales'
FROM genres
INNER JOIN movies ON genres.id = movies.genre_id
GROUP BY genres.name
HAVING COUNT(*) >= 3;


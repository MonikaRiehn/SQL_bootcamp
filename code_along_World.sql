SELECT count(countrycode) FROM public.countrylanguage
WHERE isofficial=TRUE;

SELECT avg(lifeexpectancy) FROM public.country;

SELECT avg(population) 
FROM public.city
WHERE countrycode='NLD';

-- EXERCISE
SELECT count(id) 
FROM city
WHERE district IN ('Zuid-Holland', 'Noord-Brabant', 'Utrecht');
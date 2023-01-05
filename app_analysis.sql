-- Analyze Mobile Apps on iOS (7197 Unique Apps)

-- What is the total number of apps in the dataset?

SELECT 
	COUNT(id) apps_count
FROM mobile.ios_apps;


-- What is the distribution of app count by genre?

WITH app_genre AS (
SELECT 
	prime_genre,
	COUNT(id) app_count,
	(SELECT COUNT(id) FROM mobile.ios_apps) total_count
FROM mobile.ios_apps
GROUP BY 1)

SELECT 
	prime_genre, 
	app_count,
	CONCAT (ROUND (100.0 * app_count / total_count, 2) , ' %') percentage
FROM app_genre
ORDER BY 2 DESC, 3 DESC;


-- What is the total user rating count of apps by genre?

SELECT 
	prime_genre, 
	SUM(rating_count_tot) user_rating_count,
	RANK () OVER (ORDER BY SUM(rating_count_tot) DESC)
FROM mobile.ios_apps
GROUP BY 1;


-- What is the average user rating of apps across all categories and by genre?

-- Rounding up to 3 decimal places for better ranking visibility 

SELECT 
	ROUND(AVG(user_rating), 3) avg_all
FROM mobile.ios_apps;

SELECT 
	prime_genre, 
	ROUND (AVG(user_rating), 3) user_rating_count,
	RANK () OVER (ORDER BY AVG(user_rating) DESC)
FROM mobile.ios_apps
GROUP BY 1;


-- What is the content rating by count?

WITH content_count AS (
SELECT 
	cont_rating, 
	COUNT(cont_rating) cont_num,
	(SELECT COUNT(cont_rating) FROM mobile.ios_apps) total_num
FROM mobile.ios_apps
GROUP BY 1
ORDER BY 2)

SELECT 
	cont_rating, 
	cont_num,
	CONCAT (ROUND (100.0 * cont_num / total_num, 2) , ' %') percentage
FROM content_count
ORDER BY 2 DESC, 3 DESC;


-- What is the most common content rating of apps by genre?

WITH genre_cont_rating AS (
SELECT
	prime_genre, 
	cont_rating, 
	COUNT(cont_rating) cont_rating_count,
	DENSE_RANK () OVER (PARTITION BY prime_genre ORDER BY COUNT(cont_rating) DESC) ranking
FROM mobile.ios_apps
GROUP BY 1, 2)

SELECT 
	prime_genre, 
	cont_rating, 
	cont_rating_count
FROM genre_cont_rating
WHERE ranking = 1
ORDER BY 1;


-- Similarly, what is the least common content rating of apps by genre?

WITH genre_cont_rating AS (
SELECT
	prime_genre, 
	cont_rating, 
	COUNT(cont_rating) cont_rating_count,
	DENSE_RANK () OVER (PARTITION BY prime_genre ORDER BY COUNT(cont_rating)) ranking
FROM mobile.ios_apps
GROUP BY 1, 2)

SELECT 
	prime_genre, 
	cont_rating, 
	cont_rating_count
FROM genre_cont_rating
WHERE ranking = 1
ORDER BY 1;


-- What is the count and percentage of free and paid apps for all categories?

WITH app_stats AS (
SELECT 
	COUNT(CASE WHEN price = 0 THEN 'Free' ELSE NULL END) free_count,
	COUNT(CASE WHEN price > 0 THEN 'Paid' ELSE NULL END) paid_count,
	COUNT(price) total_count
FROM mobile.ios_apps)

SELECT 
	free_count, 
	CONCAT(ROUND(100.0 * free_count / total_count, 2), ' %') free_perc,
	paid_count,
	CONCAT(ROUND(100.0 * paid_count / total_count, 2), ' %') paid_perc
FROM app_stats;


-- What is the proportion of free and paid apps by genre

WITH genre_stats AS (
SELECT 
	prime_genre,
	COUNT(CASE WHEN price = 0 THEN 'Free' ELSE NULL END) free_count,
	COUNT(CASE WHEN price > 0 THEN 'Paid' ELSE NULL END) paid_count,
	COUNT(price) total_count
FROM mobile.ios_apps
GROUP BY 1
ORDER BY 1)

SELECT 
	prime_genre, 
	free_count,
	CONCAT(ROUND(100.0 * free_count / total_count, 2), ' %') free_perc,
	paid_count, 
	CONCAT(ROUND(100.0 * paid_count / total_count, 2), ' %') paid_perc
FROM genre_stats;


-- What is the distribution of apps by price?

WITH price_stats AS (
SELECT 
	price,
	COUNT(price) price_count,
	(SELECT COUNT(price) FROM mobile.ios_apps) total_count
FROM mobile.ios_apps
GROUP BY 1
ORDER BY 1)

SELECT 
	price, 
	price_count,
	ROUND(100.0 * price_count / total_count, 2) percentage
FROM price_stats;


-- What is the most common app price by genre?

WITH price_stats AS (
SELECT 
	prime_genre, 
	price, 
	COUNT(price) price_count,
	DENSE_RANK () OVER (PARTITION BY prime_genre ORDER BY COUNT(price) DESC) ranking
FROM mobile.ios_apps
GROUP BY 1, 2)

SELECT 
	prime_genre, 
	price,
	price_count
FROM price_stats
WHERE ranking = 1;


-- Similarly, what is the least common app price by genre?

WITH price_stats AS (
SELECT 
	prime_genre, 
	price, 
	COUNT(price) price_count,
	DENSE_RANK () OVER (PARTITION BY prime_genre ORDER BY COUNT(price)) ranking
FROM mobile.ios_apps
GROUP BY 1, 2)

SELECT 
	prime_genre, 
	price,
	price_count
FROM price_stats
WHERE ranking = 1;


-- What is the average number of devices supported, screenshot images, and languages supported by genre?

-- Used FLOOR function to round down averages to get whole number 

SELECT 
	prime_genre, 
	FLOOR(AVG(sup_devices_num)) sup_devices_avg,
	FLOOR(AVG(screenshot_num)) screenshot_avg,
	FLOOR(AVG(lang_sup_num)) lang_sup_avg
FROM mobile.ios_apps
GROUP BY 1
ORDER BY 1;


-- Which app is the most expensive and in what category?

SELECT 
	app_name, 
	price
FROM mobile.ios_apps 
WHERE price = (SELECT MAX(price) FROM mobile.ios_apps)


-- Which app has the most and least size bytes? 

SELECT 
	app_name,
	prime_genre,
	size_bytes
FROM mobile.ios_apps 
WHERE size_bytes = (SELECT MAX(size_bytes) FROM mobile.ios_apps)

UNION ALL 

SELECT 
	app_name, 
	prime_genre,
	size_bytes
FROM mobile.ios_apps 
WHERE size_bytes = (SELECT MIN(size_bytes) FROM mobile.ios_apps);


-- What are the top 10 most expensive apps?
WITH price_rank AS (
SELECT 
	app_name,
	price,
	DENSE_RANK () OVER (ORDER BY price DESC) rnk
FROM mobile.ios_apps)

SELECT 
	app_name, 
	price
FROM price_rank
WHERE rnk BETWEEN 1 AND 10;


-- Among the top 10 most expensive apps, what is the genre count for the apps?
WITH price_rank AS (
SELECT 
	app_name,
	prime_genre,
	price,
	DENSE_RANK () OVER (ORDER BY price DESC) rnk
FROM mobile.ios_apps),

top_10 AS (
SELECT 
	app_name, 
	prime_genre,
	price
FROM price_rank
WHERE rnk BETWEEN 1 AND 10)

SELECT 
	prime_genre, 
	COUNT(prime_genre) genre_count
FROM top_10 
GROUP BY 1 
ORDER BY 2 DESC;

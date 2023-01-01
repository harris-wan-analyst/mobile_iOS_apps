-- Create ios_apps table to import csv file

CREATE TABLE IF NOT EXISTS mobile.ios_apps
(
    id numeric NOT NULL,
    app_name character varying,
    size_bytes numeric,
    currency character varying,
    price numeric,
    rating_count_tot numeric,
    rating_count_ver numeric,
    user_rating numeric,
    user_rating_ver numeric,
    ver character varying,
    cont_rating numeric,
    prime_genre character varying,
    sup_devices_num numeric,
    screenshot_num numeric,
    lang_sup_num numeric,
    CONSTRAINT "iOS_apps_pkey" PRIMARY KEY (id)
)


-- Copy and inset csv file to table

COPY mobile.ios_apps 
(
	"id",
	app_name,
	size_bytes,
	currency,
	price,
	rating_count_tot,
	rating_count_ver,
	user_rating,
	user_rating_ver,
	ver,
	cont_rating,
	prime_genre,
	sup_devices_num,
	screenshot_num,
	lang_sup_num
)
FROM 'path/to/instacart.csv'
DELIMITER ',' CSV HEADER;


-- Copy the original table as backup 

CREATE TABLE mobile.ios_apps_copy AS
TABLE mobile.ios_apps;
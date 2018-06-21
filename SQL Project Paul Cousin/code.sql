Query displaying the campaigns used by CoolTShirts:

SELECT utm_campaign,
page_name
FROM page_visits
WHERE page_name LIKE '1%'
GROUP BY utm_campaign;


Query for Page Name distinct values:

SELECT page_name
FROM page_visits
GROUP BY page_name;


Question Three Query – First Touches:

WITH first_touch AS (SELECT user_id,
 	MIN(timestamp) AS first_touch_at
 FROM page_visits
 GROUP BY user_id)
 SELECT ft.user_id,
 	ft.first_touch_at,
  pv.utm_campaign,
  COUNT(*) AS sum_first_touch_at
 FROM first_touch ft
 JOIN page_visits pv
 	ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
  GROUP BY pv.utm_campaign;


Query for Question Four:   Last Touches:

WITH last_touch AS (SELECT user_id,
 	MAX(timestamp) AS last_touch_at
 FROM page_visits
 GROUP BY user_id),
 first_touch AS (SELECT user_id,
   MIN(timestamp) AS first_touch_at,
   utm_campaign
   FROM page_visits
   GROUP by user_id)
 SELECT lt.user_id,
 	lt.last_touch_at,
  ft.utm_campaign,
  COUNT(*) AS sum_last_touch_at
 FROM last_touch lt
 JOIN first_touch ft
 	ON lt.user_id = ft.user_id
  GROUP BY ft.utm_campaign;


Query for question 5 – Number of Purchases:

SELECT COUNT(user_id) AS sum_purchases
FROM page_visits
WHERE page_name LIKE '4%';


Question 6 query: Campaigns and Purchases:

WITH last_touch AS (SELECT user_id,
 	MAX(timestamp) AS last_touch_at,
  page_name
 FROM page_visits
 WHERE page_name LIKE '4%'
 GROUP BY user_id),
 first_touch AS (SELECT user_id,
   MIN(timestamp) AS first_touch_at,
   utm_campaign
   FROM page_visits
   GROUP by user_id)
 SELECT lt.user_id,
 	lt.last_touch_at,
  ft.utm_campaign,
  COUNT(*) AS sum_last_touch_at
 FROM last_touch lt
 JOIN first_touch ft
 	ON lt.user_id = ft.user_id
  GROUP BY ft.utm_campaign;


Queries for Excel Spreadsheet analysis – Change page_name LIKE for each page name.
Fourth line, change the number to be 2, 3 or 4 for the last touches for each page name.

WITH last_touch AS (SELECT user_id,
 	MAX(timestamp) AS last_touch_at
 FROM page_visits
 WHERE page_name LIKE '2%'
 GROUP BY user_id),
 first_touch AS (SELECT user_id,
   MIN(timestamp) AS first_touch_at,
   utm_campaign
   FROM page_visits
   GROUP by user_id)
 SELECT lt.user_id,
 	lt.last_touch_at,
  ft.utm_campaign,
  COUNT(*) AS sum_last_touch_at
 FROM last_touch lt
 JOIN first_touch ft
 	ON lt.user_id = ft.user_id
  GROUP BY ft.utm_campaign;





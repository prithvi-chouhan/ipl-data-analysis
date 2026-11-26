-- IPL Matches Analysis (2008-2026): SQL Queries
-- Data: ipl_matches_clean.csv (1243 matches), table name: matches
-- Tool: SQLite (sqliteonline.com)
-- Note: CSV import stores columns as TEXT, so numeric sorting uses CAST.


-- 1. Top 5 teams by wins (complete matches only)
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE result_type = 'complete'
GROUP BY winner
ORDER BY total_wins DESC
LIMIT 5;


-- 2. Top 5 venues by matches hosted (cleaned venue names)
SELECT venue_clean, COUNT(*) AS total_matches
FROM matches
GROUP BY venue_clean
ORDER BY total_matches DESC
LIMIT 5;


-- 3. Top 5 cities by matches hosted
SELECT city, COUNT(*) AS total_matches
FROM matches
GROUP BY city
ORDER BY total_matches DESC, city
LIMIT 5;


-- 4. Matches played per season
SELECT season_year, COUNT(*) AS total_matches
FROM matches
GROUP BY season_year
ORDER BY season_year ASC;


-- 5. Toss impact: % of matches won by the toss-winning team, by toss decision
SELECT toss_decision,
       ROUND(AVG(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100, 2) AS win_pct
FROM matches
WHERE result_type = 'complete'
GROUP BY toss_decision;


-- 6. Toss impact season by season
SELECT season_year,
       ROUND(AVG(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100, 2) AS win_pct
FROM matches
WHERE result_type = 'complete'
GROUP BY season_year
ORDER BY season_year;


-- 7. Players with 10 or more Player of the Match awards
SELECT player_of_match, COUNT(*) AS total_awards
FROM matches
WHERE result_type = 'complete'
GROUP BY player_of_match
HAVING COUNT(*) >= 10
ORDER BY total_awards DESC;


-- 8. Top 5 biggest wins by runs
SELECT season_year, winner, win_by_runs
FROM matches
ORDER BY CAST(win_by_runs AS INTEGER) DESC
LIMIT 5;

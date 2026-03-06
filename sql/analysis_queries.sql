/*
Financial Analysis of Major Tech Companies (2018–2025)

Companies analyzed:
- Meta Platforms
- Tesla
- NVIDIA

Objective:
Evaluate financial resilience after the 2022 macroeconomic shift
by analyzing revenue growth, profitability and debt levels.

Dataset created manually from company financial statements.
*/



CREATE TABLE financials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company VARCHAR(50),
    year INT,
    revenue DECIMAL(15,2),
    revenue_growth DECIMAL(6,2),
    operating_income DECIMAL(15,2),
    operating_margin DECIMAL(6,2),
    net_income DECIMAL(15,2),
    net_margin DECIMAL(6,2),
    total_assets DECIMAL(15,2),
    roa DECIMAL(6,2),
    total_liabilities DECIMAL(15,2),
    debt_ratio DECIMAL(6,2)
);

-- Insert inancial data (2020–2025)
-- Data extracted from company annual reports

INSERT INTO financials 
(company, year, revenue, revenue_growth, operating_income, operating_margin, net_income, net_margin, total_assets, roa, total_liabilities, debt_ratio)
VALUES
('NVIDIA', 2018, 11716, NULL, 3804, 32.47, 4141, 35.34, 13292, 31.15, 3950, 29.72),
('NVIDIA', 2019, 10918, -6.81, 2846, 26.07, 2796, 25.61, 17315, 16.15, 5111, 29.52);

-- INSERT ALL NUMBERS
INSERT INTO financials 
(company, year, revenue, revenue_growth, operating_income, operating_margin, net_income, net_margin, total_assets, roa, total_liabilities, debt_ratio)
VALUES
('NVIDIA', 2020, 16675, 52.73, 4532, 27.18, 4332, 25.98, 28791, 15.05, 11898, 41.33),
('NVIDIA', 2021, 26914, 61.40, 10041, 37.31, 9752, 36.23, 44187, 22.07, 17575, 39.77),
('NVIDIA', 2022, 26974, 0.22, 4224, 15.66, 4368, 16.19, 41182, 10.61, 19081, 46.33),
('NVIDIA', 2023, 60922, 125.85, 32972, 54.12, 29760, 48.85, 65728, 45.28, 22750, 34.61),
('NVIDIA', 2024, 130497, 114.20, 81453, 62.42, 72880, 55.85, 111601, 65.30, 32274, 28.92),
('NVIDIA', 2025, 215938, 65.47, 130387, 60.38, 120067, 55.60, 206803, 58.06, 49510, 23.94);

INSERT INTO financials 
(company, year, revenue, revenue_growth, operating_income, operating_margin, net_income, net_margin, total_assets, roa, total_liabilities, debt_ratio)
VALUES
('META', 2018, 55838, NULL,	24913,	44.62,	22112,	39.60,	97334, 22.72, 13207, 13.57),
('META', 2019, 70697, 26.61,	23986,	33.93,	18485,	26.15,	133376,	13.86,	32322,	24.23),
('META', 2020, 85965,	21.60,	32671,	38.01,	29146,	33.90,	159316,	18.29,	31026,	19.47),
('META', 2021, 117929,	37.18,	28944,	24.54,	39370,	33.38,	165987,	23.72,	41108,	24.77),
('META', 2022, 116609,	-1.12,	28944,	24.82,	23200,	19.90,	185727,	12.49,	60014,	32.31),
('META', 2023, 134902,	15.69,	46751,	34.66,	39098,	28.98,	229623,	17.03,	76455,	33.30),
('META', 2024, 164501,	21.94,	69380,	42.18,	62360,	37.91,	276054,	22.59,	93417,	33.84),
('META', 2025, 200966,	22.17,	83276,	41.44,	60458,	30.08,	366021,	16.52,	148778,	40.65);

INSERT INTO financials 
(company, year, revenue, revenue_growth, operating_income, operating_margin, net_income, net_margin, total_assets, roa, total_liabilities, debt_ratio)
VALUES
('TESLA', 2018, 21461,	NULL,     -388,	-1.81,	-1063,	-4.95,	29740,	-3.57,	23427,	78.77),
('TESLA', 2019, 24578,	14.52,	-69,	-0.28,	-775,	-3.15,	34309,	-2.26,	26199,	76.36),
('TESLA', 2020, 31536,	28.31,	1994,	6.32,	862,	2.73,	52148,	1.65,	28418,	54.49),
('TESLA', 2021, 53823,	70.67,	6523,	12.12,	5644,	10.49,	62131,	9.08,	30548,	49.17),
('TESLA', 2022, 81462,	51.35,	13656,	16.76,	12587,	15.45,	82338,	15.29,	36440,	44.26),
('TESLA', 2023, 96773,	18.80,	8891,	9.19,	14974,	15.47,	106618,	14.04,	43009,	40.34),
('TESLA', 2024, 97690,	0.95,	7076,	7.24,	7153,	7.32,	122070,	5.86,	48390,	39.64),
('TESLA', 2025, 94827,	-2.93,	4355,	4.59,	3855,	4.07,	137806,	2.80,	54941,	39.87);


-- EDA
SELECT DISTINCT company
FROM financials;

SELECT 
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM financials;

SELECT 
    company,
    COUNT(*) AS records
FROM financials
GROUP BY company;


-- Calculate the average net profit margin for each company

SELECT company, AVG(net_margin) AS avg_net_margin
FROM financials
GROUP BY company
ORDER BY avg_net_margin DESC;

-- Identify the year with the highest net profit margin for each company
-- Uses ROW_NUMBER() window function to rank margins within each company

WITH highest_margin AS (
	SELECT 
		company, 
        year, 
        net_margin, 
        ROW_NUMBER() OVER(PARTITION BY company ORDER BY net_margin DESC) AS ranking
	FROM financials
)
SELECT company, year, net_margin
FROM highest_margin
WHERE ranking = 1;

-- Compare average revenue growth between two macroeconomic periods
-- Period 1: 2018–2021 (low interest rate environment)
-- Period 2: 2022–2025 (higher interest rates and AI boom)
SELECT 
    company,
    CASE 
        WHEN year BETWEEN 2018 AND 2021 THEN 'Period 1'
        WHEN year BETWEEN 2022 AND 2025 THEN 'Period 2'
    END AS period,
    AVG(revenue_growth) AS avg_revenue_growth
FROM financials
GROUP BY company, period
ORDER BY company, avg_revenue_growth DESC;

-- AVG revenue_growth by company

SELECT 
    company,
    AVG(revenue_growth) AS avg_revenue_growth
FROM financials
GROUP BY company
ORDER BY avg_revenue_growth DESC;

-- total revenue_growth comparision

SELECT 
    company,
    SUM(revenue_growth) AS total_growth
FROM financials
GROUP BY company
ORDER BY total_growth DESC;

SELECT
    company,
    
    AVG(CASE 
        WHEN year BETWEEN 2018 AND 2021 
        THEN revenue_growth 
    END) AS growth_period_1,

    AVG(CASE 
        WHEN year BETWEEN 2022 AND 2025 
        THEN revenue_growth 
    END) AS growth_period_2

FROM financials
GROUP BY company
ORDER BY growth_period_2 DESC;

SELECT *,
    CASE 
        WHEN year BETWEEN 2018 AND 2021 THEN 'Period 1'
        WHEN year BETWEEN 2022 AND 2025 THEN 'Period 2'
    END AS period
FROM financials

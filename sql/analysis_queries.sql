-- Average Net Margin by Company
SELECT company, AVG(net_margin) AS avg_net_margin
FROM financials
GROUP BY company
ORDER BY avg_net_margin DESC;


-- Net Margin Trend
SELECT company, year, net_margin
FROM financials
WHERE company = 'NVIDIA'
ORDER BY year ASC;


-- Highest Net Margin per Company
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

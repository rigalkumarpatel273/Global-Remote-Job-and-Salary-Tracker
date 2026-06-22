-- Challenge 1: The Role-Based Salary Check
Select ROUND(AVG(salary_max_usd)::numeric, 2), ROUND(AVG(salary_min_usd)::numeric, 2), standardized_role
from fact_jobs
where salary_status <> 'Outlier Trimmed'
Group by standardized_role;

-- Challenge 2: The High-Demand Hubs
Select Count(dl.city), dl.city, dl.country
from fact_jobs as fj 
Inner join dim_locations as dl on fj.location_id = dl.location_id
Group by dl.city, dl.country
Order by Count(dl.city) desc
limit 5;

-- Challenge 3: Python's Global Salary Weight
Select ROUND(AVG(fj.salary_max_usd)::numeric, 2), ROUND(AVG(fj.salary_min_usd)::numeric, 2)
from fact_jobs as fj
Inner join dim_job_skills as djs on fj.job_id = djs.job_id
where djs.skill_name = 'PYTHON';

-- Challenge 4: The "Most Marketable" Skill Combinations
Select dj.skill_name, COUNT(dj.skill_name)
from dim_job_skills as dj
JOIN dim_job_skills as djs on dj.job_id = djs.job_id
where djs.skill_name = 'PYTHON' AND dj.skill_name <> 'PYTHON'
GROUP BY dj.skill_name
Order by COUNT(dj.skill_name) DESC limit 3;

-- Challenge 5: The High-Value Hybrid Markets (Salary vs. Volume)
Select ROUND(AVG(fj.salary_max_usd)::numeric, 2), Count(fj.job_id), dl.country
from fact_jobs as fj
Inner join dim_locations as dl on fj.location_id = dl.location_id
Group by dl.country
having Count(fj.job_id) > 75
Order by Count(fj.job_id) DESC;

-- Challenge 6: The "Top Earner" Role Per Country
Select MAX(fj.salary_max_usd), dl.country, fj.standardized_role
from fact_jobs as fj
Inner join dim_locations as dl on fj.location_id = dl.location_id
Group by fj.standardized_role, dl.country;
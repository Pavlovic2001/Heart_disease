SELECT * FROM cleveland;
SELECT * FROM switzerland;
SELECT * FROM combined_heart_data;


-- kpi heart:

select 
  count(*) filter (where true) as total_patients,

  count(*) filter (where sex = 1) as total_males,
  count(*) filter (where sex = 0) as total_females,

  count(*) filter (where num > 0) as sick_patients,
  count(*) filter (where sex = 1 and num > 0) as sick_males,
  count(*) filter (where sex = 0 and num > 0) as sick_females,

  count(*) filter (where num = 0) as healthy_patients,
  count(*) filter (where sex = 1 and num = 0) as healthy_males,
  count(*) filter (where sex = 0 and num = 0) as healthy_females

from combined_heart_data;






-- average age

select
  avg(age) filter (where true) as all_patients_avg_age,
  avg(age) filter (where num > 0) as sick_patients_avg_age,
  avg(age) filter (where num = 0) as healthy_patients_avg_age
from combined_heart_data;


-- age correlation

select
  age,
  count(*) filter (where true) as all_patients,
  count(*) filter (where num > 0) as sick_patients,
  count(*) filter (where num = 0) as healthy_patients
from combined_heart_data
group by age
order by age;


-- gender correlation

select
  case when sex = 1 then 'Male' else 'Female' end as gender,
  count(*) as all_count,
  count(*) filter (where num > 0) as sick_count,
  count(*) filter (where num = 0) as healthy_count
from combined_heart_data
group by sex
order by gender;

-- symptomanalysis

select 
  symptom,

  -- total patients per symptom
  count(*) filter (where true) as all_patients,

  -- sick
  count(*) filter (where num > 0) as sick_patients,

  -- healthy
  count(*) filter (where num = 0) as healthy_patients,

  -- gender distribution
  count(*) filter (where sex = 1) as male_all,
  count(*) filter (where sex = 0) as female_all,
  count(*) filter (where sex = 1 and num > 0) as male_sick,
  count(*) filter (where sex = 0 and num > 0) as female_sick,
  count(*) filter (where sex = 1 and num = 0) as male_healthy,
  count(*) filter (where sex = 0 and num = 0) as female_healthy

from (
  select 'chest pain type 1' as symptom, sex, num from combined_heart_data where cp = 1
  union all
  select 'chest pain type 2', sex, num from combined_heart_data where cp = 2
  union all
  select 'chest pain type 3', sex, num from combined_heart_data where cp = 3
  union all
  select 'chest pain type 4', sex, num from combined_heart_data where cp = 4
  union all
  select 'exercise-induced angina', sex, num from combined_heart_data where exang = 1
  union all
  select 'st depression (oldpeak > 1.0)', sex, num from combined_heart_data where oldpeak > 1.0
  union all
  select 'abnormal slope (≠ 2)', sex, num from combined_heart_data where slope != 2
  union all
  select 'abnormal thalassemia (≠ 3)', sex, num from combined_heart_data where thal != 3
) as symptoms_with_gender

group by symptom
order by all_patients desc;




-- feature importance

select * from feature_importance;
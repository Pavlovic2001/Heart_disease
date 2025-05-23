CREATE TABLE cleveland_raw (
    id SERIAL PRIMARY KEY,
    age TEXT,                  
    sex TEXT,                  
    cp TEXT,                   
    trestbps TEXT,             
    chol TEXT,                 
    fbs TEXT,                  
    restecg TEXT,              
    thalach TEXT,              
    exang TEXT,                
    oldpeak TEXT,              
    slope TEXT,                
    ca TEXT,                   
    thal TEXT,                 
    num TEXT                   
);

CREATE TABLE switzerland_raw (
    id SERIAL PRIMARY KEY,
    age TEXT,                  
    sex TEXT,                  
    cp TEXT,                   
    trestbps TEXT,             
    chol TEXT,                 
    fbs TEXT,                  
    restecg TEXT,              
    thalach TEXT,              
    exang TEXT,                
    oldpeak TEXT,              
    slope TEXT,                
    ca TEXT,                   
    thal TEXT,                 
    num TEXT                   
);


COPY cleveland_raw (age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal, num)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Heart_disease_analytics\data\cleveland.data'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY switzerland_raw (age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal, num)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Heart_disease_analytics\data\switzerland.data'
WITH (FORMAT csv, HEADER true, DELIMITER ',');




CREATE OR REPLACE FUNCTION clean_numeric(val TEXT)
RETURNS NUMERIC AS $$
BEGIN
    IF val IN ('?', '!', '-9.0') THEN
        RETURN NULL;
    ELSE
        RETURN val::NUMERIC;
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;




UPDATE cleveland_raw
SET age = clean_numeric(age),
    sex = clean_numeric(sex),
    cp = clean_numeric(cp),
    trestbps = clean_numeric(trestbps),
    chol = clean_numeric(chol),
    fbs = clean_numeric(fbs),
    restecg = clean_numeric(restecg),
    thalach = clean_numeric(thalach),
    exang = clean_numeric(exang),
    oldpeak = clean_numeric(oldpeak),
    slope = clean_numeric(slope),
    ca = clean_numeric(ca),
    thal = clean_numeric(thal),
    num = clean_numeric(num);

UPDATE switzerland_raw
SET age = clean_numeric(age),
    sex = clean_numeric(sex),
    cp = clean_numeric(cp),
    trestbps = clean_numeric(trestbps),
    chol = clean_numeric(chol),
    fbs = clean_numeric(fbs),
    restecg = clean_numeric(restecg),
    thalach = clean_numeric(thalach),
    exang = clean_numeric(exang),
    oldpeak = clean_numeric(oldpeak),
    slope = clean_numeric(slope),
    ca = clean_numeric(ca),
    thal = clean_numeric(thal),
    num = clean_numeric(num);




CREATE TABLE cleveland (
    id SERIAL PRIMARY KEY,
    age NUMERIC,                  
    sex NUMERIC,                 
    cp NUMERIC,                   
    trestbps NUMERIC,             
    chol NUMERIC,                 
    fbs NUMERIC,                  
    restecg NUMERIC,              
    thalach NUMERIC,              
    exang NUMERIC,                
    oldpeak NUMERIC,              
    slope NUMERIC,                
    ca NUMERIC,                   
    thal NUMERIC,                 
    num NUMERIC                   
);

CREATE TABLE switzerland (
    id SERIAL PRIMARY KEY,
    age NUMERIC,                  
    sex NUMERIC,                 
    cp NUMERIC,                   
    trestbps NUMERIC,             
    chol NUMERIC,                 
    fbs NUMERIC,                  
    restecg NUMERIC,              
    thalach NUMERIC,              
    exang NUMERIC,                
    oldpeak NUMERIC,              
    slope NUMERIC,                
    ca NUMERIC,                   
    thal NUMERIC,                 
    num NUMERIC                   
);




INSERT INTO cleveland (age, sex, cp, trestbps, chol, fbs,restecg, thalach, exang, oldpeak, slope,ca, thal, num)
SELECT
    age::NUMERIC,
    sex::NUMERIC,
    cp::NUMERIC,
    trestbps::NUMERIC,
    chol::NUMERIC,
    fbs::NUMERIC,
    restecg::NUMERIC,
    thalach::NUMERIC,
    exang::NUMERIC,
    oldpeak::NUMERIC,
    slope::NUMERIC,
    ca::NUMERIC,
    thal::NUMERIC,
    num::NUMERIC
FROM cleveland_raw;


INSERT INTO switzerland (age, sex, cp, trestbps, chol, fbs,restecg, thalach, exang, oldpeak, slope,ca, thal, num)
SELECT
    age::NUMERIC,
    sex::NUMERIC,
    cp::NUMERIC,
    trestbps::NUMERIC,
    chol::NUMERIC,
    fbs::NUMERIC,
    restecg::NUMERIC,
    thalach::NUMERIC,
    exang::NUMERIC,
    oldpeak::NUMERIC,
    slope::NUMERIC,
    ca::NUMERIC,
    thal::NUMERIC,
    num::NUMERIC
FROM switzerland_raw;




DROP TABLE cleveland_raw;
DROP TABLE switzerland_raw;


CREATE VIEW combined_heart_data AS
SELECT * FROM cleveland
UNION ALL
SELECT * FROM switzerland;


SELECT * FROM cleveland;
SELECT * FROM switzerland;
SELECT * FROM combined_heart_data;




CREATE TABLE feature_importance (
    feature TEXT,
    importance NUMERIC
);

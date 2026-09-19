CREATE DATABASE mobile_project;

USE mobile_project;


-- 1. Companies Table

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(50)
);


-- 2. Insert Companies

INSERT INTO companies (company_name)
VALUES
('Samsung'),
('Apple'),
('OnePlus'),
('Vivo'),
('Oppo'),
('Realme'),
('Xiaomi');


-- 3. Mobiles Table

CREATE TABLE mobiles (
    mobile_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(100),
    company_id INT,
    ram INT,
    storage INT,
    processor VARCHAR(100),
    battery INT,
    price DECIMAL(10,2),
    operating_system VARCHAR(50),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);


-- 4. Insert Mobile Details

INSERT INTO mobiles
(model_name, company_id, ram, storage, processor, battery, price, operating_system)
VALUES
('Galaxy S24', 1, 8, 256, 'Snapdragon 8 Gen 3', 4000, 74999, 'Android'),
('iPhone 15', 2, 6, 128, 'Apple A16 Bionic', 3349, 69999, 'iOS'),
('OnePlus 12', 3, 12, 256, 'Snapdragon 8 Gen 3', 5400, 64999, 'Android'),
('Vivo V30', 4, 8, 128, 'Snapdragon 7 Gen 3', 5000, 33999, 'Android'),
('Oppo Reno 11', 5, 8, 256, 'Dimensity 7050', 5000, 32999, 'Android'),
('Realme GT 6', 6, 12, 256, 'Snapdragon 8s Gen 3', 5500, 40999, 'Android'),
('Xiaomi 14', 7, 12, 512, 'Snapdragon 8 Gen 3', 4610, 69999, 'Android');


-- 5. Display All Companies

SELECT * FROM companies;


-- 6. Display All Mobiles

SELECT * FROM mobiles;


-- 7. Mobiles With 8GB RAM

SELECT * FROM mobiles
WHERE ram = 8;


-- 8. Mobiles With 256GB Storage

SELECT * FROM mobiles
WHERE storage = 256;


-- 9. Mobiles Below 40000

SELECT * FROM mobiles
WHERE price < 40000;


-- 10. RAM and Storage

SELECT * FROM mobiles
WHERE ram = 8 AND storage = 256;


-- 11. RAM and Price

SELECT * FROM mobiles
WHERE ram = 8 AND price < 50000;


-- 12. Samsung or Apple

SELECT * FROM mobiles
WHERE company_id = 1 OR company_id = 2;


-- 13. 128GB or 256GB

SELECT * FROM mobiles
WHERE storage = 128 OR storage = 256;


-- 14. Cheapest to Expensive

SELECT * FROM mobiles
ORDER BY price ASC;


-- 15. Expensive to Cheapest

SELECT * FROM mobiles
ORDER BY price DESC;


-- 16. Highest RAM First

SELECT * FROM mobiles
ORDER BY ram DESC;


-- 17. Highest Storage First

SELECT * FROM mobiles
ORDER BY storage DESC;


-- 18. Cheapest Price

SELECT MIN(price) AS cheapest_mobile
FROM mobiles;


-- 19. Highest Price

SELECT MAX(price) AS expensive_mobile
FROM mobiles;


-- 20. Average Price

SELECT AVG(price) AS average_price
FROM mobiles;


-- 21. Total Mobiles

SELECT COUNT(*) AS total_mobiles
FROM mobiles;


-- 22. Price Between 30000 and 50000

SELECT * FROM mobiles
WHERE price BETWEEN 30000 AND 50000;


-- 23. RAM 8GB or 12GB

SELECT * FROM mobiles
WHERE ram IN (8, 12);


-- 24. Storage 128GB or 256GB

SELECT * FROM mobiles
WHERE storage IN (128, 256);


-- 25. Android Mobiles

SELECT * FROM mobiles
WHERE operating_system = 'Android';


-- 26. iOS Mobiles

SELECT * FROM mobiles
WHERE operating_system = 'iOS';


-- 27. Battery 5000mAh or More

SELECT * FROM mobiles
WHERE battery >= 5000;


-- 28. RAM 12GB and Storage 256GB or More

SELECT * FROM mobiles
WHERE ram >= 12 AND storage >= 256;


-- 29. Join Company and Mobile Details

SELECT
    c.company_name,
    m.model_name,
    m.ram,
    m.storage,
    m.processor,
    m.battery,
    m.price,
    m.operating_system
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id;


-- 30. Mobiles Below 50000 With Company Name

SELECT
    c.company_name,
    m.model_name,
    m.ram,
    m.storage,
    m.price
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
WHERE m.price < 50000
ORDER BY m.price ASC;


-- 31. Number of Mobiles Per Company

SELECT
    c.company_name,
    COUNT(m.mobile_id) AS total_mobiles
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
GROUP BY c.company_name;


-- 32. Average Price Per Company

SELECT
    c.company_name,
    AVG(m.price) AS average_price
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
GROUP BY c.company_name;


-- 33. Highest Price Per Company

SELECT
    c.company_name,
    MAX(m.price) AS highest_price
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
GROUP BY c.company_name;


-- 34. Lowest Price Per Company

SELECT
    c.company_name,
    MIN(m.price) AS lowest_price
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
GROUP BY c.company_name;


-- 35. Maximum RAM Mobile

SELECT
    model_name,
    ram,
    storage,
    price
FROM mobiles
WHERE ram = (
    SELECT MAX(ram)
    FROM mobiles
);


-- 36. Maximum Storage Mobile

SELECT
    model_name,
    storage,
    price
FROM mobiles
WHERE storage = (
    SELECT MAX(storage)
    FROM mobiles
);


-- 37. Cheapest Mobile Details

SELECT
    model_name,
    price
FROM mobiles
WHERE price = (
    SELECT MIN(price)
    FROM mobiles
);


-- 38. Most Expensive Mobile Details

SELECT
    model_name,
    price
FROM mobiles
WHERE price = (
    SELECT MAX(price)
    FROM mobiles
);


-- 39. Mobiles Above Average Price

SELECT
    c.company_name,
    m.model_name,
    m.price
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
WHERE m.price > (
    SELECT AVG(price)
    FROM mobiles
)
ORDER BY m.price DESC;


-- 40. Final Complete Mobile Report

SELECT
    c.company_name AS Company,
    m.model_name AS Mobile,
    m.ram AS RAM_GB,
    m.storage AS Storage_GB,
    m.processor AS Processor,
    m.battery AS Battery_mAh,
    m.price AS Price,
    m.operating_system AS OS
FROM companies c
JOIN mobiles m
ON c.company_id = m.company_id
ORDER BY m.price ASC;
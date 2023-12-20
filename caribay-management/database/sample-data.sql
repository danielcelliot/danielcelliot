INSERT INTO webstore_db.customer (first_name, last_name, email, password)
    VALUES ('Daniel', 'Elliot', 'danielcelliot@outlook.com', 'abc123');
INSERT INTO webstore_db.customer (first_name, last_name, email, password) 
    VALUES ('Rachel', 'Timothy', 'rachel_timothy@yahoo.com', 'copyrite12345');
    
SELECT sum(char_length(`created`)) 
	FROM `customer`;


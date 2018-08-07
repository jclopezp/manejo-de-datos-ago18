CREATE TABLE products (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30)
);

CREATE TABLE transactions (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	customer_id INT NOT NULL,
	transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE prod_trans (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	transaction_id INT NOT NULL,
	product_id INT NOT NULL,
	FOREIGN KEY (transaction_id) REFERENCES transactions(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);
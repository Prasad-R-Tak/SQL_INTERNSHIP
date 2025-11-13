-- 1. Create DB and set charset
CREATE DATABASE IF NOT EXISTS ecommerce_db
  DEFAULT CHARACTER SET = utf8mb4
  DEFAULT COLLATE = utf8mb4_unicode_ci;
USE ecommerce_db;

-- 2. Category table
CREATE TABLE Category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Product table
CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
  stock INT NOT NULL DEFAULT 0,
  sku VARCHAR(50) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES Category(category_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Customer / User table
CREATE TABLE Customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80),
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(20),
  password_hash VARCHAR(255) NOT NULL, -- store hash, not plain password
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 5. Address table (one customer can have many addresses)
CREATE TABLE Address (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(100),
  postal_code VARCHAR(20),
  country VARCHAR(100),
  is_default BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. Orders (one order per customer; order status, total)
CREATE TABLE `Order` (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  address_id INT, -- shipping address at time of order
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('PENDING','PROCESSING','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  payment_id INT,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (address_id) REFERENCES Address(address_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. OrderItems (many-to-one from Order to OrderItems)
CREATE TABLE OrderItem (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. Payment table
CREATE TABLE Payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNIQUE, -- one payment per order
  payment_method ENUM('CARD','UPI','NETBANKING','COD') DEFAULT 'CARD',
  paid_amount DECIMAL(12,2) NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('SUCCESS','FAILED','PENDING') DEFAULT 'PENDING',
  FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 9. ProductReview
CREATE TABLE ProductReview (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  customer_id INT NOT NULL,
  rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 10. ProductImages (optional)
CREATE TABLE ProductImage (
  image_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  url VARCHAR(255) NOT NULL,
  alt_text VARCHAR(255),
  is_primary BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 11. Example sample data (small)
INSERT INTO Category (name, description) VALUES
('Electronics','Phones, Laptops and Accessories'),
('Clothing','Apparel and accessories'),
('Home','Home & Kitchen');

INSERT INTO Product (category_id, name, description, price, stock, sku) VALUES
(1,'Smartphone X','Latest smartphone',699.00,50,'SPX-001'),
(1,'Wireless Earbuds','Bluetooth earbuds',49.99,200,'EB-101'),
(2,'Plain T-Shirt','Cotton t-shirt',9.99,150,'TSH-001');

INSERT INTO Customer (first_name,last_name,email,password_hash,phone) VALUES
('Rahul','K','rahul.k@example.com','$2y$...hash','9876543210'),
('Priya','S','priya.s@example.com','$2y$...hash','9123456789');

INSERT INTO Address (customer_id,address_line1,city,state,postal_code,country,is_default) VALUES
(1,'12 MG Road','Mumbai','Maharashtra','400001','India',TRUE),
(2,'45 Park Street','Kolkata','West Bengal','700016','India',TRUE);

-- Create a sample order
INSERT INTO `Order` (customer_id,address_id,status,total_amount) VALUES
(1,1,'PENDING',748.99);

INSERT INTO OrderItem (order_id,product_id,quantity,unit_price) VALUES
(LAST_INSERT_ID(),1,1,699.00);

-- Add payment record (link to that order_id)
INSERT INTO Payment (order_id,payment_method,paid_amount,status) VALUES
((SELECT order_id FROM `Order` WHERE customer_id=1 ORDER BY order_date DESC LIMIT 1),'CARD',748.99,'SUCCESS');

show databases;

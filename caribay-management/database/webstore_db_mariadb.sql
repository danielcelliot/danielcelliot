--
-- Create database webstore_db
--
DROP DATABASE IF EXISTS webstore_db;
CREATE DATABASE webstore_db;
USE webstore_db;

--
-- Table structure for table country
--
DROP TABLE IF EXISTS country;
CREATE TABLE country (
    country_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    country_code
        CHAR(2)
        NOT NULL
        UNIQUE,
    country_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
		TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
		TINYINT UNSIGNED
        NOT NULL
);

--
-- Table structure for table gender
--
DROP TABLE IF EXISTS gender;
CREATE TABLE gender (
    gender_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    gender_type
        VARCHAR(20)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
		TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
		TINYINT UNSIGNED
        NOT NULL
);

--
-- Table structure for table staff
--
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    staff_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    first_name
        VARCHAR(255)
        NOT NULL,
    last_name
        VARCHAR(255)
        NOT NULL,
    date_of_birth
        DATE
        NOT NULL,
    nationality
        TINYINT UNSIGNED
        NOT NULL,
    gender_id
        TINYINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
		TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
		TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (gender_id)
        REFERENCES gender (gender_id),
    FOREIGN KEY (nationality)
        REFERENCES country (country_id)
);

ALTER TABLE country
    ADD FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    ADD FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id);

ALTER TABLE gender
    ADD FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    ADD FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id);

--
-- Table structure for table staff_details
--
DROP TABLE IF EXISTS staff_details;
CREATE TABLE staff_details (
    staff_id
        TINYINT UNSIGNED
        NOT NULL
        PRIMARY KEY,
    national_id
        VARCHAR(20)
        UNIQUE,
    dp_no
        VARCHAR(20)
        UNIQUE,
    bir_no
        VARCHAR(20)
        UNIQUE,
    nis_no
        VARCHAR(20)
        UNIQUE,
    email_address
        VARCHAR(50)
        UNIQUE,
    email_password
        VARCHAR(255),
    portrait_image
        BLOB,
    
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
  
    FOREIGN KEY (staff_id)
		REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table staff_contact
--
DROP TABLE IF EXISTS staff_contact;
CREATE TABLE staff_contact (
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    contact_number
        VARCHAR(20)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
  
    PRIMARY KEY (staff_id, contact_number),
    FOREIGN KEY (staff_id)
		REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table relation
--
DROP TABLE IF EXISTS relation;
CREATE TABLE relation (
    relation_id
        TINYINT UNSIGNED
        NOT NULL
        PRIMARY KEY,
    relation_type
        VARCHAR(20)
        NOT NULL
        UNIQUE
);

--
-- Table structure for table staff_emergency_contact
--
DROP TABLE IF EXISTS staff_emergency_contact;
CREATE TABLE staff_emergency_contact (
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    contact_number
        VARCHAR(20)
        NOT NULL,
    contact_name
        VARCHAR(255)
        NOT NULL,
    relation_id
        TINYINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
  
    PRIMARY KEY (staff_id, contact_number),
    FOREIGN KEY (staff_id)
		REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (relation_id)
        REFERENCES relation (relation_id)
);

--
-- Table structure for table staff_role
--
DROP TABLE IF EXISTS staff_role;
CREATE TABLE staff_role (
    staff_role_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    title
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    role_description
        TEXT,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table staff_role_history
--
DROP TABLE IF EXISTS staff_role_history;
CREATE TABLE staff_role_history (
    staff_role_id
        TINYINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,
  
    PRIMARY KEY (staff_role_id, updated_on),
    FOREIGN KEY (staff_role_id)
        REFERENCES staff_role (staff_role_id)
        ON DELETE CASCADE
);

--
-- Table structure for table staff_salary
--
DROP TABLE IF EXISTS staff_salary;
CREATE TABLE staff_salary (
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    base_salary
        DECIMAL(8,2)
        NOT NULL,
    pay_raise_as_decimal
        DECIMAL(5,2)
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
  
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id)
		REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table staff_salary_history
--
DROP TABLE IF EXISTS staff_salary_history;
CREATE TABLE staff_salary_history (
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,
  
    PRIMARY KEY (staff_id, updated_on),
    FOREIGN KEY (staff_id)
        REFERENCES staff (staff_id)
        ON DELETE CASCADE
);

--
-- Table structure for table address
--
DROP TABLE IF EXISTS address;
CREATE TABLE address (
    address_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    address_line_primary
        VARCHAR(255)
        NOT NULL,
    address_line_optional
        VARCHAR(255),
    zip_code
        VARCHAR(255),
    city
        VARCHAR(255)
        NOT NULL,
    city_state
        VARCHAR(255),
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    country_id
        TINYINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL 
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (country_id)
		REFERENCES country (country_id)
);

--
-- Table structure for table address_history
--
DROP TABLE IF EXISTS address_history;
CREATE TABLE address_history (
    address_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (address_id, updated_on),
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table staff_addresses
--
DROP TABLE IF EXISTS staff_addresses;
CREATE TABLE staff_addresses (
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    address_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,

    PRIMARY KEY (staff_id,address_id),
    FOREIGN KEY (staff_id)
        REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table department
--
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    department_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table contract_type
--
DROP TABLE IF EXISTS contract_type;
CREATE TABLE contract_type (
    contract_type_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    contract_type_name
        VARCHAR(20)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE
);

--
-- Table structure for table department_staff
--
DROP TABLE IF EXISTS department_staff;
CREATE TABLE department_staff (
    department_staff_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    department_id
        TINYINT UNSIGNED
        NOT NULL,
    staff_id
        TINYINT UNSIGNED
        NOT NULL,
    staff_role_id
        TINYINT UNSIGNED
        NOT NULL,
    employment_start_date
        DATE
        NOT NULL,
    employment_end_date
        DATE,
    contract_type_id
        TINYINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES department (department_id)
        ON DELETE CASCADE,
    FOREIGN KEY (staff_id)
        REFERENCES staff (staff_id)
        ON DELETE CASCADE,
    FOREIGN KEY (staff_role_id)
        REFERENCES staff_role (staff_role_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (contract_type_id)
        REFERENCES contract_type (contract_type_id)
);

--
-- Table structure for table department_staff_history
--
DROP TABLE IF EXISTS department_staff_history;
CREATE TABLE department_staff_history (
    department_staff_id
        TINYINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,
  
    PRIMARY KEY (department_staff_id, updated_on),
    FOREIGN KEY (department_staff_id)
        REFERENCES department_staff (department_staff_id)
        ON DELETE CASCADE
);

--
-- Table structure for table supplier
--
DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
    supplier_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    supplier_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
    
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table supplier_contact
--
DROP TABLE IF EXISTS supplier_contact;
CREATE TABLE supplier_contact (
    supplier_contact_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    contact_name
        VARCHAR(255)
        UNIQUE,
    email_address
        VARCHAR(255)
        UNIQUE,
    contact_number
        VARCHAR(20)
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    supplier_id
        SMALLINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (supplier_id)
		REFERENCES supplier (supplier_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table supplier_addresses
--
DROP TABLE IF EXISTS supplier_addresses;
CREATE TABLE supplier_addresses (
    supplier_id
        SMALLINT UNSIGNED
        NOT NULL,
    address_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,
  
    PRIMARY KEY (supplier_id, address_id),
    FOREIGN KEY (supplier_id)
        REFERENCES supplier (supplier_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table merchant
--
DROP TABLE IF EXISTS merchant;
CREATE TABLE merchant (
    merchant_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    merchant_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table merchant_contact
--
DROP TABLE IF EXISTS merchant_contact;
CREATE TABLE merchant_contact (
    merchant_id
        SMALLINT UNSIGNED
        NOT NULL,
    contact_number
        VARCHAR(20)
        NOT NULL
        UNIQUE,
    contact_name
        VARCHAR(255)
        UNIQUE,
    email_address
        VARCHAR(255)
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
  
    PRIMARY KEY (merchant_id, contact_number),
    FOREIGN KEY (merchant_id)
		REFERENCES merchant (merchant_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table merchant_addresses
--
DROP TABLE IF EXISTS merchant_addresses;
CREATE TABLE merchant_addresses (
    merchant_id
        SMALLINT UNSIGNED
        NOT NULL,
    address_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,
  
    PRIMARY KEY (merchant_id, address_id),
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer
--
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    customer_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    first_name
        VARCHAR(255)
        NOT NULL,
    last_name
        VARCHAR(255)
        NOT NULL,
    email_address
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    email_password
        VARCHAR(255)
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    default_address_id
        SMALLINT UNSIGNED
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (default_address_id)
		REFERENCES address (address_id)
);

--
-- Table structure for table customer_history
--
DROP TABLE IF EXISTS customer_history;
CREATE TABLE customer_history (
    customer_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,
  
    PRIMARY KEY (customer_id, updated_on),
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer_contact
--
DROP TABLE IF EXISTS customer_contact;
CREATE TABLE customer_contact (
    customer_id
        SMALLINT UNSIGNED
        NOT NULL,
    contact_number
        VARCHAR(20)
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (customer_id, contact_number),
    FOREIGN KEY (customer_id)
		REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer_addresses
--
DROP TABLE IF EXISTS customer_addresses;
CREATE TABLE customer_addresses (
    customer_id
        SMALLINT UNSIGNED
        NOT NULL,
    address_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,
    
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table brand
--
DROP TABLE IF EXISTS brand;
CREATE TABLE brand (
    brand_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    brand_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
    
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table model
--
DROP TABLE IF EXISTS model;
CREATE TABLE model (
    model_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    model_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    brand_id
        SMALLINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
    
    FOREIGN KEY (brand_id)
		REFERENCES brand (brand_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table stock
--
DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
    stock_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    supplier_id
        SMALLINT UNSIGNED
        NOT NULL,
    sku
        VARCHAR(255)
        NOT NULL,
    model_id
        SMALLINT UNSIGNED
        NOT NULL,
    attributes
        JSON
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,

    UNIQUE (sku, supplier_id),

    FOREIGN KEY (model_id)
		REFERENCES model (model_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (supplier_id)
		REFERENCES supplier (supplier_id)
);

--
-- Table structure for table stock_history
--
DROP TABLE IF EXISTS stock_history;
CREATE TABLE stock_history (
    stock_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (stock_id, updated_on),
    FOREIGN KEY (stock_id)
        REFERENCES stock (stock_id)
        ON DELETE CASCADE
);

--
-- Table structure for table stock_quantities
--
DROP TABLE IF EXISTS stock_quantities;
CREATE TABLE stock_quantities (
    stock_id
        SMALLINT UNSIGNED
        NOT NULL,
    merchant_id
        SMALLINT UNSIGNED
        NOT NULL,
    quantity
        SMALLINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (stock_id, merchant_id),
    FOREIGN KEY (stock_id)
        REFERENCES stock (stock_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
        ON DELETE CASCADE
);

--
-- Table structure for table category
--
DROP TABLE IF EXISTS category;
CREATE TABLE category (
    category_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    category_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    category_description
        TEXT,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table subcategory
--
DROP TABLE IF EXISTS subcategory;
CREATE TABLE subcategory (
    subcategory_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    subcategory_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    subcategory_description
        TEXT,
    category_id
        SMALLINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table product
--
DROP TABLE IF EXISTS product;
CREATE TABLE product (
    product_id
        SMALLINT UNSIGNED
        NOT NULL
        PRIMARY KEY,
    product_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    attributes
        JSON
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    subcategory_id
        SMALLINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (product_id)
        REFERENCES stock (stock_id),
    FOREIGN KEY (subcategory_id)
        REFERENCES subcategory (subcategory_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table product_history
--
DROP TABLE IF EXISTS product_history;
CREATE TABLE product_history (
    product_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (product_id, updated_on),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
        ON DELETE CASCADE
);

--
-- Table structure for table vat
--
DROP TABLE IF EXISTS vat;
CREATE TABLE vat (
    country_id
        TINYINT UNSIGNED
        NOT NULL,
    decimal_value
        DECIMAL(5,4)
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
  
    PRIMARY KEY (country_id),
    FOREIGN KEY (country_id)
		REFERENCES country (country_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table currency
--
DROP TABLE IF EXISTS currency;
CREATE TABLE currency (
    currency_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    denomination
        CHAR(3)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table country_currencies
--
DROP TABLE IF EXISTS country_currencies;
CREATE TABLE country_currencies (
    country_id
        TINYINT UNSIGNED
        NOT NULL,
    currency_id
        TINYINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    PRIMARY KEY (country_id, currency_id),
    FOREIGN KEY (country_id)
        REFERENCES country (country_id)
		ON DELETE CASCADE,
    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table currency_exchange
--
DROP TABLE IF EXISTS currency_exchange;
CREATE TABLE currency_exchange (
    currency_exchange_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    from_currency
        TINYINT UNSIGNED
        NOT NULL,
    to_currency
        TINYINT UNSIGNED
        NOT NULL,
    exchange_rate
        DECIMAL(18,9)
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (from_currency)
		REFERENCES currency (currency_id),
    FOREIGN KEY (to_currency)
		REFERENCES currency (currency_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
        
	CONSTRAINT unique_group_crncy_frm_to
        UNIQUE (from_currency, to_currency)
);

--
-- Table structure for table currency_exchange_history
--
DROP TABLE IF EXISTS currency_exchange_history;
CREATE TABLE currency_exchange_history (
    currency_exchange_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (currency_exchange_id, updated_on),
    FOREIGN KEY (currency_exchange_id)
		REFERENCES currency_exchange (currency_exchange_id)
        ON DELETE CASCADE
);

--
-- Table structure for table product_prices
--
DROP TABLE IF EXISTS product_prices;
CREATE TABLE product_prices (
    product_prices_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    product_id
        SMALLINT UNSIGNED
        NOT NULL,
    merchant_id
        SMALLINT UNSIGNED
        NOT NULL,
    price
        DECIMAL(9,2)
        NOT NULL,
    currency_id
        TINYINT UNSIGNED
        NOT NULL,
        
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
        ON DELETE CASCADE,
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
        
	CONSTRAINT unique_group_prdct_mercht_price
        UNIQUE (product_id, merchant_id)
);

--
-- Table structure for table product_prices_history
--
DROP TABLE IF EXISTS product_prices_history;
CREATE TABLE product_prices_history (
    product_prices_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (product_prices_id, updated_on),
    FOREIGN KEY (product_prices_id)
		REFERENCES product_prices (product_prices_id)
        ON DELETE CASCADE
);

--
-- Table structure for table cart
--
DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
    cart_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    customer_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table cart_products
--
DROP TABLE IF EXISTS cart_products;
CREATE TABLE cart_products (
    cart_id
        SMALLINT UNSIGNED
        NOT NULL,
    product_id
        SMALLINT UNSIGNED
        NOT NULL,
    quantity
        SMALLINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id)
        REFERENCES cart (cart_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
        ON DELETE CASCADE
);

--
-- Table structure for table status_code
--
DROP TABLE IF EXISTS status_code;
CREATE TABLE status_code (
    status_code_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    status_code_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    status_code_description
        TEXT,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
    
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table customer_order
--
DROP TABLE IF EXISTS customer_order;
CREATE TABLE customer_order (
    customer_order_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    customer_id
        SMALLINT UNSIGNED
        NOT NULL,
    shipping_address_id
        SMALLINT UNSIGNED
        NOT NULL,
    billing_address_id
        SMALLINT UNSIGNED
        NOT NULL,
    status_code_id
        SMALLINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (shipping_address_id)
        REFERENCES address (address_id),
    FOREIGN KEY (billing_address_id)
        REFERENCES address (address_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id),
	FOREIGN KEY (customer_id)
		REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer_order_history
--
DROP TABLE IF EXISTS customer_order_history;
CREATE TABLE customer_order_history (
    customer_order_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (customer_order_id, updated_on),
    FOREIGN KEY (customer_order_id)
        REFERENCES customer_order (customer_order_id)
        ON DELETE CASCADE
);

--
-- Table structure for table order_product
--
DROP TABLE IF EXISTS order_product;
CREATE TABLE order_product (
	order_product_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    quantity
        SMALLINT UNSIGNED
        NOT NULL,
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    customer_order_id
        SMALLINT UNSIGNED
        NOT NULL,
    product_id
        SMALLINT UNSIGNED
        NOT NULL,
    status_code_id
        SMALLINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (customer_order_id)
        REFERENCES customer_order (customer_order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id),
        
	CONSTRAINT unique_group_ordr_prdct
        UNIQUE (customer_order_id, product_id)
);

--
-- Table structure for table order_product_history
--
DROP TABLE IF EXISTS order_product_history;
CREATE TABLE order_product_history (
	order_product_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (order_product_id, updated_on),
    FOREIGN KEY (order_product_id)
        REFERENCES order_product (order_product_id)
        ON DELETE CASCADE
);

--
-- Table structure for table payment_provider
--
DROP TABLE IF EXISTS payment_provider;
CREATE TABLE payment_provider (
    payment_provider_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    payment_provider_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    email_address
        VARCHAR(255),
    contact_number
        CHAR(20),
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table payment_method
--
DROP TABLE IF EXISTS payment_method;
CREATE TABLE payment_method (
    payment_method_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    payment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table payment_provider_option
--
DROP TABLE IF EXISTS payment_provider_option;
CREATE TABLE payment_provider_option (
	payment_provider_option_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
	currency_id
        TINYINT UNSIGNED
        NOT NULL,
    payment_method_id
        TINYINT UNSIGNED
        NOT NULL,
    payment_provider_id
        TINYINT UNSIGNED
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
    FOREIGN KEY (payment_method_id)
        REFERENCES payment_method (payment_method_id),
    FOREIGN KEY (payment_provider_id)
        REFERENCES payment_provider (payment_provider_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
        
	CONSTRAINT unique_group_pmnt_method_prov_crncy
		UNIQUE (currency_id, payment_method_id, payment_provider_id)
);

--
-- Table structure for table payment
--
DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
    payment_id
        SMALLINT UNSIGNED
        NOT NULL
        PRIMARY KEY,
    customer_id
        SMALLINT UNSIGNED
        NOT NULL,
    payment_provider_option_id
        TINYINT UNSIGNED
        NOT NULL,
    amount
        DECIMAL(9,2)
        NOT NULL,
    status_code_id
        SMALLINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (payment_id)
        REFERENCES customer_order (customer_order_id),
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    FOREIGN KEY (payment_provider_option_id)
        REFERENCES payment_provider_option (payment_provider_option_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id)
);

--
-- Table structure for table payment_history
--
DROP TABLE IF EXISTS payment_history;
CREATE TABLE payment_history (
    payment_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (payment_id, updated_on),
    FOREIGN KEY (payment_id)
        REFERENCES payment (payment_id)
        ON DELETE CASCADE
);

--
-- Table structure for table shipment_provider
--
DROP TABLE IF EXISTS shipment_provider;
CREATE TABLE shipment_provider (
    shipment_provider_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    shipment_provider_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    email_address
        VARCHAR(255),
    contact_number
        CHAR(20),
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table shipment_method
--
DROP TABLE IF EXISTS shipment_method;
CREATE TABLE shipment_method (
    shipment_method_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    shipment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table shipment_region
--
DROP TABLE IF EXISTS shipment_region;
CREATE TABLE shipment_region (
    shipment_region_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    shipment_region_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id)
);

--
-- Table structure for table shipment_provider_option
--
DROP TABLE IF EXISTS shipment_provider_option;
CREATE TABLE shipment_provider_option (
    shipment_provider_option_id
        TINYINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    shipment_method_id
        TINYINT UNSIGNED
        NOT NULL,
    shipment_region_id
        TINYINT UNSIGNED
        NOT NULL,
    shipment_provider_id
        TINYINT UNSIGNED
        NOT NULL,
    shipping_rate
        DECIMAL(9,2)
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_by
        TINYINT UNSIGNED
        NOT NULL,
        
    FOREIGN KEY (shipment_provider_id)
        REFERENCES shipment_provider (shipment_provider_id),
    FOREIGN KEY (shipment_method_id)
        REFERENCES shipment_method (shipment_method_id),
    FOREIGN KEY (shipment_region_id)
        REFERENCES shipment_region (shipment_region_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
    FOREIGN KEY (last_updated_by)
		REFERENCES staff (staff_id),
        
	CONSTRAINT unique_group_shpmnt_method_region_provider
		UNIQUE (shipment_method_id, shipment_region_id, shipment_provider_id)
);

--
-- Table structure for table order_product_shipment
--
DROP TABLE IF EXISTS order_product_shipment;
CREATE TABLE order_product_shipment (
    order_product_shipment_id
        SMALLINT UNSIGNED
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY,
    product_quantity
        SMALLINT UNSIGNED
        NOT NULL,
    shipping_weight
        DECIMAL(5,2)
        NOT NULL,
    tracking_number
        VARCHAR(255)
        NOT NULL,
    order_product_id
        SMALLINT UNSIGNED
        NOT NULL
        UNIQUE,
    shipment_provider_option_id
        TINYINT UNSIGNED
        NOT NULL,
    status_code_id
        SMALLINT UNSIGNED
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    created_by
        TINYINT UNSIGNED
        NOT NULL,

    FOREIGN KEY (order_product_id)
        REFERENCES order_product (order_product_id),
    FOREIGN KEY (shipment_provider_option_id)
        REFERENCES shipment_provider_option (shipment_provider_option_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id),
    FOREIGN KEY (created_by)
		REFERENCES staff (staff_id),
        
	CONSTRAINT unique_group_tnum_orditem
        UNIQUE (tracking_number, order_product_id)
);

--
-- Table structure for table order_product_shipment_history
--
DROP TABLE IF EXISTS order_product_shipment_history;
CREATE TABLE order_product_shipment_history (
    order_product_shipment_id
        SMALLINT UNSIGNED
        NOT NULL,
    updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updates
        JSON
        NOT NULL,

    PRIMARY KEY (order_product_shipment_id, updated_on),
    FOREIGN KEY (order_product_shipment_id)
        REFERENCES order_product_shipment (order_product_shipment_id)
        ON DELETE CASCADE
);

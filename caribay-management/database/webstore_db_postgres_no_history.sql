DROP SCHEMA IF EXISTS webstore_db_V1;
CREATE SCHEMA webstore_db_V1;

--
-- Table structure for table country
--
DROP TABLE IF EXISTS webstore_db_V1.country;
CREATE TABLE webstore_db_V1.country (
    country_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table address
--
DROP TABLE IF EXISTS webstore_db_V1.address;
CREATE TABLE webstore_db_V1.address (
    address_id
        SERIAL
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
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL 
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (country_id)
		REFERENCES webstore_db_V1.country (country_id)
);

--
-- Table structure for table supplier
--
DROP TABLE IF EXISTS webstore_db_V1.supplier;
CREATE TABLE webstore_db_V1.supplier (
    supplier_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table supplier_contact
--
DROP TABLE IF EXISTS webstore_db_V1.supplier_contact;
CREATE TABLE webstore_db_V1.supplier_contact (
    supplier_contact_id
        SMALLSERIAL
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
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (supplier_id)
		REFERENCES webstore_db_V1.supplier (supplier_id)
        ON DELETE CASCADE
);

--
-- Table structure for table supplier_addresses
--
DROP TABLE IF EXISTS webstore_db_V1.supplier_addresses;
CREATE TABLE webstore_db_V1.supplier_addresses (
    supplier_id
        SMALLINT
        NOT NULL,
    address_id
        INTEGER
        NOT NULL
        UNIQUE,
  
    PRIMARY KEY (supplier_id, address_id),
    FOREIGN KEY (supplier_id)
        REFERENCES webstore_db_V1.supplier (supplier_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES webstore_db_V1.address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table merchant
--
DROP TABLE IF EXISTS webstore_db_V1.merchant;
CREATE TABLE webstore_db_V1.merchant (
    merchant_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table merchant_contact
--
DROP TABLE IF EXISTS webstore_db_V1.merchant_contact;
CREATE TABLE webstore_db_V1.merchant_contact (
    merchant_id
        SMALLINT
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (merchant_id, contact_number),
    FOREIGN KEY (merchant_id)
		REFERENCES webstore_db_V1.merchant (merchant_id)
        ON DELETE CASCADE
);

--
-- Table structure for table merchant_addresses
--
DROP TABLE IF EXISTS webstore_db_V1.merchant_addresses;
CREATE TABLE webstore_db_V1.merchant_addresses (
    merchant_id
        SMALLINT
        NOT NULL,
    address_id
        INTEGER
        NOT NULL
        UNIQUE,
  
    PRIMARY KEY (merchant_id, address_id),
    FOREIGN KEY (merchant_id)
        REFERENCES webstore_db_V1.merchant (merchant_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES webstore_db_V1.address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer
--
DROP TABLE IF EXISTS webstore_db_V1.customer;
CREATE TABLE webstore_db_V1.customer (
    customer_id
        SERIAL
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
        INTEGER
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (default_address_id)
		REFERENCES webstore_db_V1.address (address_id)
);

--
-- Table structure for table customer_contact
--
DROP TABLE IF EXISTS webstore_db_V1.customer_contact;
CREATE TABLE webstore_db_V1.customer_contact (
    customer_id
        INTEGER
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
		REFERENCES webstore_db_V1.customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table customer_addresses
--
DROP TABLE IF EXISTS webstore_db_V1.customer_addresses;
CREATE TABLE webstore_db_V1.customer_addresses (
    customer_id
        INTEGER
        NOT NULL,
    address_id
        INTEGER
        NOT NULL
        UNIQUE,
    
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id)
        REFERENCES webstore_db_V1.customer (customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (address_id)
        REFERENCES webstore_db_V1.address (address_id)
        ON DELETE CASCADE
);

--
-- Table structure for table brand
--
DROP TABLE IF EXISTS webstore_db_V1.brand;
CREATE TABLE webstore_db_V1.brand (
    brand_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table model
--
DROP TABLE IF EXISTS webstore_db_V1.model;
CREATE TABLE webstore_db_V1.model (
    model_id
        SMALLSERIAL
        PRIMARY KEY,
    model_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    brand_id
        SMALLINT
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
    
    FOREIGN KEY (brand_id)
		REFERENCES webstore_db_V1.brand (brand_id)
        ON DELETE CASCADE
);

--
-- Table structure for table stock
--
DROP TABLE IF EXISTS webstore_db_V1.stock;
CREATE TABLE webstore_db_V1.stock (
    stock_id
        SMALLSERIAL
        PRIMARY KEY,
    supplier_id
        SMALLINT
        NOT NULL,
    sku
        VARCHAR(255)
        NOT NULL,
    model_id
        SMALLINT
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (sku, supplier_id),

    FOREIGN KEY (model_id)
		REFERENCES webstore_db_V1.model (model_id),
    FOREIGN KEY (supplier_id)
		REFERENCES webstore_db_V1.supplier (supplier_id)
);

--
-- Table structure for table stock_quantities
--
DROP TABLE IF EXISTS webstore_db_V1.stock_quantities;
CREATE TABLE webstore_db_V1.stock_quantities (
    stock_id
        SMALLINT
        NOT NULL,
    merchant_id
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
        NOT NULL,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (stock_id, merchant_id),
    FOREIGN KEY (stock_id)
        REFERENCES webstore_db_V1.stock (stock_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES webstore_db_V1.merchant (merchant_id)
        ON DELETE CASCADE
);

--
-- Table structure for table category
--
DROP TABLE IF EXISTS webstore_db_V1.category;
CREATE TABLE webstore_db_V1.category (
    category_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table subcategory
--
DROP TABLE IF EXISTS webstore_db_V1.subcategory;
CREATE TABLE webstore_db_V1.subcategory (
    subcategory_id
        SMALLSERIAL
        PRIMARY KEY,
    subcategory_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    subcategory_description
        TEXT,
    category_id
        SMALLINT
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

    FOREIGN KEY (category_id)
        REFERENCES webstore_db_V1.category (category_id)
        ON DELETE CASCADE
);

--
-- Table structure for table product
--
DROP TABLE IF EXISTS webstore_db_V1.product;
CREATE TABLE webstore_db_V1.product (
    product_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    subcategory_id
        SMALLINT
        NOT NULL,

    FOREIGN KEY (product_id)
        REFERENCES webstore_db_V1.stock (stock_id),
    FOREIGN KEY (subcategory_id)
        REFERENCES webstore_db_V1.subcategory (subcategory_id)
);

--
-- Table structure for table vat
--
DROP TABLE IF EXISTS webstore_db_V1.vat;
CREATE TABLE webstore_db_V1.vat (
    country_id
        SMALLINT
        NOT NULL,
    decimal_value
        DECIMAL(5,3)
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (country_id),
    FOREIGN KEY (country_id)
		REFERENCES webstore_db_V1.country (country_id)
);

--
-- Table structure for table currency
--
DROP TABLE IF EXISTS webstore_db_V1.currency;
CREATE TABLE webstore_db_V1.currency (
    currency_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table country_currencies
--
DROP TABLE IF EXISTS webstore_db_V1.country_currencies;
CREATE TABLE webstore_db_V1.country_currencies (
    country_id
        SMALLINT
        NOT NULL,
    currency_id
        SMALLINT
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

    PRIMARY KEY (country_id, currency_id),
    FOREIGN KEY (country_id)
        REFERENCES webstore_db_V1.country (country_id)
		ON DELETE CASCADE,
    FOREIGN KEY (currency_id)
        REFERENCES webstore_db_V1.currency (currency_id)
        ON DELETE CASCADE
);

--
-- Table structure for table currency_exchange
--
DROP TABLE IF EXISTS webstore_db_V1.currency_exchange;
CREATE TABLE webstore_db_V1.currency_exchange (
    currency_exchange_id
        SMALLSERIAL
        PRIMARY KEY,
    from_currency
        SMALLINT
        NOT NULL,
    to_currency
        SMALLINT
        NOT NULL,
    exchange_rate
        DECIMAL(5,2)
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

    FOREIGN KEY (from_currency)
		REFERENCES webstore_db_V1.currency (currency_id),
    FOREIGN KEY (to_currency)
		REFERENCES webstore_db_V1.currency (currency_id),
        
	CONSTRAINT unique_group_crncy_frm_to
        UNIQUE (from_currency, to_currency)
);

--
-- Table structure for table product_prices
--
DROP TABLE IF EXISTS webstore_db_V1.product_prices;
CREATE TABLE webstore_db_V1.product_prices (
    product_prices_id
        SMALLSERIAL
        PRIMARY KEY,
    product_id
        SMALLINT
        NOT NULL,
    merchant_id
        SMALLINT
        NOT NULL,
    price
        DECIMAL(7,2)
        NOT NULL,
    currency_id
        SMALLINT
        NOT NULL,
        
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (currency_id)
        REFERENCES webstore_db_V1.currency (currency_id),
    FOREIGN KEY (product_id)
        REFERENCES webstore_db_V1.product (product_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES webstore_db_V1.merchant (merchant_id)
        ON DELETE CASCADE,
        
	CONSTRAINT unique_group_prdct_mercht_price
        UNIQUE (product_id, merchant_id)
);

--
-- Table structure for table cart
--
DROP TABLE IF EXISTS webstore_db_V1.cart;
CREATE TABLE webstore_db_V1.cart (
    cart_id
        SERIAL
        PRIMARY KEY,
    customer_id
        INTEGER
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
        REFERENCES webstore_db_V1.customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table cart_products
--
DROP TABLE IF EXISTS webstore_db_V1.cart_products;
CREATE TABLE webstore_db_V1.cart_products (
    cart_id
        INTEGER
        NOT NULL,
    product_id
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
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
        REFERENCES webstore_db_V1.cart (cart_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES webstore_db_V1.product (product_id)
        ON DELETE CASCADE
);

--
-- Table structure for table status_code
--
DROP TABLE IF EXISTS webstore_db_V1.status_code;
CREATE TABLE webstore_db_V1.status_code (
    status_code_id
        SMALLINT
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table customer_order
--
DROP TABLE IF EXISTS webstore_db_V1.customer_order;
CREATE TABLE webstore_db_V1.customer_order (
    customer_order_id
        SERIAL
        PRIMARY KEY,
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    customer_id
        INTEGER
        NOT NULL,
    shipping_address_id
        INTEGER
        NOT NULL,
    billing_address_id
        INTEGER
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,

    FOREIGN KEY (shipping_address_id)
        REFERENCES webstore_db_V1.address (address_id),
    FOREIGN KEY (billing_address_id)
        REFERENCES webstore_db_V1.address (address_id),
    FOREIGN KEY (status_code_id)
        REFERENCES webstore_db_V1.status_code (status_code_id),
	FOREIGN KEY (customer_id)
		REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

--
-- Table structure for table order_product
--
DROP TABLE IF EXISTS webstore_db_V1.order_product;
CREATE TABLE webstore_db_V1.order_product (
	order_product_id
        SERIAL
        PRIMARY KEY,
    quantity
        SMALLINT
        NOT NULL,
    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    customer_order_id
        INTEGER
        NOT NULL,
    product_id
        SMALLINT
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,
        
    FOREIGN KEY (customer_order_id)
        REFERENCES webstore_db_V1.customer_order (customer_order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES webstore_db_V1.product (product_id),
    FOREIGN KEY (status_code_id)
        REFERENCES webstore_db_V1.status_code (status_code_id),
        
	CONSTRAINT unique_group_ordr_prdct
        UNIQUE (customer_order_id, product_id)
);

--
-- Table structure for table payment_provider
--
DROP TABLE IF EXISTS webstore_db_V1.payment_provider;
CREATE TABLE webstore_db_V1.payment_provider (
    payment_provider_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table payment_method
--
DROP TABLE IF EXISTS webstore_db_V1.payment_method;
CREATE TABLE webstore_db_V1.payment_method (
    payment_method_id
        SMALLSERIAL
        PRIMARY KEY,
    payment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table payment_provider_option
--
DROP TABLE IF EXISTS webstore_db_V1.payment_provider_option;
CREATE TABLE webstore_db_V1.payment_provider_option (
	payment_provider_option_id
        SMALLSERIAL
        PRIMARY KEY,
	currency_id
        SMALLINT
        NOT NULL,
    payment_method_id
        SMALLINT
        NOT NULL,
    payment_provider_id
        SMALLINT
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
        
    FOREIGN KEY (currency_id)
        REFERENCES webstore_db_V1.currency (currency_id),
    FOREIGN KEY (payment_method_id)
        REFERENCES webstore_db_V1.payment_method (payment_method_id),
    FOREIGN KEY (payment_provider_id)
        REFERENCES webstore_db_V1.payment_provider (payment_provider_id),
        
	CONSTRAINT unique_group_pmnt_method_prov_crncy
		UNIQUE (currency_id, payment_method_id, payment_provider_id)
);

--
-- Table structure for table payment
--
DROP TABLE IF EXISTS webstore_db_V1.payment;
CREATE TABLE webstore_db_V1.payment (
    payment_id
        SERIAL
        PRIMARY KEY,
    customer_id
        INTEGER
        NOT NULL,
    payment_provider_option_id
        SMALLINT
        NOT NULL,
    amount
        DECIMAL(7,2)
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (payment_id)
        REFERENCES webstore_db_V1.customer_order (customer_order_id),
    FOREIGN KEY (customer_id)
        REFERENCES webstore_db_V1.customer (customer_id),
    FOREIGN KEY (payment_provider_option_id)
        REFERENCES webstore_db_V1.payment_provider_option (payment_provider_option_id),
    FOREIGN KEY (status_code_id)
        REFERENCES webstore_db_V1.status_code (status_code_id)
);

--
-- Table structure for table shipment_provider
--
DROP TABLE IF EXISTS webstore_db_V1.shipment_provider;
CREATE TABLE webstore_db_V1.shipment_provider (
    shipment_provider_id
        SMALLSERIAL
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
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table shipment_method
--
DROP TABLE IF EXISTS webstore_db_V1.shipment_method;
CREATE TABLE webstore_db_V1.shipment_method (
    shipment_method_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table shipment_region
--
DROP TABLE IF EXISTS webstore_db_V1.shipment_region;
CREATE TABLE webstore_db_V1.shipment_region (
    shipment_region_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_region_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table shipment_provider_option
--
DROP TABLE IF EXISTS webstore_db_V1.shipment_provider_option;
CREATE TABLE webstore_db_V1.shipment_provider_option (
    shipment_provider_option_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_method_id
        SMALLINT
        NOT NULL,
    shipment_region_id
        SMALLINT
        NOT NULL,
    shipment_provider_id
        SMALLINT
        NOT NULL,
    shipping_rate
        DECIMAL(5,2)
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
	currency_id
		SMALLINT
		NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (shipment_provider_id)
        REFERENCES webstore_db_V1.shipment_provider (shipment_provider_id),
    FOREIGN KEY (shipment_method_id)
        REFERENCES webstore_db_V1.shipment_method (shipment_method_id),
    FOREIGN KEY (shipment_region_id)
        REFERENCES webstore_db_V1.shipment_region (shipment_region_id),
	FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
        
	CONSTRAINT unique_group_shpmnt_method_region_provider
		UNIQUE (shipment_method_id, shipment_region_id, shipment_provider_id)
);

--
-- Table structure for table order_product_shipment
--
DROP TABLE IF EXISTS webstore_db_V1.order_product_shipment;
CREATE TABLE webstore_db_V1.order_product_shipment (
    order_product_shipment_id
        SERIAL
        PRIMARY KEY,
    product_quantity
        SMALLINT
        NOT NULL,
    shipping_weight
        DECIMAL(5,2)
        NOT NULL,
    tracking_number
        VARCHAR(255)
        NOT NULL,
    order_product_id
        INTEGER
        NOT NULL
        UNIQUE,
    shipment_provider_option_id
        SMALLINT
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMP
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_product_id)
        REFERENCES webstore_db_V1.order_product (order_product_id),
    FOREIGN KEY (shipment_provider_option_id)
        REFERENCES webstore_db_V1.shipment_provider_option (shipment_provider_option_id),
        
	CONSTRAINT unique_group_tnum_orditem
        UNIQUE (tracking_number, order_product_id)
);

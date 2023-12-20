CREATE TABLE users (
    user_id
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
    password
        BYTEA
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE country (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE address (
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
    address_state
        VARCHAR(255),
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    country_id
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMPTZ
        NOT NULL 
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (country_id)
		REFERENCES country (country_id)
);

CREATE TABLE supplier (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE supplier_contact (
    supplier_contact_id
        SMALLSERIAL
        PRIMARY KEY,
    supplier_id
        SMALLINT
        NOT NULL,
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

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (supplier_id)
		REFERENCES supplier (supplier_id)
        ON DELETE CASCADE
);

CREATE TABLE supplier_addresses (
    supplier_id
        SMALLINT
        NOT NULL,
    address_id
        INTEGER
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

CREATE TABLE merchant (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE merchant_contact (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (merchant_id, contact_number),
    FOREIGN KEY (merchant_id)
		REFERENCES merchant (merchant_id)
        ON DELETE CASCADE
);

CREATE TABLE merchant_addresses (
    merchant_id
        SMALLINT
        NOT NULL,
    address_id
        INTEGER
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

CREATE TABLE customer (
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
    password
        BYTEA
        NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,
    default_address_id
        INTEGER
        UNIQUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (default_address_id)
		REFERENCES address (address_id)
);

CREATE TABLE customer_contact (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (customer_id, contact_number),
    FOREIGN KEY (customer_id)
		REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

CREATE TABLE customer_addresses (
    customer_id
        INTEGER
        NOT NULL,
    address_id
        INTEGER
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

CREATE TABLE brand (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE model (
    model_id
        SMALLSERIAL
        PRIMARY KEY,
    brand_id
        SMALLINT
        NOT NULL,
    model_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (brand_id)
		REFERENCES brand (brand_id)
        ON DELETE CASCADE
);

CREATE TABLE stock (
    stock_id
        SMALLSERIAL
        PRIMARY KEY,
    model_id
        SMALLINT
        NOT NULL,
    sku
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (model_id)
		REFERENCES model (model_id)
);

CREATE TABLE stock_quantities (
    stock_id
        SMALLINT
        NOT NULL,
    supplier_id
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
        NOT NULL,

    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (supplier_id, stock_id),
    FOREIGN KEY (supplier_id)
        REFERENCES supplier (supplier_id)
		ON DELETE CASCADE,
    FOREIGN KEY (stock_id)
        REFERENCES stock (stock_id)
		ON DELETE CASCADE
);

CREATE TABLE category (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subcategory (
    subcategory_id
        SMALLSERIAL
        PRIMARY KEY,
    category_id
        SMALLINT
        NOT NULL,
    subcategory_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    subcategory_description
        TEXT,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE
);

CREATE TABLE product (
    product_id
        SMALLINT
        PRIMARY KEY,
    subcategory_id
        SMALLINT
        NOT NULL,
    product_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,
    attributes
        JSONB
        NOT NULL,
    options
        JSONB,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (product_id)
        REFERENCES stock (stock_id)
        ON DELETE CASCADE,
    FOREIGN KEY (subcategory_id)
        REFERENCES subcategory (subcategory_id)
);

CREATE TABLE product_quantities (
    product_id
        SMALLINT
        NOT NULL,
    merchant_id
        SMALLINT
        NOT NULL,
    order_limit
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
        NOT NULL,

    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (product_id, merchant_id),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
        ON DELETE CASCADE
);

CREATE TABLE vat (
    country_id
        SMALLINT
        NOT NULL,
    decimal_value
        DECIMAL(5,3)
        NOT NULL,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
  
    PRIMARY KEY (country_id),
    FOREIGN KEY (country_id)
		REFERENCES country (country_id)
);

CREATE TABLE currency (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE country_currencies (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (country_id, currency_id),
    FOREIGN KEY (country_id)
        REFERENCES country (country_id)
		ON DELETE CASCADE,
    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id)
        ON DELETE CASCADE
);

CREATE TABLE currency_exchange (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (from_currency)
		REFERENCES currency (currency_id),
    FOREIGN KEY (to_currency)
		REFERENCES currency (currency_id),
        
	CONSTRAINT unique_group_crncy_frm_to
        UNIQUE (from_currency, to_currency)
);

CREATE TABLE product_prices (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
		ON DELETE CASCADE,
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
        ON DELETE CASCADE,
        
	CONSTRAINT unique_group_prdct_mercht_price
        UNIQUE (product_id, merchant_id)
);

CREATE TABLE cart (
    cart_id
        INTEGER
        PRIMARY KEY,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (cart_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

CREATE TABLE cart_products (
    cart_id
        INTEGER
        NOT NULL,
    product_id
        SMALLINT
        NOT NULL,
    merchant_id
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (cart_id, product_id, merchant_id),
    FOREIGN KEY (cart_id)
        REFERENCES cart (cart_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id)
);

CREATE TABLE payment_provider (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_method (
    payment_method_id
        SMALLSERIAL
        PRIMARY KEY,
    payment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_provider_options (
	payment_provider_options_id
        SMALLSERIAL
        PRIMARY KEY,
    payment_provider_id
        SMALLINT
        NOT NULL,
    payment_method_id
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
    FOREIGN KEY (payment_method_id)
        REFERENCES payment_method (payment_method_id),
    FOREIGN KEY (payment_provider_id)
        REFERENCES payment_provider (payment_provider_id),
        
	CONSTRAINT unique_group_pmnt_method_prov_crncy
		UNIQUE (currency_id, payment_method_id, payment_provider_id)
);

CREATE TABLE shipment_provider (
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipment_method (
    shipment_method_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_method_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipment_region (
    shipment_region_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_region_name
        VARCHAR(255)
        NOT NULL
        UNIQUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipment_provider_options (
    shipment_provider_options_id
        SMALLSERIAL
        PRIMARY KEY,
    shipment_provider_id
        SMALLINT
        NOT NULL,
    shipment_method_id
        SMALLINT
        NOT NULL,
    shipment_region_id
        SMALLINT
        NOT NULL,
    shipping_rate
        DECIMAL(5,2)
        NOT NULL,
	currency_id
		SMALLINT
		NOT NULL,
    is_active
        BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (shipment_provider_id)
        REFERENCES shipment_provider (shipment_provider_id),
    FOREIGN KEY (shipment_method_id)
        REFERENCES shipment_method (shipment_method_id),
    FOREIGN KEY (shipment_region_id)
        REFERENCES shipment_region (shipment_region_id),
	FOREIGN KEY (currency_id)
        REFERENCES currency (currency_id),
        
	CONSTRAINT unique_group_shpmnt_method_region_provider
		UNIQUE (shipment_method_id, shipment_region_id, shipment_provider_id)
);

CREATE SEQUENCE status_code_sequence
    start 101
    increment 1;

CREATE TABLE status_code (
    status_code_id
        SMALLSERIAL
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
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_order (
    customer_order_id
        SERIAL
        PRIMARY KEY,
    customer_id
        INTEGER
        NOT NULL,
    shipping_address_id
        INTEGER
        NOT NULL,
    billing_address_id
        INTEGER
        NOT NULL,
    shipment_provider_options_id
        SMALLINT
        NOT NULL,
	payment_provider_options_id
        SMALLINT
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL
        DEFAULT 101,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (shipping_address_id)
        REFERENCES address (address_id),
    FOREIGN KEY (billing_address_id)
        REFERENCES address (address_id),
    FOREIGN KEY (shipment_provider_options_id)
        REFERENCES shipment_provider_options (shipment_provider_options_id),
    FOREIGN KEY (payment_provider_options_id)
        REFERENCES payment_provider_options (payment_provider_options_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id),
	FOREIGN KEY (customer_id)
		REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

CREATE TABLE customer_order_products (
	customer_order_products_id
        SERIAL
        PRIMARY KEY,
    customer_order_id
        INTEGER
        NOT NULL,
    product_id
        SMALLINT
        NOT NULL,
    merchant_id
        SMALLINT
        NOT NULL,
    quantity
        SMALLINT
        NOT NULL,
    status_code_id
        SMALLINT,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (customer_order_id)
        REFERENCES customer_order (customer_order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    FOREIGN KEY (merchant_id)
        REFERENCES merchant (merchant_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id),
        
	CONSTRAINT unique_group_ordr_prdct
        UNIQUE (customer_order_id, product_id, merchant_id)
);

CREATE TABLE customer_order_payments (
    customer_order_payments_id
        INTEGER
        PRIMARY KEY,
    customer_id
        INTEGER
        NOT NULL,
    customer_order_products_id
        INTEGER
        NOT NULL
        UNIQUE,
    payment_provider_options_id
        SMALLINT
        NOT NULL,
    amount
        DECIMAL(7,2)
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
        
    FOREIGN KEY (customer_order_payments_id)
        REFERENCES customer_order (customer_order_id),
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    FOREIGN KEY (customer_order_products_id)
        REFERENCES customer_order_products (customer_order_products_id),
    FOREIGN KEY (payment_provider_options_id)
        REFERENCES payment_provider_options (payment_provider_options_id),
    FOREIGN KEY (status_code_id)
        REFERENCES status_code (status_code_id)
);

CREATE TABLE customer_order_shipments (
    customer_order_shipments_id
        SERIAL
        PRIMARY KEY,
    customer_id
        INTEGER
        NOT NULL,
    customer_order_products_id
        INTEGER
        NOT NULL
        UNIQUE,
    product_quantity
        SMALLINT
        NOT NULL,
    shipping_weight
        DECIMAL(5,2)
        NOT NULL,
    tracking_number
        VARCHAR(255)
        NOT NULL,
    shipment_provider_options_id
        SMALLINT
        NOT NULL,
    status_code_id
        SMALLINT
        NOT NULL,

    created_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    last_updated_on
        TIMESTAMPTZ
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    FOREIGN KEY (customer_order_products_id)
        REFERENCES customer_order_products (customer_order_products_id),
    FOREIGN KEY (shipment_provider_options_id)
        REFERENCES shipment_provider_options (shipment_provider_options_id),
        
	CONSTRAINT unique_group_tnum_orditem
        UNIQUE (tracking_number, customer_order_products_id)
);
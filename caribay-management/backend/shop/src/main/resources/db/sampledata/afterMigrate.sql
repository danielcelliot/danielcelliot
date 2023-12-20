INSERT INTO customer
    (first_name, last_name, email_address, password)
VALUES
    ('Daniel', 'Elliot', 'daniel@caribay.tt', 'abc12345'),
    ('Jane', 'Smith', 'jane@caribay.tt', 'copy4567')
;

INSERT INTO cart
    (cart_id)
VALUES (1), (2)
;

INSERT INTO supplier
    (supplier_name)
VALUES
    ('Forever Young International'), ('ACME Supplies Ltd.')
;

INSERT INTO category
    (category_name, category_description)
VALUES
    ('Shoes', 'Various Footwear for Men, Women & Kids'),
    ('Electronics', 'Cell Phones, Televisions & more'),
    ('Computers', 'Laptops, Desktops & computer components')
;

INSERT INTO subcategory
    (subcategory_name, subcategory_description, category_id)
VALUES
    ('Men', 'Nike, Adidas, Crocs shoes for Men', 1),
    ('Smartphones', 'iPhone, Galaxy & more', 2),
    ('Streaming devices', 'Chromecast, Roku, AppleTV & more', 2),
    ('Video games', 'PlayStation, Xbox & accessories', 2),
    ('Televisions', 'LG, Samsung, Gaming monitors & more', 2),
    ('Laptops', 'HP, Dell, Lenovo & more', 3)
;

INSERT INTO brand
    (brand_name)
VALUES
    ('LG'), ('Samsung'), ('TestBrand')
;

INSERT INTO model
    (model_name, brand_id)
VALUES
    ('OLED EVO Series C2', 1),
    ('Galaxy S22', 2),
    ('Test Model', 3)
;

INSERT INTO stock
    (sku, model_id)
VALUES
    ('SKU-LG-C277-001', 1), ('SKU-LG-C265-002', 1), ('SKU-C001-S004-S22U', 2),
    ('SKU-C002-S003-S22U', 2), ('SKU-C002-S002-S22U', 2),
    ('SKU-C003-S001-S22', 2), ('SKU-C003-S002-S22', 2),
    ('TEST-SKU', 3)
;

INSERT INTO stock_quantities
    (stock_id, supplier_id, quantity)
VALUES
    (1, 1, 13), (1, 2, 7), (2, 1, 4), (2, 2, 4),
    (3, 1, 8), (3, 2, 8), (7, 1, 4), (7, 2, 4)
;

INSERT INTO product
    (product_id, subcategory_id, product_name, attributes, options)
VALUES
    (
        1,
        5,
        'LG OLED Evo Series C2 - 77 inch',
        '[{"dimensions": "67.4 x 10.5 x 40.7 inches"}, {"weight": "53.80 lbs"}]',
        '[{"size": "77 inch"}]'
    ),
    (
        3,
        2,
        'Samsung Galaxy S22 Ultra - Black, 1TB',
        '[{"dimensions": "6.43 x 3.07 x 0.35 inches"}, {"weight": "8.08 oz (229.0 g)"}]',
        '[{"style": "S22 Ultra"}, {"color": "Phantom Black"}, {"size": "1TB"}]'
    ),
    (
        4,
        2,
        'Samsung Galaxy S22 Ultra - Green, 512GB',
        '[{"dimensions": "6.43 x 3.07 x 0.35 inches"}, {"weight": "8.08 oz (229.0 g)"}]',
        '[{"style": "S22 Ultra"}, {"color": "Green"}, {"size": "512GB"}]'
    ),
    (
        2,
        5,
        'LG OLED Evo Series C2 - 65 inch',
        '[{"dimensions": "56.7 x 1 x 32.3 inches"}, {"weight": "50.30 lbs"}]',
        '[{"size": "65 inch"}]'
    ),
    (
        5,
        2,
        'Samsung Galaxy S22 Ultra - Green, 256GB',
        '[{"dimensions": "6.43 x 3.07 x 0.35 inches"}, {"weight": "8.08 oz (229.0 g)"}]',
        '[{"style": "S22 Ultra"}, {"color": "Green"}, {"size": "256GB"}]'
    ),
    (
        6,
        2,
        'Samsung Galaxy S22 - White, 128GB',
        '[{"dimensions": "5.75 x 2.78 x 0.30 inches"}, {"weight": "5.89 oz (168.0 g)"}]',
        '[{"style": "S22"}, {"color": "Phantom White"}, {"size": "128GB"}]'
    ),
    (
        7,
        2,
        'Samsung Galaxy S22 - White, 256GB',
        '[{"dimensions": "5.75 x 2.78 x 0.30 inches"}, {"weight": "5.89 oz (168.0 g)"}]',
        '[{"style": "S22"}, {"color": "Phantom White"}, {"size": "256GB"}]'
    )
;

INSERT INTO merchant
    (merchant_name)
VALUES
    ('caribay.tt'), ('ACME merchants LTD.'), ('Unknown sellers Limited'), ('Boardwalk Stores LTD')
;

INSERT INTO product_quantities
    (product_id, merchant_id, quantity, order_limit)
VALUES
    (1, 1, (SELECT sum(quantity) FROM stock_quantities WHERE stock_id=1), 5),
    (1, 2, 9, 2),
    (1, 3, 2, 1),
    (2, 1, (SELECT sum(quantity) FROM stock_quantities WHERE stock_id=2), 2),
    (3, 1, (SELECT sum(quantity) FROM stock_quantities WHERE stock_id=3), 1),
    (7, 1, (SELECT sum(quantity) FROM stock_quantities WHERE stock_id=7), 1),
    (6, 2, 30, 2),
    (5, 3, 3, 1),
    (4, 4, 6, 1),
    (3, 4, 11, 1)
;

INSERT INTO currency
    (denomination)
VALUES
    ('TTD'), ('USD')
;

INSERT INTO product_prices
    (product_id, merchant_id, price, currency_id)
VALUES
    (1, 1, 1499.99, 2), (2, 1, 999.99, 2), (3, 1, 1899.99, 2), (4, 1, 1099.99, 2),
    (5, 1, 999.99, 2), (6, 1, 729.99, 2), (7, 1, 699.99, 2),
    (1, 2, 1749.29, 2), (1, 3, 1500.00, 2), (3, 3, 1999.99, 2)
;

INSERT INTO status_code
    (status_code_id, status_code_name, status_code_description)
VALUES
    (nextval('status_code_sequence'), 'Processing', 'Customer order is currently being processed.'),
    (nextval('status_code_sequence'), 'Cancelled', 'Customer order has been cancelled.'),
    (nextval('status_code_sequence'), 'Payment Declined', 'Customer payment method was declined.'),
    (nextval('status_code_sequence'), 'Confirmed', 'Customer order is preparing for shipment.'),
    (nextval('status_code_sequence'), 'Shipped', 'Customer order has shipped.'),
    (nextval('status_code_sequence'), 'Delivered', 'Customer package was delivered.')
;

INSERT INTO country
    (country_code, country_name)
VALUES
    ('TT', 'Trinidad & Tobago'),
    ('US', 'United States of America')
;

INSERT INTO address
    (address_line_primary, address_line_optional, zip_code, city, address_state, country_id)
VALUES
    ('Gordon Road, St. Anns', '', 'NONE', 'Port of Spain', 'NONE', 1),
    ('NW 17th Street', 'DEPT# 43-9909', '33126', 'Miami', 'Florida', 2),
    ('Somewhere Avenue', 'Burbank', 'NONE', 'Port of Spain', 'NONE', 1)
;

INSERT INTO customer_addresses
    (customer_id, address_id)
VALUES
    (1, 1), (2, 2), (2, 3);

INSERT INTO payment_provider
    (payment_provider_name, email_address, contact_number)
VALUES
    ('In-Store', '', ''),
    ('Bank Account', '', ''),
    ('PayPal', 'paypal@test.com', '555-0000'),
    ('WiPay', 'support@wipay.co.tt', '868-431-1234')
;

INSERT INTO payment_method
    (payment_method_name)
VALUES
    ('Credit|Debit card'), ('Cash'), ('Direct Transfer'), ('PayPal Express Checkout')
;

INSERT INTO payment_provider_options
    (payment_provider_id, payment_method_id, currency_id)
VALUES
    (1, 1, 1), (1, 2, 1), (1, 2, 2),
    (2, 3, 1), (2, 3, 2),
    (3, 4, 2),
    (4, 1, 1)
;

INSERT INTO shipment_provider
    (shipment_provider_name, email_address, contact_number)
VALUES
    ('In-Store', '', ''),
    ('DHL', 'test@dhl.com', '555-1198'),
    ('FedEx', 'shipping@fedex.tt', '333-4444'),
    ('UPS', 'support@ups.com', '000-111-2345')
;

INSERT INTO shipment_method
    (shipment_method_name)
VALUES
    ('In-Store Pickup'),
    ('Standard Shipping'),
    ('Two-Day Shipping'),
    ('Express Same-Day Shipping')
;

INSERT INTO shipment_region
    (shipment_region_name)
VALUES
    ('Trinidad'),
    ('Tobago'),
    ('United States'),
    ('Jamaica'),
    ('Barbados'),
    ('Guyana')
;

INSERT INTO shipment_provider_options
    (shipment_provider_id, shipment_method_id, shipment_region_id, shipping_rate, currency_id)
VALUES
    (1, 1, 1, 0.00, 1),
    (2, 2, 1, 10.00, 1),
    (3, 2, 1, 10.00, 1),
    (3, 3, 1, 15.00, 1),
    (3, 4, 1, 25.00, 1)
;

INSERT INTO customer_order
    (customer_id, shipping_address_id, billing_address_id, shipment_provider_options_id, payment_provider_options_id)
VALUES
    (1, 1, 1, 1, 1), (2, 2, 3, 2, 2)
;

INSERT INTO customer_order_products
    (customer_order_id, product_id, merchant_id, quantity)
VALUES
    (1, 1, 1, 1), (1, 2, 1, 6), (1, 3, 1, 3),
    (1, 4, 1, 1), (1, 5, 1, 2), (2, 6, 1, 20),
    (2, 7, 1, 9)
;
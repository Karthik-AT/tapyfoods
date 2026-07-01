-- ============================================================
--  TAPY FOOD DATABASE — tapyfood.sql
--  MySQL 8.0+
--  Run: mysql -u root -p < tapyfood.sql
-- ============================================================


-- Drop in reverse FK order for clean re-run
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS restaurant;
DROP TABLE IF EXISTS users;

-- ============================================================
--  TABLE: restaurant
-- ============================================================
CREATE TABLE restaurant (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100)    NOT NULL,
    cuisine_type  VARCHAR(100)    NOT NULL,
    rating        DECIMAL(2,1)    NOT NULL DEFAULT 4.0,
    delivery_time VARCHAR(20)     NOT NULL DEFAULT '30 min',
    location      VARCHAR(150)    NOT NULL,
    image_url     TEXT,
    offer_badge   VARCHAR(100),
    description   TEXT,
    created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
--  TABLE: menu
-- ============================================================
CREATE TABLE menu (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT             NOT NULL,
    name          VARCHAR(150)    NOT NULL,
    category      VARCHAR(50)     NOT NULL,
    price         DECIMAL(10,2)   NOT NULL,
    description   TEXT,
    image_url     TEXT,
    is_veg        TINYINT(1)      NOT NULL DEFAULT 0,
    created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurant(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--  TABLE: users
-- ============================================================
CREATE TABLE users (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100)  NOT NULL,
    email      VARCHAR(150)  NOT NULL UNIQUE,
    password   VARCHAR(255)  NOT NULL,
    phone      VARCHAR(20),
    address    TEXT,
    created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
--  TABLE: orders
-- ============================================================
CREATE TABLE orders (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT            NOT NULL,
    total_amount     DECIMAL(10,2)  NOT NULL,
    status           VARCHAR(30)    NOT NULL DEFAULT 'Placed',
    delivery_address TEXT           NOT NULL,
    created_at       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
--  TABLE: order_items
-- ============================================================
CREATE TABLE order_items (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT           NOT NULL,
    menu_id  INT           NOT NULL,
    quantity INT           NOT NULL DEFAULT 1,
    price    DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_orderitems_menu
        FOREIGN KEY (menu_id) REFERENCES menu(id)
) ENGINE=InnoDB;

-- ============================================================
--  TABLE: cart
-- ============================================================
CREATE TABLE cart (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    user_id  INT NOT NULL,
    menu_id  INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_menu
        FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE CASCADE,
    UNIQUE KEY uq_cart_item (user_id, menu_id)
) ENGINE=InnoDB;

-- ============================================================
--  SAMPLE DATA: Restaurants
-- ============================================================
INSERT INTO restaurant (name, cuisine_type, rating, delivery_time, location, image_url, offer_badge, description) VALUES
('The Grand Bistro',
 'European · Fine Dining', 4.9, '25-35 min', 'Bandra West, Mumbai',
 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=700&q=85&auto=format&fit=crop',
 '20% OFF on first order',
 'Classic European dining with a modern twist — artisan pasta, grilled prime steaks, and freshly baked pastries by world-class chefs.'),

('Sushi Zen',
 'Japanese · Sushi', 4.8, '30-40 min', 'Juhu, Mumbai',
 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=700&q=85&auto=format&fit=crop',
 'Free Miso Soup',
 'Authentic Japanese delicacies with fresh ingredients flown in daily — traditional sashimi, signature rolls, and savory ramen bowls.'),

('Bella Italia',
 'Italian · Pizza & Pasta', 4.7, '20-30 min', 'Andheri East, Mumbai',
 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=700&q=85&auto=format&fit=crop',
 'Buy 2 Get 1 Free',
 'Hand-stretched stone-baked pizzas, rich lasagna, and premium house wines that make every dinner feel like a celebration in Rome.'),

('Spice Garden',
 'Indian · North Indian', 4.6, '25-35 min', 'Dadar, Mumbai',
 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=700&q=85&auto=format&fit=crop',
 '15% OFF weekends',
 'Authentic North Indian cuisine with rich curries, tandoori specialties, and freshly baked naans that bring the flavors of Punjab to your table.'),

('Burger Barn',
 'American · Burgers', 4.5, '15-25 min', 'Powai, Mumbai',
 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?w=700&q=85&auto=format&fit=crop',
 'Free Fries on ₹499+',
 'Flame-grilled gourmet burgers stacked with fresh ingredients, crispy fries, creamy shakes, and indulgent desserts for the ultimate comfort meal.');

-- ============================================================
--  SAMPLE DATA: Menu Items — The Grand Bistro (id=1)
-- ============================================================
INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) VALUES
(1, 'Grilled Ribeye Steak',     'Mains',    849.00,
 'Grass-fed ribeye seared to perfection with garlic-herb butter. Served with creamy mashed potatoes and roasted asparagus.',
 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=700&q=85&auto=format&fit=crop', 0),

(1, 'Truffle Mushroom Risotto', 'Mains',    549.00,
 'Creamy Arborio rice slow-cooked with wild mushrooms, finished with black truffle oil and aged Parmesan shavings.',
 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=700&q=85&auto=format&fit=crop', 1),

(1, 'Smoked Salmon Starter',    'Starters', 349.00,
 'Norwegian smoked salmon on toasted sourdough with cream cheese, capers, and fresh dill.',
 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=700&q=85&auto=format&fit=crop', 0),

(1, 'French Onion Soup',        'Starters', 249.00,
 'Classic caramelized onion soup topped with a toasted baguette crouton and melted Gruyère cheese.',
 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=700&q=85&auto=format&fit=crop', 1),

(1, 'Crème Brûlée',             'Desserts', 199.00,
 'Silky vanilla custard with a perfectly caramelized sugar crust. A timeless French classic.',
 'https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?w=700&q=85&auto=format&fit=crop', 1),

(1, 'Fresh Lemonade',           'Drinks',   149.00,
 'Hand-squeezed lemon with a hint of mint and sparkling water. Refreshing and zesty.',
 'https://images.unsplash.com/photo-1621263764928-df1444c5e859?w=700&q=85&auto=format&fit=crop', 1);

-- ============================================================
--  SAMPLE DATA: Menu Items — Sushi Zen (id=2)
-- ============================================================
INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) VALUES
(2, 'Dragon Roll',              'Mains',    649.00,
 'Shrimp tempura and cucumber inside, topped with avocado and spicy mayo drizzle. A fan favorite.',
 'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=700&q=85&auto=format&fit=crop', 0),

(2, 'Salmon Sashimi (6 pc)',    'Starters', 499.00,
 'Premium Atlantic salmon sliced fresh daily, served with wasabi, pickled ginger, and soy sauce.',
 'https://images.unsplash.com/photo-1534482421-64566f976cfa?w=700&q=85&auto=format&fit=crop', 0),

(2, 'Chicken Ramen',            'Mains',    429.00,
 'Rich tonkotsu-style broth with tender chicken chashu, soft-boiled egg, bamboo shoots, and nori.',
 'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=700&q=85&auto=format&fit=crop', 0),

(2, 'Edamame',                  'Starters', 149.00,
 'Steamed and lightly salted young soybeans. A perfect light starter.',
 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?w=700&q=85&auto=format&fit=crop', 1),

(2, 'Mochi Ice Cream',          'Desserts', 249.00,
 'Soft glutinous rice cake filled with premium matcha, strawberry, or vanilla ice cream (choice of 3).',
 'https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=700&q=85&auto=format&fit=crop', 1),

(2, 'Matcha Latte',             'Drinks',   199.00,
 'Ceremonial-grade matcha whisked with steamed oat milk. Earthy, smooth, and energizing.',
 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=700&q=85&auto=format&fit=crop', 1);

-- ============================================================
--  SAMPLE DATA: Menu Items — Bella Italia (id=3)
-- ============================================================
INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) VALUES
(3, 'Pepperoni Supreme Pizza',  'Mains',    499.00,
 'Stone-baked thin crust with tangy tomato base, fresh mozzarella, premium Italian pepperoni, and fresh basil.',
 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=700&q=85&auto=format&fit=crop', 0),

(3, 'Penne Arrabbiata',         'Mains',    349.00,
 'Al dente penne in a spicy San Marzano tomato sauce with garlic, red chilli flakes, and fresh parsley.',
 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=700&q=85&auto=format&fit=crop', 1),

(3, 'Bruschetta al Pomodoro',   'Starters', 199.00,
 'Toasted ciabatta rubbed with garlic, topped with ripe tomatoes, fresh basil, and extra-virgin olive oil.',
 'https://images.unsplash.com/photo-1506280754576-f6fa8a873550?w=700&q=85&auto=format&fit=crop', 1),

(3, 'Tiramisu',                 'Desserts', 249.00,
 'Classic Italian mascarpone cream layered with espresso-soaked ladyfingers and dusted with cocoa powder.',
 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=700&q=85&auto=format&fit=crop', 1),

(3, 'Margherita Pizza',         'Mains',    399.00,
 'The classic. Tomato sauce, fresh buffalo mozzarella, and basil on a hand-stretched stone-baked crust.',
 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=700&q=85&auto=format&fit=crop', 1),

(3, 'Sparkling Lemonade',       'Drinks',   149.00,
 'Italian-style sparkling lemonade with fresh lemon and elderflower. Light and refreshing.',
 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=700&q=85&auto=format&fit=crop', 1);

-- ============================================================
--  SAMPLE DATA: Menu Items — Spice Garden (id=4)
-- ============================================================
INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) VALUES
(4, 'Butter Chicken',           'Mains',    349.00,
 'Tender chicken in a velvety, mildly spiced tomato and cream sauce. Best paired with naan or rice.',
 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=700&q=85&auto=format&fit=crop', 0),

(4, 'Dal Makhani',              'Mains',    249.00,
 'Black lentils slow-cooked overnight with butter, cream, and aromatic spices. A North Indian staple.',
 'https://images.unsplash.com/photo-1546833998-877b37c2e587?w=700&q=85&auto=format&fit=crop', 1),

(4, 'Paneer Tikka',             'Starters', 299.00,
 'Marinated cottage cheese cubes grilled in a tandoor with bell peppers and onions. Served with mint chutney.',
 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=700&q=85&auto=format&fit=crop', 1),

(4, 'Chicken Biryani',          'Mains',    399.00,
 'Fragrant basmati rice cooked with tender chicken, saffron, whole spices, and caramelized onions. Served with raita.',
 'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=700&q=85&auto=format&fit=crop', 0),

(4, 'Gulab Jamun',              'Desserts', 149.00,
 'Soft milk-solid dumplings soaked in rose-flavored sugar syrup. Served warm with a sprinkle of pistachios.',
 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=700&q=85&auto=format&fit=crop', 1),

(4, 'Mango Lassi',              'Drinks',   149.00,
 'Thick and creamy blend of fresh Alphonso mangoes and chilled yogurt. Summer in a glass.',
 'https://images.unsplash.com/photo-1527661591475-527312dd65f5?w=700&q=85&auto=format&fit=crop', 1);

-- ============================================================
--  SAMPLE DATA: Menu Items — Burger Barn (id=5)
-- ============================================================
INSERT INTO menu (restaurant_id, name, category, price, description, image_url, is_veg) VALUES
(5, 'Double Bacon Cheeseburger','Mains',    379.00,
 'Two flame-grilled beef patties, melted cheddar, crispy bacon, fresh lettuce, tomato, and secret burger sauce on a brioche bun.',
 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&q=85&auto=format&fit=crop', 0),

(5, 'Classic Veggie Burger',    'Mains',    279.00,
 'Crispy black bean and corn patty with lettuce, tomato, pickles, and chipotle mayo on a toasted sesame bun.',
 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=700&q=85&auto=format&fit=crop', 1),

(5, 'Loaded Cheese Fries',      'Starters', 199.00,
 'Crispy golden fries smothered with melted cheddar cheese sauce, jalapeños, and sour cream.',
 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=700&q=85&auto=format&fit=crop', 1),

(5, 'Crispy Chicken Wings',     'Starters', 299.00,
 'Juicy chicken wings tossed in your choice of BBQ, buffalo, or honey garlic sauce. Served with ranch dip.',
 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=700&q=85&auto=format&fit=crop', 0),

(5, 'Oreo Milkshake',           'Drinks',   199.00,
 'Thick and indulgent Oreo cookie milkshake blended with vanilla ice cream and topped with whipped cream.',
 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=700&q=85&auto=format&fit=crop', 1),

(5, 'Brownie Sundae',           'Desserts', 249.00,
 'Warm fudgy chocolate brownie topped with vanilla ice cream, hot fudge sauce, and crushed nuts.',
 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=700&q=85&auto=format&fit=crop', 1);

-- ============================================================
--  SAMPLE DATA: Users  (use BCrypt hashing in production!)
-- ============================================================
INSERT INTO users (name, email, password, phone, address) VALUES
('Karthik Sharma', 'karthik@tapyfood.in', 'Test@123', '+91 98765 43210',
 '42, Food Street, Bandra West, Mumbai 400050'),
('Priya Singh', 'priya@tapyfood.in', 'Test@123', '+91 98765 43211',
 '15, Juhu Tara Road, Juhu, Mumbai 400049');

-- ============================================================
--  VERIFICATION QUERIES (uncomment to test)
-- ============================================================
-- SELECT * FROM restaurant;
-- SELECT m.*, r.name AS restaurant_name FROM menu m JOIN restaurant r ON m.restaurant_id = r.id;
-- SELECT * FROM users;

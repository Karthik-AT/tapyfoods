-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: tapyfood_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cart_item` (`user_id`,`menu_id`),
  KEY `fk_cart_menu` (`menu_id`),
  CONSTRAINT `fk_cart_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (10,3,37,1),(11,6,14,1),(24,10,49,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `restaurant_id` int DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `fk_coupon_restaurant` (`restaurant_id`),
  CONSTRAINT `fk_coupon_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,'WELCOME50','flat',50.00,NULL,'2026-07-01 00:00:00','2026-07-15 00:00:00',100.00,1),(2,'SUSHIPROP','percentage',10.00,12,'2026-07-01 00:00:00','2026-07-15 00:00:00',200.00,1),(3,'OLD20','percentage',20.00,NULL,'2026-06-01 00:00:00','2026-07-07 00:00:00',50.00,1),(4,'FIRSTRY','flat',100.00,NULL,'2026-07-01 00:00:00','2030-12-31 00:00:00',149.01,1);
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_veg` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_menu_restaurant` (`restaurant_id`),
  CONSTRAINT `fk_menu_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Veg Pizza','Mains',199.00,'Cheesy Veg Pizza','https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=700&q=80',1,'2026-06-26 05:18:30'),(2,1,'Paneer Pizza','Mains',249.00,'Paneer Loaded Pizza','https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?w=700&q=80',1,'2026-06-26 05:18:30'),(3,2,'Chicken Bucket','Mains',399.00,'Crispy Chicken Bucket','https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=700&q=80',0,'2026-06-26 05:18:30'),(4,2,'Zinger Burger','Mains',179.00,'Chicken Burger','https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=700&q=80',0,'2026-06-26 05:18:30'),(5,3,'Farmhouse Pizza','Mains',299.00,'Veg Loaded Pizza','https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=700&q=80',1,'2026-06-26 05:18:30'),(6,3,'Garlic Bread','Starters',129.00,'Cheesy Garlic Bread','https://images.unsplash.com/photo-1619535860434-ba1d8fa12536?w=700&q=80',1,'2026-06-26 05:18:30'),(7,11,'Grilled Ribeye Steak','Mains',849.00,'Grass-fed ribeye seared to perfection with garlic-herb butter. Served with creamy mashed potatoes and roasted asparagus.','https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=700&q=85',0,'2026-06-26 05:21:40'),(8,11,'Truffle Mushroom Risotto','Mains',549.00,'Creamy Arborio rice slow-cooked with wild mushrooms, finished with black truffle oil and aged Parmesan shavings.','https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=700&q=85',1,'2026-06-26 05:21:40'),(9,11,'Smoked Salmon Starter','Starters',349.00,'Norwegian smoked salmon on toasted sourdough with cream cheese, capers, and fresh dill.','https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=700&q=85',0,'2026-06-26 05:21:40'),(10,11,'French Onion Soup','Starters',249.00,'Classic caramelized onion soup topped with a toasted baguette crouton and melted Gruyère cheese.','https://images.unsplash.com/photo-1547592166-23ac45744acd?w=700&q=85',1,'2026-06-26 05:21:40'),(11,11,'Crème Brûlée','Desserts',199.00,'Silky vanilla custard with a perfectly caramelized sugar crust. A timeless French classic.','https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?w=700&q=85',1,'2026-06-26 05:21:40'),(12,11,'Fresh Lemonade','Drinks',149.00,'Hand-squeezed lemon with a hint of mint and sparkling water. Refreshing and zesty.','https://images.unsplash.com/photo-1621263764928-df1444c5e859?w=700&q=85',1,'2026-06-26 05:21:40'),(13,12,'Dragon Roll','Mains',649.00,'Shrimp tempura and cucumber inside, topped with avocado and spicy mayo drizzle. A fan favorite.','https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=700&q=80',0,'2026-06-26 05:21:40'),(14,12,'Salmon Sashimi (6 pc)','Starters',499.00,'Premium Atlantic salmon sliced fresh daily, served with wasabi, pickled ginger, and soy sauce.','https://images.unsplash.com/photo-1534482421-64566f976cfa?w=700&q=85',0,'2026-06-26 05:21:40'),(15,12,'Chicken Ramen','Mains',429.00,'Rich tonkotsu-style broth with tender chicken chashu, soft-boiled egg, bamboo shoots, and nori.','https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=700&q=85',0,'2026-06-26 05:21:40'),(16,12,'Edamame','Starters',100.00,'Steamed and lightly salted young soybeans. A perfect light starter.','https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?w=700&q=85',1,'2026-06-26 05:21:40'),(17,12,'Mochi Ice Cream','Desserts',249.00,'Soft glutinous rice cake filled with premium matcha, strawberry, or vanilla ice cream (choice of 3).','https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=700&q=85',1,'2026-06-26 05:21:40'),(18,12,'Matcha Latte','Drinks',199.00,'Ceremonial-grade matcha whisked with steamed oat milk. Earthy, smooth, and energizing.','https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=700&q=85',1,'2026-06-26 05:21:40'),(19,13,'Pepperoni Supreme Pizza','Mains',499.00,'Stone-baked thin crust with tangy tomato base, fresh mozzarella, premium Italian pepperoni, and fresh basil.','https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=700&q=85',0,'2026-06-26 05:21:40'),(20,13,'Penne Arrabbiata','Mains',349.00,'Al dente penne in a spicy San Marzano tomato sauce with garlic, red chilli flakes, and fresh parsley.','https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=700&q=85',1,'2026-06-26 05:21:40'),(21,13,'Bruschetta al Pomodoro','Starters',199.00,'Toasted ciabatta rubbed with garlic, topped with ripe tomatoes, fresh basil, and extra-virgin olive oil.','https://images.unsplash.com/photo-1506280754576-f6fa8a873550?w=700&q=85',1,'2026-06-26 05:21:40'),(22,13,'Tiramisu','Desserts',249.00,'Classic Italian cheesecake layered with espresso-soaked ladyfingers and dusted with cocoa powder.','https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=700&q=85',1,'2026-06-26 05:21:40'),(23,13,'Margherita Pizza','Mains',399.00,'The classic. Tomato sauce, fresh buffalo mozzarella, and basil on a hand-stretched stone-baked crust.','https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=700&q=85',1,'2026-06-26 05:21:40'),(24,13,'Sparkling Lemonade','Drinks',149.00,'Italian-style sparkling lemonade with fresh lemon and elderflower. Light and refreshing.','https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=700&q=85',1,'2026-06-26 05:21:40'),(25,14,'Butter Chicken','Mains',349.00,'Tender chicken in a velvety, mildly spiced tomato and cream sauce. Best paired with naan or rice.','https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=700&q=85',0,'2026-06-26 05:21:40'),(26,14,'Dal Makhani','Mains',249.00,'Black lentils slow-cooked overnight with butter, cream, and aromatic spices. A North Indian staple.','https://images.unsplash.com/photo-1546833998-877b37c2e587?w=700&q=85',1,'2026-06-26 05:21:40'),(27,14,'Paneer Tikka','Starters',299.00,'Marinated cottage cheese cubes grilled in a tandoor with bell peppers and onions. Served with mint chutney.','https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=700&q=85',1,'2026-06-26 05:21:40'),(28,14,'Chicken Biryani','Mains',399.00,'Fragrant basmati rice cooked with tender chicken, saffron, whole spices, and caramelized onions. Served with raita.','https://images.unsplash.com/photo-1563379091339-03246963d96c?w=700&q=85',0,'2026-06-26 05:21:40'),(29,14,'Gulab Jamun','Desserts',149.00,'Soft milk-solid dumplings soaked in rose-flavored sugar syrup. Served warm with a sprinkle of pistachios.','https://images.unsplash.com/photo-1601050690597-df0568f70950?w=700&q=85',1,'2026-06-26 05:21:40'),(30,14,'Mango Lassi','Drinks',149.00,'Thick and creamy blend of fresh Alphonso mangoes and chilled yogurt. Summer in a glass.','https://images.unsplash.com/photo-1527661591475-527312dd65f5?w=700&q=85',1,'2026-06-26 05:21:40'),(31,15,'Double Bacon Cheeseburger','Mains',379.00,'Two flame-grilled beef patties, melted cheddar, crispy bacon, fresh lettuce, tomato, and secret burger sauce on a brioche bun.','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&q=85',0,'2026-06-26 05:21:40'),(32,15,'Classic Veggie Burger','Mains',279.00,'Crispy black bean and corn patty with lettuce, tomato, pickles, and chipotle mayo on a toasted sesame bun.','https://images.unsplash.com/photo-1520072959219-c595dc870360?w=700&q=85',1,'2026-06-26 05:21:40'),(33,15,'Loaded Cheese Fries','Starters',199.00,'Crispy golden fries smothered with melted cheddar cheese sauce, jalapeños, and sour cream.','https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=700&q=85',1,'2026-06-26 05:21:40'),(34,15,'Crispy Chicken Wings','Starters',299.00,'Juicy chicken wings tossed in your choice of BBQ, buffalo, or honey garlic sauce. Served with ranch dip.','https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=700&q=85',0,'2026-06-26 05:21:40'),(35,15,'Oreo Milkshake','Drinks',199.00,'Thick and indulgent Oreo cookie milkshake blended with vanilla ice cream and topped with whipped cream.','https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=700&q=85',1,'2026-06-26 05:21:40'),(36,15,'Brownie Sundae','Desserts',249.00,'Warm fudgy chocolate brownie topped with vanilla ice cream, hot fudge sauce, and crushed nuts.','https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=700&q=85',1,'2026-06-26 05:21:40'),(37,4,'Whopper Burger','Mains',199.00,'Flame-grilled chicken patty topped with fresh lettuce, tomatoes, onions, and signature mayonnaise on a toasted sesame seed bun.','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&q=80',0,'2026-06-26 05:24:26'),(38,4,'Crispy Veg Burger','Mains',129.00,'Crispy vegetable patty, shredded lettuce, and creamy mayonnaise.','https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?w=700&q=80',1,'2026-06-26 05:24:26'),(39,5,'McSpicy Chicken Burger','Mains',189.00,'Tender, juicy chicken patty coated in a spicy batter, topped with creamy sauce and lettuce.','https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=700&q=80',0,'2026-06-26 05:24:26'),(40,5,'French Fries (L)','Sides',119.00,'World famous crispy, golden, salted potato fries.','https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=700&q=80',1,'2026-06-26 05:24:26'),(41,6,'Chicken Teriyaki Sub','Mains',259.00,'Tender chicken breast strips glazed with sweet teriyaki sauce, served on freshly baked bread.','https://images.unsplash.com/photo-1509722747041-616f39b57569?w=700&q=80',0,'2026-06-26 05:24:26'),(42,6,'Veg Shammi Sub','Mains',219.00,'A traditional kebab made of lentils and spices, served on warm freshly baked bread.','https://images.unsplash.com/photo-1550507992-eb63ffee0847?w=700&q=80',1,'2026-06-26 05:24:26'),(43,7,'Meghana Chicken Biryani','Mains',349.00,'Spicy, aromatic basmati rice cooked with tender pieces of marinated chicken and secret spices.','https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?w=700&q=80',0,'2026-06-26 05:24:26'),(44,7,'Paneer Biryani','Mains',299.00,'Fragrant basmati rice layered with soft paneer cubes cooked in a rich gravy.','https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=700&q=80',1,'2026-06-26 05:24:26'),(45,8,'Empire Special Ghee Rice','Mains',199.00,'Rich, aromatic basmati rice tossed in pure ghee and topped with fried onions and cashews.','https://images.unsplash.com/photo-1541832676-9b763b0239ab?w=700&q=80',1,'2026-06-26 05:24:26'),(46,8,'Empire Chicken Kabab','Starters',249.00,'Empire style deep-fried marinated chicken, crispy outside and juicy inside.','https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=700&q=80',0,'2026-06-26 05:24:26'),(47,9,'Masala Dosa','Mains',99.00,'Crispy golden crepe stuffed with a savory spiced potato mash, served with sambar and coconut chutney.','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=700&q=80',1,'2026-06-26 05:24:26'),(48,9,'Idli Sambar (2 pc)','Breakfast',69.00,'Soft, steamed rice cakes served with hot lentil sambar and flavorful coconut chutney.','https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=700&q=80',1,'2026-06-26 05:24:26'),(49,10,'BBQ Grilled Skewers (Non-Veg)','Starters',499.00,'Assortment of chicken, fish, and prawn skewers marinated in spices and grilled to perfection.','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=700&q=80',0,'2026-06-26 05:24:26'),(50,10,'Paneer & Veg Skewers','Starters',399.00,'Succulent paneer cubes, capsicum, onions, and mushrooms marinated and grilled.','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=700&q=80',1,'2026-06-26 05:24:26'),(52,20,'KAT(special)','Mains',500.00,'its special','https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=710&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',0,'2026-07-08 20:14:35');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderitems_order` (`order_id`),
  KEY `fk_orderitems_menu` (`menu_id`),
  CONSTRAINT `fk_orderitems_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`),
  CONSTRAINT `fk_orderitems_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,7,1,849.00),(3,3,14,1,499.00),(4,4,43,4,349.00),(5,5,16,4,159.00),(6,6,16,1,100.00),(7,7,43,1,349.00),(8,8,50,1,399.00),(9,9,27,1,299.00),(10,10,49,2,499.00),(11,10,50,2,399.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Placed',
  `delivery_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `coupon_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,889.00,'Placed','honnavar','2026-06-26 10:00:51',NULL),(3,4,539.00,'Delivered','btm layout','2026-07-01 18:05:09',NULL),(4,3,1436.00,'Placed','honnavar','2026-07-03 09:36:47',NULL),(5,8,676.00,'Out for Delivery','airport road, kenjar','2026-07-06 06:11:25',NULL),(6,10,0.00,'Placed','jffkkfsf','2026-07-08 12:05:57',NULL),(7,10,249.00,'Placed','hghjklhgfghj','2026-07-08 13:02:36','FIRSTRY'),(8,10,299.00,'Placed','hghjklhgfghj','2026-07-08 13:02:57','FIRSTRY'),(9,10,299.00,'Placed','hghjklhgfghj','2026-07-08 13:17:23','WELCOME50'),(10,5,1696.00,'Placed','BTM layout','2026-07-08 20:24:05','FIRSTRY');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuisine_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` decimal(2,1) NOT NULL DEFAULT '4.0',
  `delivery_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '30 min',
  `location` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `offer_badge` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `owner_id` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_restaurant_owner` (`owner_id`),
  CONSTRAINT `fk_restaurant_owner` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Pizza Hut','Pizza',4.5,'30 mins','Bangalore','https://images.unsplash.com/photo-1513104890138-7c749659a591?w=700&q=80','15% OFF','Delicious hot pan pizzas topped with fresh veggies and melty mozzarella.','2026-06-26 05:18:30',11,1),(2,'KFC','Chicken',4.2,'25 mins','Bangalore','https://images.unsplash.com/photo-1569058242253-92a9c755a0ec?w=700&q=80','Free piece on ₹499+','Crispy, juicy signature fried chicken, hot wings, and zesty burgers.','2026-06-26 05:18:30',12,1),(3,'Dominos','Pizza',4.4,'20 mins','Bangalore','https://images.unsplash.com/photo-1590947132387-155cc02f3212?w=700&q=80','Buy 1 Get 1','Freshly baked hand-tossed pizzas delivered hot and fresh in 30 minutes.','2026-06-26 05:18:30',13,1),(4,'Burger King','Burger',4.3,'25 mins','Bangalore','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&q=80','Combo deals','Flame-grilled burgers, crispy fries, and refreshing beverages.','2026-06-26 05:18:30',14,1),(5,'McDonalds','Fast Food',4.4,'20 mins','Bangalore','https://images.unsplash.com/photo-1561758033-d89a9ad46330?w=700&q=80','Happy Meal discount','Golden fries, classic burgers, wraps, and ice-cold shakes.','2026-06-26 05:18:30',15,1),(6,'Subway','Sandwich',4.1,'18 mins','Bangalore','https://images.unsplash.com/photo-1509722747041-616f39b57569?w=700&q=80','Sub of the Day','Fresh, healthy, custom-made submarine sandwiches and wraps.','2026-06-26 05:18:30',16,1),(7,'Meghana Foods','Biryani',4.7,'30 mins','Bangalore','images/meghana_store.jpg','Authentic Taste','Famous spicy and aromatic Hyderabadi biryani and Andhra specialties.','2026-06-26 05:18:30',17,1),(8,'Empire Restaurant','Biryani',4.5,'28 mins','Bangalore','https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=700&q=80','Late Night Delivery','Popular multi-cuisine dining known for ghee rice, kebabs, and shawarmas.','2026-06-26 05:18:30',18,1),(9,'Udupi Palace','South Indian',4.3,'15 mins','Bangalore','https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=700&q=80','Pure Veg','Traditional South Indian breakfast, crispy dosas, idlis, and filter coffee.','2026-06-26 05:18:30',19,1),(10,'Barbeque Nation','BBQ',4.6,'35 mins','Bangalore','https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=700&q=80','Unlimited Buffet','Delicious over-the-table grill skewers, main courses, and desserts.','2026-06-26 05:18:30',20,1),(11,'The Grand Bistro','European & Fine Dining',4.9,'25-35 min','Bangalore','https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=700&q=85&auto=format&fit=crop','20% OFF on first order','Classic European dining with a modern twist — artisan pasta, grilled prime steaks, and freshly baked pastries by world-class chefs.','2026-06-26 05:21:40',7,1),(12,'Sushi Zen','Japanese & Sushi',4.8,'30-40 min','Bangalore','https://images.unsplash.com/photo-1583623025817-d180a2221d0a?w=700&q=80','Free Miso Soup','Authentic Japanese delicacies with fresh ingredients flown in daily — traditional sashimi, signature rolls, and savory ramen bowls.','2026-06-26 05:21:40',6,1),(13,'Bella Italia','Italian & Pizza & Pasta',4.7,'20-30 min','Bangalore','images/italian_food.jpg','Buy 2 Get 1 Free','Hand-stretched stone-baked pizzas, rich lasagna, and premium house wines that make every dinner feel like a celebration in Rome.','2026-06-26 05:21:40',21,1),(14,'Spice Garden','Indian & North Indian',4.6,'25-35 min','Bangalore','https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=700&q=85&auto=format&fit=crop','15% OFF weekends','Authentic North Indian cuisine with rich curries, tandoori specialties, and freshly baked naans that bring the flavors of Punjab to your table.','2026-06-26 05:21:40',22,1),(15,'Burger Barn','American & Burgers',4.5,'15-25 min','Bangalore','https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?w=700&q=85&auto=format&fit=crop','Free Fries on ₹499+','Flame-grilled gourmet burgers stacked with fresh ingredients, crispy fries, creamy shakes, and indulgent desserts for the ultimate comfort meal.','2026-06-26 05:21:40',23,1),(20,'KAT','indian',4.5,'30 mins','bengalore','https://images.unsplash.com/photo-1560611588-163f295eb145?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D','New 50% off','special','2026-07-08 20:13:00',24,1);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Karthik Sharma','karthik@tapyfood.in','Test@123','+91 98765 43210','42, Food Street, Bandra West, Mumbai 400050','2026-06-14 16:11:25','customer'),(2,'Priya Singh','priya@tapyfood.in','Test@123','+91 98765 43211','15, Juhu Tara Road, Juhu, Mumbai 400049','2026-06-14 16:11:25','customer'),(3,'Karthik Anand Toolahalli','Karthik@gmail.com','123456789','9353493357','honnavar','2026-06-14 16:49:07','admin'),(4,'Karthik AT','Kat@gmail.com','Karthik@2004','+919353493357','dddd','2026-07-01 17:37:41','admin'),(5,'pream','pream@gmail.com','Pream@2004','+919353493357','honnavar','2026-07-05 11:31:29','customer'),(6,'Sushi Zen Owner','owner@tapyfood.in','123456','9876543210','Bengaluru','2026-07-05 11:36:21','restaurant_owner'),(7,'Bistro Partner','bistro@tapyfood.in','123456','+919353493357','airport road, kenjar','2026-07-05 17:08:03','restaurant_owner'),(8,'Karthik AT','karthik933k@gmail.com','123456','+918951610484','airport road, kenjar','2026-07-06 06:10:54','customer'),(9,'sai palav','sai@tapyfood.in','123456','+919353493357','bengalore','2026-07-06 06:17:55','restaurant_owner'),(10,'hooo','hoo@gmail.com','123456789','56655656565','hghjklhgfghj','2026-07-08 12:04:58','customer'),(11,'Pizza Hut Owner','pizzahut@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(12,'KFC Owner','kfc@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(13,'Dominos Owner','dominos@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(14,'Burger King Owner','burgerking@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(15,'McDonalds Owner','mcdonalds@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(16,'Subway Owner','subway@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(17,'Meghana Foods Owner','meghana@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(18,'Empire Restaurant Owner','empire@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(19,'Udupi Palace Owner','udupipalace@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(20,'Barbeque Nation Owner','barbeque@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(21,'Bella Italia Owner','bellaitalia@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(22,'Spice Garden Owner','spicegarden@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(23,'Burger Barn Owner','burgerbarn@tapyfood.in','123456',NULL,NULL,'2026-07-08 20:01:27','restaurant_owner'),(24,'KAT','kat@tapyfood.in','123456','+919353493357','honnavar','2026-07-08 20:11:30','restaurant_owner');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-09  2:04:27

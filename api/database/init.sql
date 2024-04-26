CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
  `email` VARCHAR(64) UNIQUE NOT NULL,
  `hashed_password` VARBINARY(128) NOT NULL, -- argon2 hash
  `firstname` VARCHAR(64) NOT NULL,
  `lastname` VARCHAR(64) NOT NULL,
  `is_botanist` BOOLEAN NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `plant_post` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `owner_id` INT(11) REFERENCES `user`(`id`) ON DELETE CASCADE,
  `keeper_id` INT(11) REFERENCES `user`(`id`),
  `care_start` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `care_end` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `plant_name` VARCHAR(64) NOT NULL,
  `description` TEXT,
  `image_url` VARCHAR(255) NOT NULL,
  `latitude` DECIMAL(10, 8) NOT NULL,
  `longitude` DECIMAL(10, 8) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `post_id` INT(11) REFERENCES `plant_post`(`id`) ON DELETE CASCADE,
  `user_id` INT(11) REFERENCES `user`(`id`) ON DELETE CASCADE,
  `posting_date` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `content` VARCHAR(1024) NOT NULL,
  `picture` VARCHAR(255)
) ENGINE=InnoDB;


-- DATA --
-- Insert John Doe for testing purposes (password: 'secret')
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('johndoe@email.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$+E3nCbCzkF70jhq8mG2NNA', 'John', 'Doe', false);
-- Insert 20 randomly generated users
-- passwords: 'password'
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('micheldude@email.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Michel', 'Dude', true); 
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('ltumelty1@techcrunch.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Lennard', 'Tumelty', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('mfruchon2@shop-pro.jp', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Marge', 'Fruchon', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('cpembridge3@webeden.co.uk', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Claudius', 'Pembridge', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('gpalomba4@lycos.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Gus', 'Palomba', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('mswainston5@europa.eu', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Maxine', 'Swainston', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('dbeswick6@ft.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Dorie', 'Beswick', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('asantus7@slashdot.org', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Arnuad', 'Santus', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('sswanwick8@hatena.ne.jp', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Stanley', 'Swanwick', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('mcorss9@archive.org', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Margaretta', 'Corss', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('dbeesleya@webs.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Delila', 'Beesley', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('jreyb@amazon.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Jena', 'Rey', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('tecklyc@ucoz.ru', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Tobin', 'Eckly', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('eparrissd@yellowpages.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Edgardo', 'Parriss', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('dlagese@networksolutions.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Duffy', 'Lages', true);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('phincksf@loc.gov', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Prisca', 'Hincks', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('cblanketg@youku.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Carlina', 'Blanket', false);
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('lferrelih@yolasite.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Loutitia', 'Ferreli', false);
-- The folowing user is updated during testing
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('panthere@rose.com', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Panthère', 'Rose', true);
-- The folowing user is deleted during testing
insert into `user` (email, hashed_password, firstname, lastname, is_botanist) values ('thorderj@hatena.ne.jp', '$argon2id$v=19$m=16,t=2,p=1$SjRiOUJ0ZGprQlB3MVlaUw$twZSd0uLREHNawuic84UKg', 'Toni', 'Horder', false);

-- Insert 34 randomly generated plant_post
-- user with id 6 has no posts
-- user with id 19 does not keep any plants
INSERT INTO `plant_post` (`owner_id`, `keeper_id`, `creation_date`, `care_start`, `care_end`, `plant_name`, `description`, `image_url`, `latitude`, `longitude`)
VALUES 
-- The folowing post will be updated during testing
(1, NULL, '2025-10-10 09:30:01', '2024-09-16 10:12:10', '2024-03-29 10:54:21', 'Philodendron hederaceum', 'A trailing plant that loves bright, indirect light. Water once a week.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.856614, 2.3522219),
--
(2, 10, '2023-01-15 18:23:09', '2022-12-31 23:59:59', '2023-03-31 10:00:00', 'Snake plant', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.864716, 2.349014),
(4, 8, '2023-02-01 10:45:32', '2023-01-01 00:00:00', '2023-06-30 23:59:59', 'Monstera deliciosa', 'Likes indirect light and moderate watering. Soil should be kept moist but not soggy.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.865119, 2.329428),
(10, 4, '2023-03-10 15:34:56', '2024-05-20 08:30:00', '2024-07-31 18:00:00', 'Pilea peperomioides', NULL,'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.853938, 2.339797),
(10, NULL, '2023-04-08 22:16:03', '2022-01-01 00:00:00', '2022-02-28 23:59:59', 'Peace lily', 'Prefers low to medium light and moderate watering.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.842033, 2.331122),
(13, 5, '2023-05-02 07:54:12', '2023-07-01 00:00:00', '2023-08-31 23:59:59', 'Spider plant', 'Thrives in bright, indirect light and prefers to be slightly root-bound.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.853815, 2.624794),
(15, 16, '2023-06-19 14:23:45', '2024-01-01 12:00:00', NULL, 'Fiddle leaf fig', 'Needs bright, indirect light and regular watering. Can be prone to leaf drop if conditions are not ideal.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.910648, 2.239050),
(17, 3, '2023-07-11 19:35:22', '2023-09-01 00:00:00', '2024-02-28 23:59:59', 'Rubber plant', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.846222, 2.267974),
(19, 7, '2023-08-23 11:26:39', '2022-06-15 09:00:00', '2022-12-31 23:59:59', 'ZZ plant', 'Prefers low to medium light and infrequent watering. Can be propagated by leaf cuttings.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.885707, 2.343543),
(8, 12, '2023-09-17 01:43:20', '2023-10-01 00:00:00', NULL, 'Bird of paradise', 'Needs bright, indirect light and regular watering. Soil should be well-draining and kept slightly moist.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.836114, 2.337143),
(3, 11, '2023-10-27 08:14:56', '2023-11-01 00:00:00', '2024-01-31 23:59:59', 'Chinese money plant', 'Prefers bright, indirect light and moderate watering. Propagation by offset is easy.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.856461, 2.368439),
(5, 18, '2023-11-05 16:49:34', '2024-02-01 00:00:00', NULL, 'Jade plant', 'Thrives in bright, direct light and prefers to be slightly dry between waterings.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.840585, 2.367710),
(7, 13, '2023-12-01 05:21:01', '2022-08-01 00:00:00', '2022-11-30 23:59:59', 'String of pearls', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.874348, 2.356251),
(9, 1, '2024-01-08 20:09:08', '2024-04-01 00:00:00', '2024-09-30 23:59:59', 'Pothos', 'An easy-to-care-for trailing plant that thrives in low to bright light. Water once a week.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.882563, 2.300984),
(11, 2, '2024-02-22 13:27:45', '2023-05-01 00:00:00', NULL, 'Calathea', 'Loves bright, indirect light and high humidity. Keep soil evenly moist but not waterlogged.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.869488, 2.308360),
(14, 6, '2024-03-11 04:56:02', '2022-10-01 00:00:00', '2023-01-31 23:59:59', 'Aloe vera', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.844478, 2.355294),
(16, 9, '2024-04-02 22:44:29', '2024-08-01 00:00:00', NULL, 'Succulent mix', 'A mix of different types of succulents. Prefers bright, direct light and infrequent watering.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.862190, 2.364082),
(18, 14, '2024-05-15 09:33:56', '2023-02-01 00:00:00', NULL, 'Ficus elastica', 'Also known as the rubber tree. Needs bright, indirect light and regular watering. Soil should be well-draining.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.871985, 2.322161),
(2, 17, '2024-06-07 12:27:43', '2022-09-01 00:00:00', '2022-12-31 23:59:59', 'Dracaena', 'Loves bright, indirect light and moderate watering. Soil should be well-draining.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.870167, 2.364008),
(12, 10, '2024-07-18 21:33:17', '2023-03-01 00:00:00', '2023-04-30 23:59:59', 'Boston fern', 'Prefers high humidity and indirect light. Keep soil moist but not waterlogged.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.888020, 2.324982),
(9, 14, '2024-08-26 02:49:08', '2023-04-27 09:30:00', '2023-05-31 17:00:00', 'Aloe vera', 'Requires bright, indirect light and infrequent watering. Can be used to soothe minor skin irritations.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.833991, 2.332798),
(3, 1, '2024-09-28 07:14:22', '2024-02-14 08:00:00', '2024-05-31 18:00:00', 'Calathea orbifolia', 'Prefers medium to low light and moderate watering. Can be prone to spider mites if conditions are not ideal.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.847136, 2.394780),
(11, 2, '2024-10-30 14:08:08', '2022-11-01 00:00:00', '2023-01-31 23:59:59', 'Pothos', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.864308,  2.359900),
(18, 6, '2024-11-18 19:45:11', '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Dracaena marginata', 'Likes bright, indirect light and moderate watering. Can be sensitive to fluoride in tap water.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.890085, 2.237242),
(7, 13, '2024-12-24 06:01:57', '2023-12-01 00:00:00', NULL, 'ZZ plant', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.868177,2.339131),
(10, 5, '2025-01-11 11:29:12', '2022-04-01 00:00:00', '2022-06-30 23:59:59', 'Fern', 'Prefers high humidity and indirect light. Soil should be kept moist but not waterlogged.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.853746, 2.407532),
(4, NULL, '2025-02-07 18:54:33', '2024-01-01 12:00:00', '2024-02-28 23:59:59', 'Philodendron scandens', NULL, 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.891676, 2.238635),
(15, 17, '2025-03-17 03:17:21', '2022-08-15 10:00:00', '2022-10-31 18:00:00', 'Peace lily', 'Prefers low to medium light and moderate watering. Can be sensitive to chlorine in tap water.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.870676, 2.351045),
-- The folowing post will be deleted during testing
(1, 12, '2025-04-19 14:56:48', '2024-07-01 00:00:00', NULL, 'Monstera adansonii', 'Likes bright, indirect light and moderate watering. Can be trained to climb a trellis or support.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.874849, 2.358584),
--
(16, 3, '2025-05-20 21:33:25', '2023-03-01 00:00:00', '2023-04-30 23:59:59', 'Hoya kerrii', 'Prefers bright, indirect light and infrequent watering. Can be propagated by leaf or stem cuttings.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.861429, 2.365853),
(1, NULL, '2025-06-15 07:45:12', '2023-05-04 14:22:33', '2023-05-11 14:22:33', 'Snake Plant', 'Also known as Sansevieria. Low maintenance plant that requires minimal water and light.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.882631, 2.316097),
(1, 2, '2025-07-28 17:22:45', '2023-05-03 13:30:00', '2023-05-10 13:30:00', 'Peace Lily', 'A popular indoor plant with white flowers. Prefers low light and needs to be watered once a week.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.853533, 2.364475),
(1, 3, '2025-08-14 23:51:34', '2023-04-30 09:15:45', '2023-05-07 09:15:45', 'Spider Plant', 'Produces baby spider plants that can be propagated easily. Needs bright, indirect light and should be watered once a week.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.841843, 2.252826),
(1, NULL, '2025-09-22 12:04:59', '2023-04-28 16:40:22', '2023-05-05 16:40:22', 'Monstera Deliciosa', 'A trendy indoor plant with large, split leaves. Prefers bright, indirect light and should be watered when the top inch of soil is dry.', 'https://res.cloudinary.com/dsjttmslm/image/upload/v1683061030/compte_1_flliuj.png', 48.883081, 2.339415);


-- Insert 143 randomly generated comment
-- user with id 2 has no comments
-- post with id 10 has no comments on it
insert into comment (post_id, user_id, content) values (1, 1, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into comment (post_id, user_id, content) values (2, 1, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into comment (post_id, user_id, content) values (3, 3, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into comment (post_id, user_id, content) values (4, 4, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into comment (post_id, user_id, content) values (5, 5, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (6, 6, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into comment (post_id, user_id, content) values (7, 7, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into comment (post_id, user_id, content) values (8, 8, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into comment (post_id, user_id, content) values (9, 9, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (11, 10, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into comment (post_id, user_id, content) values (11, 11, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into comment (post_id, user_id, content) values (12, 12, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into comment (post_id, user_id, content) values (13, 13, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into comment (post_id, user_id, content) values (14, 14, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into comment (post_id, user_id, content) values (15, 15, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into comment (post_id, user_id, content) values (16, 16, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into comment (post_id, user_id, content) values (17, 17, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (18, 18, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into comment (post_id, user_id, content) values (19, 19, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into comment (post_id, user_id, content) values (20, 20, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into comment (post_id, user_id, content) values (21, 1, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (22, 1, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into comment (post_id, user_id, content) values (23, 3, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into comment (post_id, user_id, content) values (24, 4, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into comment (post_id, user_id, content) values (25, 5, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (26, 6, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into comment (post_id, user_id, content) values (27, 7, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into comment (post_id, user_id, content) values (28, 8, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into comment (post_id, user_id, content) values (29, 9, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into comment (post_id, user_id, content) values (30, 10, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into comment (post_id, user_id, content) values (1, 11, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into comment (post_id, user_id, content) values (2, 12, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into comment (post_id, user_id, content) values (3, 13, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into comment (post_id, user_id, content) values (4, 14, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into comment (post_id, user_id, content) values (5, 15, 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into comment (post_id, user_id, content) values (6, 16, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (7, 17, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into comment (post_id, user_id, content) values (8, 18, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into comment (post_id, user_id, content) values (9, 19, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into comment (post_id, user_id, content) values (1, 20, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into comment (post_id, user_id, content) values (11, 1, 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into comment (post_id, user_id, content) values (12, 3, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into comment (post_id, user_id, content) values (13, 3, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (14, 4, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into comment (post_id, user_id, content) values (15, 5, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into comment (post_id, user_id, content) values (16, 6, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (17, 7, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into comment (post_id, user_id, content) values (18, 8, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into comment (post_id, user_id, content) values (19, 9, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into comment (post_id, user_id, content) values (20, 10, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (21, 11, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into comment (post_id, user_id, content) values (22, 12, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into comment (post_id, user_id, content) values (23, 13, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into comment (post_id, user_id, content) values (24, 14, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (25, 15, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into comment (post_id, user_id, content) values (26, 16, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into comment (post_id, user_id, content) values (27, 17, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into comment (post_id, user_id, content) values (28, 18, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into comment (post_id, user_id, content) values (29, 19, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into comment (post_id, user_id, content) values (30, 20, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into comment (post_id, user_id, content) values (1, 1, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into comment (post_id, user_id, content) values (2, 1, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into comment (post_id, user_id, content) values (3, 3, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into comment (post_id, user_id, content) values (4, 4, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into comment (post_id, user_id, content) values (5, 5, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into comment (post_id, user_id, content) values (6, 6, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into comment (post_id, user_id, content) values (7, 7, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into comment (post_id, user_id, content) values (8, 8, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into comment (post_id, user_id, content) values (9, 9, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into comment (post_id, user_id, content) values (1, 10, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into comment (post_id, user_id, content) values (11, 11, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into comment (post_id, user_id, content) values (12, 12, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into comment (post_id, user_id, content) values (13, 13, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into comment (post_id, user_id, content) values (14, 14, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (15, 15, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into comment (post_id, user_id, content) values (16, 16, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into comment (post_id, user_id, content) values (17, 17, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into comment (post_id, user_id, content) values (18, 18, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into comment (post_id, user_id, content) values (19, 19, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into comment (post_id, user_id, content) values (20, 20, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (21, 1, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into comment (post_id, user_id, content) values (22, 4, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (23, 3, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into comment (post_id, user_id, content) values (24, 4, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (25, 5, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into comment (post_id, user_id, content) values (26, 6, 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into comment (post_id, user_id, content) values (27, 7, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into comment (post_id, user_id, content) values (28, 8, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into comment (post_id, user_id, content) values (29, 9, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into comment (post_id, user_id, content) values (30, 10, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into comment (post_id, user_id, content) values (1, 11, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into comment (post_id, user_id, content) values (2, 12, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into comment (post_id, user_id, content) values (3, 13, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into comment (post_id, user_id, content) values (4, 14, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into comment (post_id, user_id, content) values (5, 15, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into comment (post_id, user_id, content) values (6, 16, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into comment (post_id, user_id, content) values (7, 17, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into comment (post_id, user_id, content) values (8, 18, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into comment (post_id, user_id, content) values (9, 19, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into comment (post_id, user_id, content) values (1, 20, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into comment (post_id, user_id, content) values (1, 1, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into comment (post_id, user_id, content) values (12, 1, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into comment (post_id, user_id, content) values (13, 3, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into comment (post_id, user_id, content) values (14, 4, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into comment (post_id, user_id, content) values (15, 5, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into comment (post_id, user_id, content) values (16, 6, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into comment (post_id, user_id, content) values (17, 7, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into comment (post_id, user_id, content) values (18, 8, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into comment (post_id, user_id, content) values (19, 9, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into comment (post_id, user_id, content) values (20, 10, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (21, 11, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (22, 12, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into comment (post_id, user_id, content) values (23, 13, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into comment (post_id, user_id, content) values (24, 14, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into comment (post_id, user_id, content) values (25, 15, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into comment (post_id, user_id, content) values (26, 16, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into comment (post_id, user_id, content) values (27, 17, 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into comment (post_id, user_id, content) values (28, 18, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into comment (post_id, user_id, content) values (29, 19, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into comment (post_id, user_id, content) values (30, 20, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
-- The folowing comment is updated during testing
insert into comment (post_id, user_id, content) values (1, 1, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
--
insert into comment (post_id, user_id, content) values (2, 3, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into comment (post_id, user_id, content) values (3, 3, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into comment (post_id, user_id, content) values (4, 4, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into comment (post_id, user_id, content) values (5, 5, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into comment (post_id, user_id, content) values (6, 6, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into comment (post_id, user_id, content) values (7, 7, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into comment (post_id, user_id, content) values (8, 8, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into comment (post_id, user_id, content) values (9, 9, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into comment (post_id, user_id, content) values (1, 10, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into comment (post_id, user_id, content) values (11, 11, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into comment (post_id, user_id, content) values (12, 12, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into comment (post_id, user_id, content) values (13, 13, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into comment (post_id, user_id, content) values (14, 14, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into comment (post_id, user_id, content) values (15, 15, 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into comment (post_id, user_id, content) values (16, 16, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into comment (post_id, user_id, content) values (17, 17, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into comment (post_id, user_id, content) values (18, 18, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into comment (post_id, user_id, content) values (19, 19, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into comment (post_id, user_id, content) values (20, 20, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
-- The folowing comment is deleted during testing
insert into comment (post_id, user_id, content) values (21, 1, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
--
insert into comment (post_id, user_id, content) values (22, 4, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into comment (post_id, user_id, content) values (23, 3, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');

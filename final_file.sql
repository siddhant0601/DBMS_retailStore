drop database if exists mybasket;
create database MyBasket;
use MyBasket;

-- SELECT Price as Total_Price_For_Category,1,3,15,16
-- FROM (
-- 	SELECT name, pid as Product_ID, Price, catid 
-- 	FROM Product
-- )
-- PIVOT (
-- 	SUM(price)
-- 	FOR catid
--     IN (1,3,16,15)
-- ) AS Table_SAMPLE;


create table customer(
	cid INT NOT NULL AUTO_INCREMENT unique,
	fname varchar(255) NOT NULL,
	mname varchar(255),
	lname varchar(255),
	email varchar(255) NOT NULL unique,
	password varchar(255) NOT NULL,
	number varchar(20) NOT NULL unique,
	PRIMARY KEY (cid)
);
-- SET SQL_SAFE_UPDATES=0;
-- delete from customer;
-- SET SQL_SAFE_UPDATES=1;

create table Retailer(
	rid INT NOT NULL AUTO_INCREMENT unique,
	fname varchar(255) NOT NULL,
	mname varchar(255),
	lname varchar(255),
	email varchar(255) NOT NULL unique,
	password varchar(255) NOT NULL,
	number varchar(20) NOT NULL unique,
	PRIMARY KEY (rid)
);
create table Address(
	aid INT NOT NULL AUTO_INCREMENT unique,
    cid INT NOT NULL,
	locality varchar(255) NOT NULL,
    pincode varchar(255) NOT NULL,
    state varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    PRIMARY KEY (aid),
    FOREIGN KEY (cid) REFERENCES customer(cid) ON UPDATE CASCADE ON DELETE CASCADE
);
create table category(
	catid int NOT NULL AUTO_INCREMENT unique,
    name VARCHAR(255) NOT NULL,
    primary key (catid)
);
create table Product(
	name varchar(255) NOT NULL,
	pid INT NOT NULL AUTO_INCREMENT unique,
    catid INT NOT NULL,
    rid INT NOT NULL,
    manufacturingDate varchar(255) NOT NULL,
    rating smallint NOT NULL default 0, 
    quantity int NOT NULL ,
    price int NOT NULL,
    PRIMARY KEY (pid),
    FOREIGN KEY (rid) REFERENCES Retailer(rid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (catid) REFERENCES category(catid) ON UPDATE CASCADE ON DELETE CASCADE,
	check (rating<=5),
    check(rating>=0),
    check (price>=0),
    check(quantity>=0)
);
create table department(
    depid int not null unique, 
    name varchar(255) not null,
    dephead varchar(255) not null,
    primary key (depid)
);
create table Admin(
	fname varchar(255) NOT NULL,
	mname varchar(255),
	lname varchar(255),
	email varchar(255) NOT NULL unique,
	password varchar(255) NOT NULL,
    PRIMARY KEY(email,password)
);
create table payment(
	modeofpayment varchar (255) NOT NULL,
    aid int NOT NULL,
    payid int NOT NULL AUTO_INCREMENT unique,
    PRIMARY KEY (payid),
    FOREIGN KEY (aid) REFERENCES address(aid) ON UPDATE CASCADE ON DELETE CASCADE
);
create table  employee(
	name varchar (255) NOT NULL,
    age int NOT NULL,
    number varchar(255),
    eid int NOT NULL AUTO_INCREMENT unique,
    depid int NOT NULL,
    primary key(eid),
    FOREIGN KEY (depid) REFERENCES department(depid) ON UPDATE CASCADE ON DELETE CASCADE,
    check(age>=18)
);
create table cart(
	quantity int NOT NULL,
    price int NOT NULL,
    pid int NOT NULL,
    cid int NOT NULL,
    payid int NOT NULL default -1,
    status varchar(255) default 'not delivered',
    FOREIGN KEY (pid) REFERENCES product(pid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cid) REFERENCES customer(cid) ON UPDATE CASCADE ON DELETE CASCADE
);
create table orderdetails(
    orderdate date NOT NULL,
    payid int not null,
    FOREIGN KEY (payid) REFERENCES payment(payid) ON UPDATE CASCADE ON DELETE CASCADE
);
create table  deliveryboy(
	name varchar (255) NOT NULL,
    age int NOT NULL,
    rating smallint NOT NULL default 0,
    did int NOT NULL AUTO_INCREMENT unique,
    PRIMARY KEY (did),
    check(age>=18),
    check (rating<=5),
    check(rating>=0)
);
create table delivery(
	payid int not null,
	did int not null,
    FOREIGN KEY (did) REFERENCES deliveryboy(did) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (payid) REFERENCES payment(payid) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Retailers
insert into Retailer (rid, fname, mname, lname, email, number, password) values (1, 'Hanes', null, null, 'tdowell0@w3.org', '5801647356', 'bEDiPK');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (2, 'Fruit', null, 'of the Loom', 'igorst1@samsung.com', '6126379145', '2Gtf6VJg1h');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (3, 'Gildan', null, null, 'bgreiser2@house.gov', '6963884617', 'CkvG7jg1');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (4, 'American', null, 'Apparel', 'lmcard3@1und1.de', '4572310937', 'z5ymh8');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (5, 'Nike', null, null, 'chaddow4@gnu.org', '7578526745', '9RpJDGj');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (6, 'Adidas', null, null, 'dtopling5@zdnet.com', '3065571274', 'OxzuwTwU');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (7, 'Under', null, null, 'jmckennan6@thetimes.co.uk', '4463717797', 'dDGyzR');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (8, 'Puma', null, null, 'cfarland7@seesaa.net', '3271178230', 'VTF0G1');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (9, 'Reebok',null, null, 'wstanlick8@vimeo.com', '3346701183', 'Qsnn8B6XVm');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (10, 'The', 'North', 'Face', 'xmajury9@diigo.com', '5426713199', 'a7RPbvPtcuH');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (11, 'Eilis', null, 'Lacelett', 'vlaceletta@macromedia.com', '8656429242', 'S1Ra48Tt8t0t');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (12, 'Dorie', null, 'Leindecker', 'hleindeckerb@elpais.com', '9968272149', 'B6D4EyK');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (13, 'Ferdinand', null, 'Dupoy', 'ddupoyc@sciencedirect.com', '3061111515', 'baxHuC5dii');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (14, 'Lea', null, 'Goudie', 'hgoudied@geocities.jp', '9846058539', 'YSDeqZTxl');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (15, 'Benni', 'Otis', 'Ferrucci', 'oferruccie@deliciousdays.com', '8053786695', 'Q7pK77hCTb3X');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (16, 'Floyd', null, 'Wandrack', 'awandrackf@cpanel.net', '4079322466', '0L9kgZbNFi');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (17, 'Marlee', null, 'Mauditt', 'jmaudittg@thetimes.co.uk', '3166990641', 'rTjjAdVeMBq');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (18, 'Thorndike', 'Skyler', 'Kippling', 'skipplingh@nhs.uk', '4773976213', 'KOCnJTp');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (19, 'Carlo', null, 'MacCaghan', 'lmaccaghani@cdc.gov', '5905539426', '7YL2HE');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (20, 'Deirdre', null, 'Idenden', 'hidendenj@phoca.cz', '6015638974', '1HCXbG9cF7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (21, 'Xerxes', null, 'Reidshaw', 'areidshawk@google.it', '4765780251', 'JoREJpH9p2E');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (22, 'Chrissy', null, 'Skippon', 'cskipponl@boston.com', '2927510532', 'gi6FhtyL6G');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (23, 'Belia', null, 'Davioud', 'ldavioudm@msn.com', '2012910740', 'fR8WHfB');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (24, 'Llewellyn', null, 'O''Day', 'sodayn@yelp.com', '4284053732', 'DEuknMVw');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (25, 'Pearle', null, 'Ellph', 'lellpho@blog.com', '6315633966', 'v0F7BYFo0r');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (26, 'Damian', null, 'Lorkin', 'mlorkinp@yellowpages.com', '1836065415', 'pEo7Zlbx0zLm');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (27, 'Carroll', 'Percival', 'Sainsbury', 'psainsburyq@live.com', '1999871127', 'wS9v2wJ3vpn');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (28, 'Colline', null, 'Ather', 'katherr@acquirethisname.com', '9812294397', 'wWuNVVb');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (29, 'Retha', 'Gretta', 'Skryne', 'gskrynes@vimeo.com', '7058478245', '4JfVteb');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (30, 'Cristabel', null, 'Amiranda', 'camirandat@oakley.com', '1932894847', 'ONYkWXgTdM');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (31, 'Rafe', 'Carlos', 'Styche', 'cstycheu@aol.com', '5041339562', '0VChZEub');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (32, 'Katee', null, 'Kohrs', 'fkohrsv@xinhuanet.com', '9481563162', 'SN2uBp8');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (33, 'Frederik', null, 'Trickey', 'vtrickeyw@springer.com', '3474349523', 'qUDFb726mE');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (34, 'Rodi', 'Justus', 'McCorry', 'jmccorryx@miitbeian.gov.cn', '7921623581', 'KhiiZJM5cE');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (35, 'Elmore', 'Igor', 'Obey', 'iobeyy@lycos.com', '3033204080', '3mTFMcH');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (36, 'Vitoria', null, 'Pettersen', 'apettersenz@yahoo.co.jp', '2045187227', 'rjVEdS3xC');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (37, 'Erv', 'Shem', 'Cowely', 'scowely10@vk.com', '4103330709', '2t9MYeMHhky');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (38, 'Dalila', null, 'Yarnell', 'ayarnell11@bloglines.com', '1964050681', 'O33jdFucWd');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (39, 'Harlie', null, 'Delahunt', 'edelahunt12@umn.edu', '7932355455', 'u7CQTih');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (40, 'Elisha', null, 'Scarlett', 'ascarlett13@fotki.com', '4105053620', '9rs8p39Yz');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (41, 'Dorothy', null, 'Chudleigh', 'kchudleigh14@tripod.com', '4257881045', 'z7fyzSk5');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (42, 'Wilhelmine', 'Franni', 'Rusbridge', 'frusbridge15@geocities.com', '8813474589', 'jLnPakF1IBQx');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (43, 'Filmer', null, 'Morrow', 'bmorrow16@nih.gov', '9351433974', 'Xdk2t6Jd');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (44, 'Chen', null, 'Reddecliffe', 'mreddecliffe17@intel.com', '1921015237', 'K7DFuv8c');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (45, 'Adelle', null, 'Tills', 'ltills18@aboutads.info', '2315194672', 'k1vYLN1f7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (46, 'Georgetta', null, 'Brewers', 'kbrewers19@hostgator.com', '9691772987', 'DwKGJ8q');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (47, 'Donaugh', null, 'Recher', 'jrecher1a@utexas.edu', '4803734877', 's4DYkN');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (48, 'Jorgan', 'Vlad', 'Lethby', 'vlethby1b@pen.io', '7196385701', 'T8YF69zlD3b');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (49, 'Miguel', null, 'Copello', 'kcopello1c@godaddy.com', '8647455907', '9YWlJel');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (50, 'Wald', 'Haily', 'Dabels', 'hdabels1d@google.ru', '9907566254', 'PRgx4a');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (51, 'Gabby', null, 'Gornall', 'tgornall1e@squarespace.com', '5077994711', 'jzfsrwi');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (52, 'Feodora', null, 'Winmill', 'mwinmill1f@imgur.com', '3237556158', '28hddcVD2z9V');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (53, 'Charmain', null, 'Aire', 'aaire1g@csmonitor.com', '7756718937', 'PX0f9ym3TT');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (54, 'Carleton', null, 'Geach', 'ageach1h@virginia.edu', '3846736644', 'rxGIPI');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (55, 'Vale', 'Annmarie', 'Thompkins', 'athompkins1i@xrea.com', '1748221293', 'xNxwRyFr');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (56, 'Hobie', null, 'Molnar', 'pmolnar1j@imgur.com', '6336355613', '98dkAD');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (57, 'Viva', null, 'Lindsley', 'wlindsley1k@wp.com', '8815004256', 'y33ZWqG');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (58, 'Marcus', null, 'Bartholat', 'nbartholat1l@wix.com', '1997195387', 'kGCR6kwVlbj9');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (59, 'Cassy', null, 'Abell', 'uabell1m@slashdot.org', '3983021781', 'MyCR3O');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (60, 'Ev', null, 'Battlestone', 'dbattlestone1n@fema.gov', '7883959205', 'VXoo59');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (61, 'Mariette', null, 'Tureville', 'rtureville1o@bloomberg.com', '9718779641', 'MphcheMlWWO');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (62, 'Cordelie', null, 'Merrifield', 'vmerrifield1p@furl.net', '7419784137', 'YAifBmSRv');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (63, 'Smith', null, 'Landy', 'alandy1q@prweb.com', '4916870252', 'cK6Wu1Qbs');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (64, 'Gabriel', null, 'Drakes', 'edrakes1r@constantcontact.com', '9768013514', 'AiL0GZ');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (65, 'Dyna', null, 'MacIlhagga', 'amacilhagga1s@tinyurl.com', '7585118479', 'YAomRoSVZQE');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (66, 'Mariette', 'Ellette', 'Grzegorzewicz', 'egrzegorzewicz1t@cargocollective.com', '3699370352', 'ipawuVjxYX54');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (67, 'Mildred', null, 'Banasevich', 'mbanasevich1u@wsj.com', '9001592103', 'L7YwuemX5QL');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (68, 'Adel', null, 'Denk', 'edenk1v@sohu.com', '9041142131', 'jL719NKhP');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (69, 'Fernande', 'Dorise', 'Muslim', 'dmuslim1w@tripadvisor.com', '3912421407', 'WxhiQWG9');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (70, 'Goran', null, 'De Mitris', 'pdemitris1x@newsvine.com', '2134606148', 'QerPyBV5');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (71, 'Wenonah', null, 'Windus', 'gwindus1y@usa.gov', '8125390272', 'pMB0Wv');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (72, 'Constantina', null, 'Sansbury', 'asansbury1z@wix.com', '5785718106', 'wdTiUywm');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (73, 'Warde', null, 'Brockie', 'abrockie20@zdnet.com', '4477184370', '3HN4vqtm1');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (74, 'Morten', null, 'Cartman', 'bcartman21@cdbaby.com', '2117222956', 'X8aimCuERmb');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (75, 'Judi', null, 'Trudgeon', 'ltrudgeon22@scientificamerican.com', '3053350278', 'tUX1hgzs3');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (76, 'Gisela', null, 'Mansbridge', 'hmansbridge23@biblegateway.com', '5584672257', 'pIcVwpJ0ch');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (77, 'Garek', null, 'Ronchetti', 'dronchetti24@tiny.cc', '5163808315', 'bZtrN7bG2Mq');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (78, 'Clarke', null, 'Jonson', 'mjonson25@mozilla.org', '2387422484', 'mfmPYZp');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (79, 'Becky', null, 'Blazewski', 'ablazewski26@altervista.org', '7964966664', '6c2JiPfpjm');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (80, 'Desi', null, 'Pietraszek', 'apietraszek27@drupal.org', '4562354903', 'rSrp1Hmk2P');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (81, 'Phaedra', null, 'Sweynson', 'rsweynson28@phoca.cz', '9066389162', 'GcKr4MFfIZmG');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (82, 'Conan', 'Yehudit', 'Sherwin', 'ysherwin29@arizona.edu', '3198617309', 'ra72ko0qbsN');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (83, 'Mic', null, 'Riddeough', 'lriddeough2a@dagondesign.com', '1044047801', 'AagVjIA2m');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (84, 'Gwyneth', null, 'Giacobazzi', 'fgiacobazzi2b@ebay.co.uk', '6309919755', 'xb6I3rUTEu70');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (85, 'Erek', 'Faina', 'Dubbin', 'fdubbin2c@nasa.gov', '4308268340', 'YWdVHz7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (86, 'Irita', null, 'Chalcot', 'cchalcot2d@odnoklassniki.ru', '9179200786', 'K3BXpxk6');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (87, 'Kerwin', null, 'Mandeville', 'vmandeville2e@spotify.com', '1306386079', '61oliNTlQe');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (88, 'Minta', 'Cal', 'Minerdo', 'cminerdo2f@sfgate.com', '8064989924', 'UhVyaQ');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (89, 'Nevil', 'Rodrique', 'Alsina', 'ralsina2g@creativecommons.org', '7334114071', '1W4Tn36D');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (90, 'Faustina', 'Honoria', 'Atmore', 'hatmore2h@theguardian.com', '5348276639', 'meFgpy');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (91, 'Cymbre', null, 'Baldrick', 'gbaldrick2i@mapy.cz', '6713376466', 'giW6KLKn2ue');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (92, 'Murvyn', 'Maribeth', 'Cuskery', 'mcuskery2j@aol.com', '8619425461', 'kDmt2W');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (93, 'Theobald', 'Sharia', 'Osgar', 'sosgar2k@spotify.com', '8829842048', 'g1P4jHTZBx');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (94, 'Woodie', null, 'Rapp', 'srapp2l@bandcamp.com', '4713091101', 'bEZaAc8Z');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (95, 'Christa', null, 'Stoving', 'jstoving2m@vistaprint.com', '6543489544', 'mCWN9zd7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (96, 'Dominique', 'Read', 'Greder', 'rgreder2n@ifeng.com', '5778288658', 'H65NTfLD79');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (97, 'Brendan', null, 'Suermeier', 'ssuermeier2o@weibo.com', '5991762068', 'UA35vvd6');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (98, 'Margarete', null, 'D''Antoni', 'adantoni2p@hibu.com', '2545746499', 'wsZSujt');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (99, 'Amata', null, 'Mityukov', 'amityukov2q@intel.com', '9646930915', 'GyzS4i4hOUe');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (100, 'Rainer', null, 'Brickwood', 'cbrickwood2r@biglobe.ne.jp', '9135024575', 'NlYmHY4');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (101, 'Athene', null, 'Lamcken', 'jlamcken0@marriott.com', '2232951826', 'WUmWxh');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (102, 'Adan', 'Teri', 'Beneyto', 'tbeneyto1@ehow.com', '1337156476', '1vzzyr0F');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (103, 'Lela', 'Averill', 'Gave', 'agave2@boston.com', '4497065237', 'jZcKMjfg');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (104, 'Morganne', null, 'Punch', 'spunch3@tiny.cc', '3261675650', 'EYSg1txHT7jy');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (105, 'Karisa', null, 'Maultby', 'qmaultby4@nih.gov', '3591671052', 'N1LEu5H');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (106, 'Rosalynd', null, 'Kirsch', 'wkirsch5@phoca.cz', '1884869535', 'FPuc5QoMS');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (107, 'Ddene', null, 'Poulden', 'apoulden6@amazon.co.uk', '9124225132', 'HIBqGC');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (108, 'Garald', 'Noella', 'Menier', 'nmenier7@biglobe.ne.jp', '5568674971', 'Iu18SH');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (109, 'Adelheid', null, 'Ciobutaru', 'eciobutaru8@walmart.com', '8175257218', 'aKZk4sPc');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (110, 'Stan', null, 'Stead', 'ustead9@cam.ac.uk', '6885272237', 'v4wGFJOt');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (111, 'Northrup', 'Fields', 'Blakeney', 'fblakeneya@1und1.de', '2515081163', 'UNWbZXHVBG19');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (112, 'Caritta', null, 'Burlingham', 'mburlinghamb@wikispaces.com', '7892841881', 'FxXQGT9nU');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (113, 'Haroun', null, 'Warrell', 'awarrellc@e-recht24.de', '3891401279', 'JOF3Ax');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (114, 'Josey', null, 'Yakunchikov', 'pyakunchikovd@jalbum.net', '8734150258', '3dzHQMV8iu');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (115, 'Royal', 'Aindrea', 'Rubie', 'arubiee@paypal.com', '4668866570', '4xLnP1dXJmRC');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (116, 'Rose', null, 'Travis', 'ftravisf@trellian.com', '5183429767', '1F1EdL');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (117, 'Lexy', 'Monti', 'Claige', 'mclaigeg@google.co.jp', '1638510925', 'taHwK6O');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (118, 'Brianne', null, 'Cliss', 'hclissh@earthlink.net', '3085379339', 'P7dMToT');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (119, 'Melonie', 'Idelle', 'Shillingford', 'ishillingfordi@mozilla.com', '4309363763', 'iXTANlYTeRnQ');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (120, 'Ave', null, 'Berryman', 'sberrymanj@sciencedirect.com', '7927961872', 'D5Gv8Q');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (121, 'Oswell', null, 'Fullerlove', 'hfullerlovek@theguardian.com', '2514446428', '7MA0yTZepdul');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (122, 'Bernardina', null, 'Buttress', 'hbuttressl@netvibes.com', '2811875357', '2Ien5WD');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (123, 'Issie', 'Diannne', 'Domeny', 'ddomenym@booking.com', '9835021885', '2IM6l0IApyuu');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (124, 'Jarad', null, 'Mingay', 'hmingayn@google.es', '9115232607', 'LpXU0Ou');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (125, 'Linus', null, 'Reith', 'mreitho@phpbb.com', '4997790769', 'Czkx5swL');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (126, 'Arturo', null, 'Dominico', 'bdominicop@digg.com', '9259088850', 'igpgXHm08rsV');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (127, 'Dev', null, 'Flinders', 'jflindersq@naver.com', '1602135205', 'YrcQCbBqn7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (128, 'Heda', null, 'Mahoney', 'dmahoneyr@ucoz.com', '3553186173', 'Tv8uu2YR4j');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (129, 'Roch', null, 'Risley', 'drisleys@marriott.com', '5636681926', 'mHqkC5');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (130, 'Howie', null, 'Harrison', 'mharrisont@blinklist.com', '6786980634', 'SAkpOU800');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (131, 'Corissa', null, 'Painter', 'epainteru@imageshack.us', '2491827603', 'sqJNarNn');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (132, 'Bradley', null, 'Stickins', 'rstickinsv@nationalgeographic.com', '3051206455', 'HAM3zJ97');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (133, 'Rubia', null, 'Cairney', 'scairneyw@taobao.com', '3103999756', 'v3RkyuPu0K');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (134, 'Rosalind', 'Meade', 'Scapens', 'mscapensx@goodreads.com', '5967982741', 'rdMXwTd3lhj6');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (135, 'Hobey', null, 'McDonand', 'cmcdonandy@nbcnews.com', '7365287261', 'APRpJj');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (136, 'Rheta', null, 'Feld', 'afeldz@ft.com', '9137513659', 'mxZKeH3');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (137, 'Cornela', null, 'Iacobini', 'jiacobini10@ibm.com', '3315656851', '40iA617j8B');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (138, 'Marena', null, 'McTrustram', 'gmctrustram11@google.de', '2428669791', 'egx6aYF7k4h6');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (139, 'Bobbye', null, 'Hurdwell', 'churdwell12@economist.com', '1241794273', 'NyZadO');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (140, 'Esteban', null, 'Borge', 'mborge13@archive.org', '4492225595', 'IF33vuiWv2u');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (141, 'Frederigo', null, 'Benting', 'sbenting14@twitter.com', '6831836861', 'WFliBJXV0D');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (142, 'Austin', 'Nickola', 'Rodbourne', 'nrodbourne15@washingtonpost.com', '3738071054', '1g88UAd');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (143, 'Beret', 'Ninnetta', 'Leathes', 'nleathes16@uol.com.br', '2146185069', 'aEEdy9Ec4O');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (144, 'Konrad', null, 'Lummis', 'tlummis17@cbc.ca', '5568736428', 'ZjwWO2');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (145, 'Charmane', 'Milo', 'Flintuff', 'mflintuff18@illinois.edu', '9848636474', 'Uew9MC');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (146, 'Dyna', null, 'McGairl', 'lmcgairl19@webnode.com', '8738053062', 'H4ZkAEfs');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (147, 'Padriac', null, 'Pattisson', 'gpattisson1a@abc.net.au', '9163632567', 'tj8qrOrRjPCP');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (148, 'Wallie', null, 'Waskett', 'ewaskett1b@microsoft.com', '4435259907', 'K8BYP6hBC');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (149, 'Tiffany', 'Jelene', 'Slimings', 'jslimings1c@nifty.com', '2801556145', 'HntdVcBe');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (150, 'Margit', 'Quincey', 'Sharper', 'qsharper1d@reuters.com', '6265238673', 'hDChrrM');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (151, 'Haskell', null, 'Cherry', 'jcherry1e@jimdo.com', '9155040595', 'VUEydMC6c1oo');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (152, 'Schuyler', null, 'Frake', 'sfrake1f@1688.com', '7402306883', 'Ll9RZL0jcrB');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (153, 'Ediva', null, 'Vankov', 'lvankov1g@4shared.com', '8438715613', '9kjNajp7');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (154, 'Jessy', 'Dagny', 'Diggons', 'ddiggons1h@multiply.com', '7824312876', 'g9vXKLdo');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (155, 'Pavla', null, 'Breeton', 'lbreeton1i@miibeian.gov.cn', '7596157294', 'wgFu51Dg5eAf');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (156, 'Debbie', null, 'Pankhurst.', 'wpankhurst1j@samsung.com', '5718671108', 'RIgo7xu3X5cM');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (157, 'Reiko', null, 'Skully', 'bskully1k@ycombinator.com', '6468855214', 'ze8MqHthlfi');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (158, 'Terrie', 'Henrie', 'Chittenden', 'hchittenden1l@unicef.org', '8076695991', '3NBrbOSIAVRb');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (159, 'Leese', null, 'Mungane', 'imungane1m@admin.ch', '4236410293', 'eG1C9zg7AL');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (160, 'Quintus', 'Olin', 'Bricham', 'obricham1n@weather.com', '6501107815', 'WyUE5U');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (161, 'Nell', 'Kally', 'Trayford', 'ktrayford1o@pen.io', '1298806620', 'xfik3VDAj');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (162, 'Elvin', null, 'Cannaway', 'bcannaway1p@wp.com', '3581407225', 'VVAVYk');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (163, 'Liliane', null, 'McReynolds', 'lmcreynolds1q@istockphoto.com', '4806703739', 'jYv5ZmFiaBG');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (164, 'Luz', 'Elnora', 'Sibery', 'esibery1r@nymag.com', '3982963761', '74ddITxYp');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (165, 'Joane', null, 'Jellicorse', 'mjellicorse1s@google.ca', '1341188781', '9ApcSiAdGw');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (166, 'Ase', 'Lyssa', 'Alessandrini', 'lalessandrini1t@phpbb.com', '3426218936', 'HnQ5awQaU');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (167, 'Osborne', 'Willyt', 'Jagiela', 'wjagiela1u@uol.com.br', '5369426134', 'fDqAU55ijA');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (168, 'Imelda', null, 'Demicoli', 'kdemicoli1v@eventbrite.com', '4969549822', 'XnBK3gZ');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (169, 'Harcourt', null, 'Lashmar', 'ilashmar1w@marketwatch.com', '5342243544', 'L3aMOru2hUb');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (170, 'Selestina', null, 'Triggle', 'ftriggle1x@joomla.org', '7237550376', 'M7OF7S');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (171, 'Ellissa', null, 'Bazell', 'ebazell1y@paginegialle.it', '2643197273', '5GXhfLQ');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (172, 'Dalston', null, 'Whitlam', 'dwhitlam1z@forbes.com', '4976806264', 'k6DerqA');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (173, 'Daisy', 'Eada', 'Arrell', 'earrell20@buzzfeed.com', '2309482669', 'hctO7vh');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (174, 'Fredia', null, 'Hartnup', 'dhartnup21@ifeng.com', '8968421811', 'xzer0G');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (175, 'Tammie', null, 'Pilsbury', 'apilsbury22@123-reg.co.uk', '5779169344', 'CohmwCHnaQGc');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (176, 'Say', null, 'Ferreri', 'gferreri23@canalblog.com', '7849955595', '89wpzEl');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (177, 'Lorie', null, 'Paal', 'cpaal24@quantcast.com', '1929700351', 'ghc8b3on');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (178, 'Brynna', null, 'Fullbrook', 'sfullbrook25@tumblr.com', '5697017944', '1KhdaziozCX');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (179, 'Stavros', null, 'Fillgate', 'bfillgate26@icq.com', '5573143321', '8LsSVmA6');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (180, 'Arv', null, 'Willbourne', 'awillbourne27@whitehouse.gov', '8002888732', 'b2vuSvcy');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (181, 'Jackie', null, 'Cassie', 'ccassie28@liveinternet.ru', '3173770410', '8dBtEobo0GC5');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (182, 'Johnathan', null, 'Fellis', 'cfellis29@ox.ac.uk', '2827297323', 'SsIncGNwupx3');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (183, 'Constancy', null, 'Jenteau', 'kjenteau2a@ehow.com', '7524463949', 'VgprImnn0y');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (184, 'Burnaby', null, 'Saban', 'bsaban2b@virginia.edu', '6804781464', 'RxhDiZ2');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (185, 'Rodrique', null, 'Zebedee', 'bzebedee2c@senate.gov', '6193315173', 't5q1yI6ZWXEw');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (186, 'Earlie', null, 'Staresmeare', 'hstaresmeare2d@furl.net', '1188586263', 'zIpk9x4b');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (187, 'Rosalie', 'Gerty', 'Guilfoyle', 'gguilfoyle2e@answers.com', '7858321163', 'WJ8VcGAFKV');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (188, 'Nilson', null, 'Huitson', 'chuitson2f@ucoz.ru', '4822023021', 'kMrd4GhPm');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (189, 'Bryna', null, 'Reade', 'lreade2g@multiply.com', '8677291984', 'g3iAcVVS63');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (190, 'Dean', null, 'Baldrey', 'vbaldrey2h@nba.com', '9052149472', 'U3d5UkK6kUIc');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (191, 'Brandea', null, 'Fishpond', 'lfishpond2i@purevolume.com', '1606958428', 'MpxXGvOmo');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (192, 'Ralina', 'Virgil', 'Sagg', 'vsagg2j@icio.us', '7143204588', '9WFTH2sUNOP');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (193, 'Prescott', null, 'Killingbeck', 'mkillingbeck2k@tumblr.com', '9789303572', 'HbtBaq');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (194, 'Koressa', null, 'Levins', 'slevins2l@amazon.co.jp', '4904550375', '1P66puV6i1v');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (195, 'Luce', null, 'McAneny', 'smcaneny2m@hugedomains.com', '3206067381', 'Grcqenxe5');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (196, 'Nerita', 'Anthia', 'Maguire', 'amaguire2n@acquirethisname.com', '1778580240', 'YhG8z0m499s');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (197, 'Frans', null, 'Perrot', 'bperrot2o@mlb.com', '5995835068', 'hwLMtPN0Xg');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (198, 'Wilone', null, 'Sallowaye', 'csallowaye2p@marriott.com', '7192822013', '8PtmpTHrjkav');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (199, 'Alisander', null, 'Major', 'dmajor2q@free.fr', '8273140004', 'zv9ea82Zq5M');
insert into Retailer (rid, fname, mname, lname, email, number, password) values (200, 'Glennis', null, 'Fairholme', 'gfairholme2r@lulu.com', '9868304704', '7MkU34v');

-- Customers
insert into Customer (cid, fname, mname, lname, email, number, password) values (1, 'Braden', null, 'Chesters', 'mchesters0@guardian.co.uk', '1669126667', 'NTSwYf');
insert into Customer (cid, fname, mname, lname, email, number, password) values (2, 'Brit', null, 'Ambrozik', 'mambrozik1@last.fm', '7129878320', 'CvSYtXzhF');
insert into Customer (cid, fname, mname, lname, email, number, password) values (3, 'Angie', null, 'Canedo', 'gcanedo2@ustream.tv', '6373100174', 'PtGEnXe7');
insert into Customer (cid, fname, mname, lname, email, number, password) values (4, 'Faye', null, 'Wigginton', 'cwigginton3@si.edu', '2122369003', '2zbjOp');
insert into Customer (cid, fname, mname, lname, email, number, password) values (5, 'Brynna', null, 'Rance', 'lrance4@chronoengine.com', '2573899720', 'GuXmWcG');
insert into Customer (cid, fname, mname, lname, email, number, password) values (6, 'Allene', 'Willi', 'Bigglestone', 'wbigglestone5@buzzfeed.com', '6245087251', 'sXdwffJXzqau');
insert into Customer (cid, fname, mname, lname, email, number, password) values (7, 'Bryce', null, 'Meates', 'jmeates6@chicagotribune.com', '1842095277', 'gIJflaj');
insert into Customer (cid, fname, mname, lname, email, number, password) values (8, 'Ethan', null, 'Mulhall', 'jmulhall7@over-blog.com', '4425756848', 'vCTa0Li');
insert into Customer (cid, fname, mname, lname, email, number, password) values (9, 'Wallie', null, 'McGlone', 'amcglone8@amazon.co.jp', '4165948130', 'wkJtwjM');
insert into Customer (cid, fname, mname, lname, email, number, password) values (10, 'Car', null, 'McMurraya', 'lmcmurraya9@amazonaws.com', '2023986497', 'zcBdMLWE');
insert into Customer (cid, fname, mname, lname, email, number, password) values (11, 'Tamra', 'Nichole', 'Glanfield', 'nglanfielda@cisco.com', '8551407289', 'Ombzh3z');
insert into Customer (cid, fname, mname, lname, email, number, password) values (12, 'Neale', null, 'Earingey', 'bearingeyb@fda.gov', '3507406437', 'f0pBEqbt');
insert into Customer (cid, fname, mname, lname, email, number, password) values (13, 'Arabelle', null, 'Bow', 'kbowc@boston.com', '2806445909', 'SDF5UB');
insert into Customer (cid, fname, mname, lname, email, number, password) values (14, 'Sammy', null, 'Henriet', 'shenrietd@hao123.com', '6266279545', 'kTdzAOI7eDm');
insert into Customer (cid, fname, mname, lname, email, number, password) values (15, 'Rawley', null, 'Junifer', 'ejunifere@elegantthemes.com', '1334211767', 'VU9xtuc');
insert into Customer (cid, fname, mname, lname, email, number, password) values (16, 'Yance', null, 'Hatzar', 'jhatzarf@squidoo.com', '1008377459', '6Fvl2dqd');
insert into Customer (cid, fname, mname, lname, email, number, password) values (17, 'Nicolas', null, 'Carmel', 'gcarmelg@macromedia.com', '5774011309', 'NhyEnVnV');
insert into Customer (cid, fname, mname, lname, email, number, password) values (18, 'Leda', null, 'Paice', 'epaiceh@google.de', '5867003341', 'Ro06zwpgF1p');
insert into Customer (cid, fname, mname, lname, email, number, password) values (19, 'Giuditta', null, 'Bardsley', 'cbardsleyi@whitehouse.gov', '6082213884', 'TTh51saTz1Jv');
insert into Customer (cid, fname, mname, lname, email, number, password) values (20, 'Grace', null, 'Bakhrushkin', 'bbakhrushkinj@archive.org', '5676589732', 'IPcK5OBPjcCc');
insert into Customer (cid, fname, mname, lname, email, number, password) values (21, 'Hadria', null, 'Cleal', 'eclealk@domainmarket.com', '5087824944', 'tbDLPDZQO6');
insert into Customer (cid, fname, mname, lname, email, number, password) values (22, 'Sanderson', null, 'O''Deegan', 'codeeganl@sitemeter.com', '6335358585', 'rxJJAJ');
insert into Customer (cid, fname, mname, lname, email, number, password) values (23, 'Reinaldos', null, 'Durman', 'udurmanm@upenn.edu', '9539436361', 'bwkxA9lD');
insert into Customer (cid, fname, mname, lname, email, number, password) values (24, 'Marietta', null, 'Pyper', 'epypern@arizona.edu', '2032293449', 'NPRHpnn');
insert into Customer (cid, fname, mname, lname, email, number, password) values (25, 'Beitris', null, 'Lackington', 'nlackingtono@techcrunch.com', '2967481014', 'OrkMBFOK');
insert into Customer (cid, fname, mname, lname, email, number, password) values (26, 'Darrelle', 'Waylan', 'Golton', 'wgoltonp@disqus.com', '1281604199', 'RtZtxD');
insert into Customer (cid, fname, mname, lname, email, number, password) values (27, 'Jacqueline', null, 'Gerrett', 'agerrettq@about.com', '2592028096', 'v71MYX');
insert into Customer (cid, fname, mname, lname, email, number, password) values (28, 'Innis', 'Myrwyn', 'Rattray', 'mrattrayr@naver.com', '5964522430', 'M4kmty3mTNc');
insert into Customer (cid, fname, mname, lname, email, number, password) values (29, 'Rhett', null, 'Ogles', 'logless@phpbb.com', '3192966766', 'BsZW0en');
insert into Customer (cid, fname, mname, lname, email, number, password) values (30, 'Karole', null, 'MacEvilly', 'lmacevillyt@free.fr', '3535727790', 'FCEacFNr');
insert into Customer (cid, fname, mname, lname, email, number, password) values (31, 'Nickolaus', null, 'Franzewitch', 'jfranzewitchu@google.com.au', '1611238155', 'GBSLtfFt4oSG');
insert into Customer (cid, fname, mname, lname, email, number, password) values (32, 'Caro', null, 'Speck', 'lspeckv@mac.com', '3053707717', 's3gab7Wb');
insert into Customer (cid, fname, mname, lname, email, number, password) values (33, 'Silvie', null, 'Paylor', 'epaylorw@hp.com', '7135788070', '0be3Iu3m49Sv');
insert into Customer (cid, fname, mname, lname, email, number, password) values (34, 'Sissie', null, 'Labb', 'clabbx@dailymotion.com', '4625100842', '892xCm1y');
insert into Customer (cid, fname, mname, lname, email, number, password) values (35, 'Dewey', null, 'Karchowski', 'fkarchowskiy@vkontakte.ru', '8381956128', 'YLS8AyAGKSd');
insert into Customer (cid, fname, mname, lname, email, number, password) values (36, 'Sherline', null, 'Webb', 'dwebbz@mtv.com', '1001845863', 'tRmbrEuK4T');
insert into Customer (cid, fname, mname, lname, email, number, password) values (37, 'Harman', 'Konrad', 'Olliff', 'kolliff10@amazon.com', '1941456775', 'fi6YHfeg');
insert into Customer (cid, fname, mname, lname, email, number, password) values (38, 'Oralia', null, 'Brombell', 'nbrombell11@hugedomains.com', '8932370100', 'SWjUtu');
insert into Customer (cid, fname, mname, lname, email, number, password) values (39, 'Darn', null, 'Keveren', 'lkeveren12@printfriendly.com', '1208970124', 'C5OvE4xCz3Y');
insert into Customer (cid, fname, mname, lname, email, number, password) values (40, 'Phedra', 'Bertie', 'Dicky', 'bdicky13@liveinternet.ru', '8503565884', '5xbKvSddoYTm');
insert into Customer (cid, fname, mname, lname, email, number, password) values (41, 'Chevy', null, 'Staig', 'lstaig14@apache.org', '7857125091', 'CUolDTBsEQ');
insert into Customer (cid, fname, mname, lname, email, number, password) values (42, 'Celka', null, 'Dunlap', 'adunlap15@netlog.com', '3808681425', 'B8RItEKUKz5U');
insert into Customer (cid, fname, mname, lname, email, number, password) values (43, 'Caterina', null, 'Carrabot', 'mcarrabot16@altervista.org', '7363938860', 'brs5UhQ');
insert into Customer (cid, fname, mname, lname, email, number, password) values (44, 'Sam', null, 'Gorham', 'lgorham17@webnode.com', '3226218962', 'cqsUG1xUx');
insert into Customer (cid, fname, mname, lname, email, number, password) values (45, 'Gonzalo', null, 'Clemenceau', 'jclemenceau18@wordpress.org', '3701156617', 'tpWBc1DRMA2');
insert into Customer (cid, fname, mname, lname, email, number, password) values (46, 'Moe', 'Seline', 'Lovat', 'slovat19@prweb.com', '7038959553', 'UQaYR3l');
insert into Customer (cid, fname, mname, lname, email, number, password) values (47, 'Benny', null, 'Heis', 'gheis1a@goo.ne.jp', '5292523767', 'tWUEA5wx0FOa');
insert into Customer (cid, fname, mname, lname, email, number, password) values (48, 'Heywood', null, 'Maryet', 'jmaryet1b@scribd.com', '9786597613', 'r8By8OtNOW');
insert into Customer (cid, fname, mname, lname, email, number, password) values (49, 'Berne', null, 'McLese', 'tmclese1c@reddit.com', '6557875034', 'rluGW6x96xG');
insert into Customer (cid, fname, mname, lname, email, number, password) values (50, 'Barbe', null, 'Conniam', 'bconniam1d@pbs.org', '5349768786', 'PKjuD4xA');
insert into Customer (cid, fname, mname, lname, email, number, password) values (51, 'Kahaleel', null, 'Posvner', 'iposvner1e@mail.ru', '2984889970', 'Mceu4pJaax');
insert into Customer (cid, fname, mname, lname, email, number, password) values (52, 'Rowen', null, 'McLeod', 'hmcleod1f@pagesperso-orange.fr', '5207882645', 'nwF4n0');
insert into Customer (cid, fname, mname, lname, email, number, password) values (53, 'Barrie', 'Libby', 'Crighten', 'lcrighten1g@issuu.com', '1077081455', 'rJ2MHse8xMW');
insert into Customer (cid, fname, mname, lname, email, number, password) values (54, 'Odell', null, 'Halladay', 'khalladay1h@samsung.com', '9484851279', 'tYPuQZBa');
insert into Customer (cid, fname, mname, lname, email, number, password) values (55, 'Willette', null, 'Rooms', 'arooms1i@nyu.edu', '9633286941', 'oL03aPkbSS');
insert into Customer (cid, fname, mname, lname, email, number, password) values (56, 'Flory', 'Hobart', 'Jon', 'hjon1j@ucoz.ru', '1193687909', 'UKvOJ6');
insert into Customer (cid, fname, mname, lname, email, number, password) values (57, 'Robina', null, 'McSorley', 'gmcsorley1k@mysql.com', '5298328430', 'KQ5V4ciBl');
insert into Customer (cid, fname, mname, lname, email, number, password) values (58, 'Kai', 'Guglielma', 'Benz', 'gbenz1l@rediff.com', '7434353534', 'l9pgCi');
insert into Customer (cid, fname, mname, lname, email, number, password) values (59, 'Brucie', null, 'Dade', 'zdade1m@xing.com', '7356439276', 'q3j4tafdjnI');
insert into Customer (cid, fname, mname, lname, email, number, password) values (60, 'Wolfie', 'Sissie', 'Scraney', 'sscraney1n@g.co', '1986094690', '1EfTossdT');
insert into Customer (cid, fname, mname, lname, email, number, password) values (61, 'Winifred', 'Merola', 'Lennox', 'mlennox1o@squarespace.com', '7513990659', 'dNVbPzk');
insert into Customer (cid, fname, mname, lname, email, number, password) values (62, 'Clari', null, 'Lindenboim', 'hlindenboim1p@gnu.org', '2011425735', '5JnZKRxE');
insert into Customer (cid, fname, mname, lname, email, number, password) values (63, 'Millicent', null, 'Woodcroft', 'bwoodcroft1q@about.com', '9974028647', 'aPSUs28rZJyF');
insert into Customer (cid, fname, mname, lname, email, number, password) values (64, 'Rachael', null, 'Dootson', 'adootson1r@jigsy.com', '3377947390', '0TXiGm');
insert into Customer (cid, fname, mname, lname, email, number, password) values (65, 'Trent', null, 'Petrolli', 'mpetrolli1s@pen.io', '2042128397', 'YG5wakT');
insert into Customer (cid, fname, mname, lname, email, number, password) values (66, 'Nicolle', 'Saxe', 'Loynes', 'sloynes1t@mtv.com', '7566892711', 'HkLRBYcRmV');
insert into Customer (cid, fname, mname, lname, email, number, password) values (67, 'Zaccaria', null, 'Agott', 'magott1u@hp.com', '5441583798', 'EH2WDOl');
insert into Customer (cid, fname, mname, lname, email, number, password) values (68, 'Lodovico', null, 'McEnery', 'hmcenery1v@bravesites.com', '4269760106', 'b9NO49v');
insert into Customer (cid, fname, mname, lname, email, number, password) values (69, 'Atalanta', null, 'Beet', 'ebeet1w@tmall.com', '5361883941', 'YIzqya');
insert into Customer (cid, fname, mname, lname, email, number, password) values (70, 'Lyon', null, 'Meynell', 'rmeynell1x@bloglovin.com', '8941936152', 'h4AO1tKc7');
insert into Customer (cid, fname, mname, lname, email, number, password) values (71, 'Parker', 'Laurie', 'Allcott', 'lallcott1y@symantec.com', '4719101011', 'Qd1fdl');
insert into Customer (cid, fname, mname, lname, email, number, password) values (72, 'Lorena', 'Had', 'Stearn', 'hstearn1z@youtube.com', '4801542586', 'IteV0qvrZGv');
insert into Customer (cid, fname, mname, lname, email, number, password) values (73, 'Laurette', null, 'Bolderson', 'ebolderson20@odnoklassniki.ru', '5132643344', 'X5hzcIkh9');
insert into Customer (cid, fname, mname, lname, email, number, password) values (74, 'Kevina', 'Candice', 'Hurcombe', 'churcombe21@indiegogo.com', '3516193348', '4zhI7VO');
insert into Customer (cid, fname, mname, lname, email, number, password) values (75, 'Obed', null, 'Clemerson', 'dclemerson22@ustream.tv', '1016973220', 'nzVdWnPH');
insert into Customer (cid, fname, mname, lname, email, number, password) values (76, 'Eleni', null, 'Davion', 'fdavion23@thetimes.co.uk', '4209084726', 'ReK7jz0');
insert into Customer (cid, fname, mname, lname, email, number, password) values (77, 'Franciska', 'Elfreda', 'Abeau', 'eabeau24@vistaprint.com', '3531627416', 'TVKyjR6');
insert into Customer (cid, fname, mname, lname, email, number, password) values (78, 'Fiona', null, 'Bradborne', 'abradborne25@tripod.com', '2064234136', 'VHhQWX41i');
insert into Customer (cid, fname, mname, lname, email, number, password) values (79, 'Mordecai', null, 'Daber', 'sdaber26@seesaa.net', '1412299108', 'SkPUp9pIr');
insert into Customer (cid, fname, mname, lname, email, number, password) values (80, 'Dredi', null, 'Curdell', 'rcurdell27@jalbum.net', '3081221202', 'Uo3qzh2zuTO');
insert into Customer (cid, fname, mname, lname, email, number, password) values (81, 'Kimberlyn', 'Sandy', 'McElroy', 'smcelroy28@phpbb.com', '5117764558', 'y85PiDjTC8');
insert into Customer (cid, fname, mname, lname, email, number, password) values (82, 'Maddie', null, 'Bernuzzi', 'sbernuzzi29@reddit.com', '1368690155', 'aK6RLwSxC');
insert into Customer (cid, fname, mname, lname, email, number, password) values (83, 'Carine', 'Nikita', 'Worts', 'nworts2a@tinyurl.com', '9199745878', 'vo3NG47u1uE');
insert into Customer (cid, fname, mname, lname, email, number, password) values (84, 'Davina', null, 'Smith', 'msmith2b@edublogs.org', '5889215366', 'L8h9MN5k1');
insert into Customer (cid, fname, mname, lname, email, number, password) values (85, 'Murray', null, 'McGeever', 'dmcgeever2c@mozilla.org', '9824404529', '790HFJ');
insert into Customer (cid, fname, mname, lname, email, number, password) values (86, 'Ferdinand', null, 'Cunningham', 'ocunningham2d@unblog.fr', '7391301061', 'l8FwHkt0MF');
insert into Customer (cid, fname, mname, lname, email, number, password) values (87, 'Jamima', 'Noah', 'Rennie', 'nrennie2e@sina.com.cn', '7325332633', 'VQSHafxj');
insert into Customer (cid, fname, mname, lname, email, number, password) values (88, 'Eugen', 'Erik', 'Vynarde', 'evynarde2f@nydailynews.com', '1815848719', 'b20qWgoH');
insert into Customer (cid, fname, mname, lname, email, number, password) values (89, 'Rafaello', null, 'Pieterick', 'hpieterick2g@who.int', '9039427646', 'xQHAxcNFmkw');
insert into Customer (cid, fname, mname, lname, email, number, password) values (90, 'Eddie', null, 'Andersen', 'jandersen2h@delicious.com', '9202760042', '1z7HFoQCWTj');
insert into Customer (cid, fname, mname, lname, email, number, password) values (91, 'Sonny', null, 'Keiling', 'gkeiling2i@ucsd.edu', '1052360626', 'jwDzT8');
insert into Customer (cid, fname, mname, lname, email, number, password) values (92, 'Lesli', 'Siegfried', 'Duigan', 'sduigan2j@auda.org.au', '2976642853', '7xwRTAnExdb');
insert into Customer (cid, fname, mname, lname, email, number, password) values (93, 'Naoma', null, 'Harewood', 'dharewood2k@zdnet.com', '1054785651', 'pAJMeL');
insert into Customer (cid, fname, mname, lname, email, number, password) values (94, 'Neille', null, 'Pratley', 'hpratley2l@gov.uk', '4098873267', 'ydvWAdbPZ7');
insert into Customer (cid, fname, mname, lname, email, number, password) values (95, 'Jeramey', null, 'Schmuhl', 'mschmuhl2m@thetimes.co.uk', '8833677329', 'fTputbkIpJ');
insert into Customer (cid, fname, mname, lname, email, number, password) values (96, 'Hanni', null, 'Renols', 'drenols2n@illinois.edu', '6867557251', 'ZMTaBl7');
insert into Customer (cid, fname, mname, lname, email, number, password) values (97, 'Torrance', null, 'MacDearmaid', 'hmacdearmaid2o@qq.com', '7343237143', 'PABKoEpp0is');
insert into Customer (cid, fname, mname, lname, email, number, password) values (98, 'Wade', 'Claiborne', 'Defrain', 'cdefrain2p@marriott.com', '9926621672', 'Saaiby');
insert into Customer (cid, fname, mname, lname, email, number, password) values (99, 'Oriana', null, 'Biers', 'zbiers2q@ifeng.com', '3609415001', '6mOm0IC0yi');
insert into Customer (cid, fname, mname, lname, email, number, password) values (100, 'Dionisio', null, 'Yanshin', 'lyanshin2r@pinterest.com', '7076563625', 'yJtM0k');

-- Category-

insert into Category (catid, name) values (1, 'T-Shirts');
insert into Category (catid, name) values (2, 'Jeans');
insert into Category (catid, name) values (3, 'Shoes');
insert into Category (catid, name) values (4, 'Shirts');
insert into Category (catid, name) values (5, 'Pants');
insert into Category (catid, name) values (6, 'Jackets');
insert into Category (catid, name) values (7, 'Hoodies');
insert into Category (catid, name) values (8, 'Air purifiers');
insert into Category (catid, name) values (9, 'Yoga mats');
insert into Category (catid, name) values (10, 'Dumbbells');
insert into Category (catid, name) values (11, 'Smartphones');
insert into Category (catid, name) values (12, 'Tablets');
insert into Category (catid, name) values (13, 'TV');
insert into Category (catid, name) values (14, 'Refrigerator');
insert into Category (catid, name) values (15, 'Watches');
insert into Category (catid, name) values (16, 'Smart home devices');

-- Products:-
-- Tshirts
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (1, 1, 1, 1241, 'Hanes', 16, 5.0, '11/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (2, 1, 1, 1375, 'Fruit of the Loom', 22, 3.8, '05/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (3, 1, 3, 1494, 'Gildan', 10, 4.4, '20/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (4, 1, 4, 1500, 'American Apparel', 21, 2.1, '30/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (5, 1, 5, 1295, 'Nike', 28, 2.7, '11/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (6, 1, 6, 1444, 'Adidas', 22, 1.0, '01/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (7, 1, 7, 1243, 'Under Armour', 10, 2.9, '12/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (8, 1, 8, 1256, 'Puma', 30, 3.3, '19/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (9, 1, 9, 1217, 'Reebok', 26, 3.6, '03/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (10, 10, 10, 290, 'The North Face', 14, 1.7, '18/10/2022');
-- Jeans
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (11, 2, 1, 1041, "Levi's", 17, 2.6, '02/02/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (12, 2, 12, 846, "Wrangler", 16, 3.6, '25/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (13, 2, 13, 1238, "Calvin Klein", 92, 3.6, '01/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (14, 2, 14, 1073, "Tommy Hilfiger", 56, 2.1, '23/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (15, 2, 15, 1466, "Lee", 20, 3.8, '11/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (16, 2, 16, 1051, "Lucky Brand", 87, 2.4, '04/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (17, 2, 17, 789, "AG Adriano Goldschmied", 99, 3.0, '09/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (18, 2, 18, 891, "Nudie Jeans", 76, 4.4, '18/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (19, 2, 19, 964, "Diesel", 98, 2.7, '27/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (20, 2, 20, 1447, "G-Star Raw", 70, 3.6, '09/08/2022');
-- Shoes
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (21, 3, 21, 8541, 'Nike', 55, 4.6, '16/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (22, 3, 22, 7517, 'Adidas', 47, 4.6, '16/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (23, 3, 23, 9670, 'Reebok', 71, 4.6, '25/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (24, 3, 24, 2766, 'Puma', 91, 2.6, '27/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (25, 3, 25, 2668, 'Under Armour', 30, 4.9, '15/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (26, 3, 26, 2036, 'Converse', 49, 3.5, '14/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (27, 3, 27, 5401, 'Vans', 91, 3.9, '12/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (28, 3, 28, 1314, 'New Balance', 23, 4.8, '19/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (29, 3, 29, 5368, 'Asics', 14, 2.8, '05/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (30, 3, 30, 3765, 'Brooks', 76, 4.7, '12/03/2022');
-- Shirts
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (31, 4, 31, 1991, "Uniqlo shirt", 92, 2.5, '22/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (32, 4, 32, 1512, "J.Crew shirt", 94, 4.5, '10/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (33, 4, 33, 1577, "Express shirt", 69, 3.7, '04/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (34, 4, 34, 1952, "Banana Republic shirt", 55, 4.2, '26/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (35, 4, 35, 1867, "American Eagle Outfitters shirt", 73, 2.9, '29/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (36, 4, 36, 1527, "G-Star Raw shirt", 89, 2.1, '18/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (37, 4, 37, 1143, "Levi's shirt", 10, 4.6, '26/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (38, 4, 38, 1493, "Tommy Hilfiger shirt", 52, 2.6, '01/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (39, 4, 39, 1792, "H&M shirt", 85, 3.6, '19/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (40, 4, 40, 1494, "Zara shirt", 13, 4.4, '26/09/2021');
-- Pants
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (41, 5, 41, 1886, "Levi's jeans", 14, 3.7, '15/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (42, 5, 42, 1877, "Wrangler jeans", 57, 4.7, '20/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (43, 5, 43, 1348, "Lee jeans", 45, 3.8, '28/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (44, 5, 44, 1893, "Calvin Klein jeans", 19, 2.9, '08/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (45, 5, 45, 1015, "Tommy Hilfiger jeans", 56, 2.6, '01/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (46, 5, 46, 1132, "Diesel jeans", 13, 4.0, '05/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (47, 5, 47, 905, "Lucky Brand jeans", 35, 4.6, '14/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (48, 5, 48, 1793, "Nudie Jeans jeans", 41, 2.5, '26/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (49, 5, 49, 1373, "AG Adriano Goldschmied jeans", 98, 4.7, '12/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (50, 5, 50, 1511, "7 For All Mankind jeans", 54, 3.8, '16/04/2022');
-- Jackets
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (51, 6, 51, 15127, "The North Face jacket", 31, 4.5, '29/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (52, 6, 52, 12096, "Patagonia jacket", 99, 3.5, '19/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (53, 6, 53, 10556, "Columbia jacket", 80, 2.5, '07/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (54, 6, 54, 3951, "Mountain Hardwear jacket", 81, 4.7, '14/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (55, 6, 55, 12762, "Marmot jacket", 63, 2.3, '24/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (56, 6, 56, 10356, "Black Diamond jacket", 58, 2.9, '01/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (57, 6, 57, 17874, "Arc'teryx jacket", 20, 4.2, '30/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (58, 6, 58, 7514, "Patagonia jacket", 17, 4.1, '01/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (59, 6, 59, 6083, "Mammut jacket", 86, 4.0, '20/08/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (60, 6, 60, 13345, "Columbia jacket", 36, 2.3, '14/10/2021');
-- Hoodies
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (61, 7, 61, 5364, 'Nike hoodie', 65, 3.0, '03/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (62, 7, 62, 5275, 'Adidas hoodie', 100, 5.0, '11/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (63, 7, 63, 4889, 'Under Armour hoodie', 29, 4.1, '08/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (64, 7, 64, 1233, 'Champion hoodie', 66, 4.0, '03/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (65, 7, 65, 4512, 'Patagonia hoodie', 92, 4.1, '18/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (66, 7, 66, 3774, 'The North Face hoodie', 21, 4.9, '29/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (67, 7, 67, 4841, 'Supreme hoodie', 54, 3.1, '02/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (68, 7, 68, 4856, 'BAPE hoodie', 76, 2.1, '16/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (69, 7, 69, 6945, 'Stussy hoodie', 76, 4.3, '05/02/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (70, 7, 70, 1885, 'Thrasher hoodie', 36, 3.2, '24/05/2022');
-- Air purifiers
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (71, 8, 71, 7307, 'Honeywell air purifier', 53, 3.9, '27/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (72, 8, 72, 2679, 'Dyson air purifier', 83, 2.1, '25/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (73, 8, 73, 4354, 'Blueair air purifier', 31, 2.7, '20/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (74, 8, 74, 6803, 'Coway air purifier', 89, 4.6, '28/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (75, 8, 75, 8815, 'Winix air purifier', 46, 3.7, '07/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (76, 8, 76, 9005, 'Molekule air purifier', 62, 3.0, '16/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (77, 8, 77, 3409, 'LG air purifier', 23, 3.5, '01/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (78, 8, 78, 1850, 'Philips air purifier', 22, 4.4, '22/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (79, 8, 79, 1796, 'Sharp air purifier', 89, 3.5, '08/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (80, 8, 80, 7058, 'Friedrich air purifier', 58, 2.7, '29/01/2023');
-- Yoga mats
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (81, 9, 81, 2396, 'Manduka yoga mat', 56, 2.2, '02/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (82, 9, 82, 8378, 'Liforme yoga mat', 57, 3.7, '18/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (83, 9, 83, 7652, 'Jade Harmony yoga mat', 48, 4.2, '14/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (84, 9, 84, 6741, 'Gaiam yoga mat', 72, 3.5, '14/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (85, 9, 85, 8381, 'YogiToes yoga mat', 19, 4.7, '20/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (86, 9, 86, 4705, 'Cork Yoga Mats yoga mat', 40, 2.5, '30/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (87, 9, 87, 5230, 'NamaStay yoga mat', 88, 2.4, '10/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (88, 9, 88, 9383, 'The Active Club yoga mat', 83, 3.0, '16/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (89, 9, 89, 7463, 'Hugger Mugger yoga mat', 88, 4.9, '29/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (90, 9, 90, 9754, 'Jade Fusion yoga mat', 81, 4.2, '29/09/2022');
-- Dumbbells
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (91, 10, 91, 5265, 'Bowflex dumbbell', 94, 4.9, '05/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (92, 10, 92, 9653, 'CAP Barbell dumbbell', 31, 4.0, '28/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (93, 10, 93, 8830, 'PowerBlock dumbbell', 78, 3.8, '15/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (94, 10, 94, 1545, 'Nike Training Club dumbbell', 84, 3.6, '10/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (95, 10, 95, 8809, 'Marcy dumbbell', 78, 3.3, '30/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (96, 10, 96, 5095, 'Yes4All dumbbell', 61, 4.7, '18/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (97, 10, 97, 8510, 'Bayou Fitness dumbbell', 100, 2.5, '07/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (98, 10, 98, 9325, 'Body Solid dumbbell', 74, 2.4, '14/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (99, 10, 99, 2904, 'ProForm dumbbell', 87, 4.4, '31/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (100, 10, 100, 5386, 'StairMaster dumbbell', 75, 2.4, '13/05/2022');
-- Smartphones
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (101, 11, 101, 93602, 'Iphone 14', 55, 4.8, '05/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (102, 11, 102, 83204, 'Samsung S3', 43, 5.0, '12/11/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (103, 11, 103, 23738, 'Huawei smartphone', 75, 2.7, '22/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (104, 11, 104, 51365, 'Xiaomi Z30', 30, 3.7, '20/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (105, 11, 105, 25833, 'Oppo A20', 22, 2.6, '13/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (106, 11, 106, 57941, 'Iphone 13', 89, 3.0, '18/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (107, 11, 107, 89168, 'LG Z4', 17, 3.2, '10/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (108, 11, 108, 61635, 'Nokia XR30', 77, 4.2, '16/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (109, 11, 109, 24576, 'Oneplus 14', 12, 3.9, '11/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (110, 11, 110, 20931, 'Google Pixel 16', 54, 3.1, '07/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (111, 11, 111, 62722, 'Vivo V99', 60, 3.7, '29/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (112, 11, 112, 44758, 'Realme RZ80', 59, 2.9, '16/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (113, 11, 113, 47552, 'Iphone 12', 16, 3.0, '26/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (114, 11, 114, 31294, 'ASUS A93', 80, 4.4, '09/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (115, 11, 115, 92727, 'Blackberry ', 34, 2.8, '19/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (116, 11, 116, 50436, 'HTC ZY34', 51, 2.3, '05/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (117, 11, 117, 19808, 'ZTE H52', 32, 2.4, '27/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (118, 11, 118, 96431, 'Lenovo LZ+ Pro', 46, 3.7, '06/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (119, 11, 119, 38554, 'Motorola M963', 41, 3.0, '31/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (120, 11, 120, 94408, 'Samsung SZ20+', 56, 4.2, '10/02/2022');
-- Tablets
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (121, 12, 121, 29988, 'Apple', 22, 4.1, '05/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (122, 12, 122, 61454, 'Samsung', 35, 4.3, '25/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (123, 12, 123, 74179, 'Amazon', 10, 3.3, '31/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (124, 12, 124, 9690, 'Huawei', 82, 4.6, '22/08/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (125, 12, 125, 65939, 'Lenovo', 12, 3.9, '07/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (126, 12, 126, 24377, 'Acer', 92, 4.9, '22/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (127, 12, 127, 99727, 'Microsoft', 24, 2.5, '22/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (128, 12, 128, 44589, 'ASUS', 45, 2.9, '24/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (129, 12, 129, 37131, 'LG', 41, 4.5, '01/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (130, 12, 110, 39709, 'Google', 93, 4.7, '19/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (131, 12, 131, 94723, 'HP', 66, 4.7, '11/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (132, 12, 132, 40270, 'Dell', 51, 3.0, '16/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (133, 12, 133, 68745, 'Archos', 32, 2.1, '30/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (134, 12, 134, 92732, 'Fire', 67, 2.7, '25/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (135, 12, 135, 46746, 'BlackBerry', 57, 4.7, '14/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (136, 12, 136, 93824, 'Sony', 25, 4.1, '28/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (137, 12, 137, 98442, 'Toshiba', 47, 3.3, '04/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (138, 12, 138, 58698, 'Fujitsu', 59, 4.8, '17/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (139, 12, 139, 85523, 'Polaroid', 11, 4.9, '22/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (140, 12, 140, 14910, 'Alcatel', 10, 3.2, '03/01/2023');
-- TV
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (141, 13, 141, 7505, 'Samsung', 67, 3.0, '19/12/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (142, 13, 142, 20848, 'LG', 15, 2.2, '09/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (143, 13, 143, 79491, 'Sony', 55, 3.8, '12/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (144, 13, 144, 25213, 'Vizio', 79, 3.7, '10/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (145, 13, 145, 81934, 'TCL', 51, 3.2, '27/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (146, 13, 146, 19964, 'Hisense', 72, 3.8, '03/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (147, 13, 78, 49557, 'Philips', 38, 4.6, '03/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (148, 13, 148, 63568, 'Panasonic', 39, 2.4, '01/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (149, 13, 149, 45833, 'Sharp', 45, 3.9, '31/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (150, 13, 150, 87928, 'Toshiba', 22, 3.6, '01/04/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (151, 13, 151, 68839, 'Insignia', 71, 3.1, '09/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (152, 13, 152, 38903, 'Element', 52, 4.4, '27/08/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (153, 13, 153, 58042, 'Sceptre', 33, 3.9, '03/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (154, 13, 154, 58250, 'RCA', 16, 2.3, '09/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (155, 13, 155, 29604, 'Onn', 77, 2.2, '28/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (156, 13, 156, 97559, 'Westinghouse', 67, 3.5, '05/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (157, 13, 157, 22121, 'JVC', 75, 3.7, '28/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (158, 13, 158, 43608, 'Skyworth', 47, 2.4, '21/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (159, 13, 159, 31349, 'Mitsubishi', 61, 3.6, '04/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (160, 13, 160, 46308, 'Hitachi', 75, 2.3, '26/09/2021');
-- Refrigerators
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (161, 14, 161, 54472, 'Samsung ref63', 57, 4.4, '07/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (162, 14, 162, 80921, 'LG ref23', 51, 2.3, '18/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (163, 14, 163, 96172, 'Whirlpool W34', 60, 2.1, '19/02/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (164, 14, 164, 76524, 'GE T6', 89, 4.2, '21/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (165, 14, 165, 29481, 'Frigidaire fr98', 48, 3.5, '23/03/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (166, 14, 166, 65493, 'Bosch rt8', 19, 5.0, '06/11/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (167, 14, 167, 43823, 'Kenmore p98', 66, 3.3, '03/01/2023');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (168, 14, 168, 36846, 'KitchenAid Sonix', 12, 2.9, '11/06/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (169, 14, 169, 84572, 'Maytag FRE3', 18, 4.6, '08/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (170, 14, 170, 45277, 'Amana fri13', 46, 3.2, '29/07/2022');
-- Watches
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (171, 15, 171, 7475, 'Apple', 30, 3.2, '04/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (172, 15, 172, 77302, 'Samsung', 70, 4.7, '21/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (173, 15, 173, 94628, 'Fitbit', 60, 3.4, '19/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (174, 15, 174, 70621, 'Garmin', 35, 3.0, '15/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (175, 15, 175, 25279, 'Huawei', 65, 3.6, '23/07/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (176, 15, 176, 51360, 'Xiaomi', 93, 3.9, '28/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (177, 15, 177, 70077, 'Fossil', 71, 3.7, '25/08/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (178, 15, 178, 13413, 'Amazfit', 47, 4.5, '13/01/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (179, 15, 179, 68170, 'Ticwatch', 19, 3.5, '01/09/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (180, 15, 180, 49287, 'Polar', 18, 4.5, '12/12/2021');
-- Smart home devices
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (181, 16, 123, 4494, 'Alexa', 23, 5.0, '01/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (182, 16, 110, 6592, 'Google Home', 62, 4.8, '10/09/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (183, 16, 183, 6995, 'TP-Link smart plug', 23, 2.5, '22/08/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (184, 16, 184, 2981, 'Nest Protect smoke detector', 60, 2.0, '26/12/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (185, 16, 185, 5437, 'Kwikset', 29, 2.9, '17/10/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (186, 16, 186, 3160, 'Ring', 46, 3.2, '16/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (187, 16, 187, 3851, 'First Alert smoke detector', 67, 4.3, '29/10/2021');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (188, 16, 188, 8579, 'Shark IQ Vacuum', 24, 4.8, '16/05/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (189, 16, 78, 6547, 'Philips Hue smart lighting', 91, 2.8, '01/11/2022');
insert into Product (pid, catid, rid, price, name, quantity, rating, manufacturingdate) values (190, 16, 190, 4326, 'Havells smart fans', 21, 3.1, '17/03/2022');


-- Address
insert into Address (aid, cid, locality, pincode, city, state) values (1, 91, '33229 Morning Court',  '642325', 'Al Azīzīyah', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (2, 21, '04 Morrow Pass', '68164', 'Omaha', 'Nebraska');
insert into Address (aid, cid, locality, pincode, city, state) values (3, 71, '2 Ronald Regan Junction',  '642329', 'Chernelytsya', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (4, 93, '62123 Manley Crossing',  '647899', 'Danxia', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (5, 18, '6 Larry Plaza', '6090-511', 'Penamacor', 'Castelo Branco');
insert into Address (aid, cid, locality, pincode, city, state) values (6, 57, '7 Holy Cross Point', '36180', 'Khon San', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (7, 89, '030 Bay Point', '431 51', 'Klášterec nad Ohří', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (8, 22, '7 Kings Plaza', '188961', 'Borodinskiy', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (9, 28, '162 Florence Plaza',  '648898', 'Baumata', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (10, 55, '869 Arkansas Road', '5034', 'Janiuay', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (11, 66, '87 Shelley Lane',  '898979', 'Poncokusumo', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (12, 67, '6479 Barnett Trail',  '6478', 'Xiaocun', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (13, 81, '3 Lindbergh Crossing',  '64780', 'Balungkopi', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (14, 35, '82 Canary Road',  '647800', 'Kabo', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (15, 37, '8 Southridge Plaza', '83-210', 'Zblewo', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (16, 19, '36 Tennyson Junction',  '947800', 'Lukovë', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (17, 25, '36504 Alpine Parkway', '96684', 'Pemex', 'Veracruz Llave');
insert into Address (aid, cid, locality, pincode, city, state) values (18, 53, '93 Memorial Road', '5400-715', 'Outeiro Seco', 'Vila Real');
insert into Address (aid, cid, locality, pincode, city, state) values (19, 50, '7158 School Pass', '57900-000', 'Porto Calvo', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (20, 21, '5331 Heffernan Terrace',  '947800', 'Ebute Ikorodu', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (21, 58, '31 Springs Crossing',  '947560', 'Longxian', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (22, 83, '9 Charing Cross Lane',  '564800', 'Qāen', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (23, 52, '5 Ruskin Crossing',  '947800', 'Nangkapayung', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (24, 1, '69 Norway Maple Alley', 'M9L', 'Lunenburg', 'Nova Scotia');
insert into Address (aid, cid, locality, pincode, city, state) values (25, 83, '419 Magdeline Circle', '75171 CEDEX 19', 'Paris 19', 'Île-de-France');
insert into Address (aid, cid, locality, pincode, city, state) values (26, 87, '26687 Vera Trail',  '345425', 'Setro', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (27, 70, '7800 Bartillon Center', '18290-000', 'Buri', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (28, 71, '9 Maryland Park', '430901', 'Zykovo', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (29, 16, '2 Granby Avenue', '4600', 'San Salvador de Jujuy', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (30, 97, '8038 Bunting Alley', '89166', 'Las Vegas', 'Nevada');
insert into Address (aid, cid, locality, pincode, city, state) values (31, 49, '617 Fair Oaks Pass',  '342425', 'Xinghe Chengguanzhen', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (32, 60, '46202 Haas Road', '55123', 'Saint Paul', 'Minnesota');
insert into Address (aid, cid, locality, pincode, city, state) values (33, 6, '685 Annamark Circle', '21002', 'San Pedro Pinula', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (34, 15, '7 Sage Junction', '491-0817', 'Kōnan', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (35, 66, '04 Northridge Hill',  '323525', 'Shihuang', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (36, 78, '58 Eastwood Avenue',  '35425', 'Saurama', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (37, 86, '02007 Holmberg Plaza',  '768825', 'Benjamín Aceval', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (38, 76, '71224 Cody Parkway', '989-2474', 'Asahi', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (39, 15, '54190 Longview Alley',  '367525', 'Hechuan', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (40, 57, '5617 Steensland Hill', '4406', 'Cabusao', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (41, 69, '8783 Arkansas Street', '9500', 'Buayan', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (42, 70, '7264 Melvin Court', '97-217', 'Lubochnia', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (43, 14, '596 Fair Oaks Park',  '36875', 'Ambatolaona', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (44, 10, '709 Bartelt Parkway',  '346725', 'Liqiao', 'MP');
insert into Address (aid, cid, locality, pincode, city, state) values (45, 92, '129 Maple Terrace',  '367525', 'Zuru', 'MP');
insert into Address (aid, cid, locality, pincode, city, state) values (46, 51, '7 Starling Crossing', '6214', 'Guihulñgan', 'MP');
insert into Address (aid, cid, locality, pincode, city, state) values (47, 31, '57852 Fordem Plaza',  '342979', 'Haymā', 'MP');
insert into Address (aid, cid, locality, pincode, city, state) values (48, 73, '9 Hazelcrest Junction', '34643', 'Largo', 'Florida');
insert into Address (aid, cid, locality, pincode, city, state) values (49, 84, '037 Badeau Parkway',  '345652', 'Jingyang', 'MP');
insert into Address (aid, cid, locality, pincode, city, state) values (50, 27, '375 Crowley Circle',  '455525', 'Botou', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (51, 63, '2074 Pearson Park', 'MD-3652', 'Ungheni', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (52, 56, '70 Harbort Parkway',  '55525', 'Broto', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (53, 71, '9 Mariners Cove Way',  '355425', 'Uhniv', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (54, 60, '77057 Trailsway Road',  '344475', 'Qujiang', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (55, 10, '24317 Tony Center', '484320', 'Skoroszyce', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (56, 60, '01 Debra Alley',  '344775', 'Krajan', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (57, 5, '4415 Fallview Court', '457457', 'Victoria', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (58, 44, '5968 Fisk Court', '371914', 'Columbus', 'Georgia');
insert into Address (aid, cid, locality, pincode, city, state) values (59, 44, '5 Sloan Trail', '475019', 'Souto', 'Braga');
insert into Address (aid, cid, locality, pincode, city, state) values (60, 34, '54 Stoughton Way', '577007', 'Bergen', 'Hordaland');
insert into Address (aid, cid, locality, pincode, city, state) values (61, 72, '770 Bay Lane',  '342785', 'Combapata', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (62, 33, '1 David Trail', '6509', 'Nijmegen', 'Provincie Gelderland');
insert into Address (aid, cid, locality, pincode, city, state) values (63, 2, '042 Old Shore Circle',  '342795', 'Jiangqiao', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (64, 15, '360 School Drive',  '347885', 'Yangiyŭl', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (65, 84, '559 Moland Road', '253560', 'Helsingborg', 'Skåne');
insert into Address (aid, cid, locality, pincode, city, state) values (66, 84, '78 Anniversary Place', '171658', 'Novokuzminki', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (67, 91, '20 Bultman Avenue', '402625', 'Göteborg', 'Västra Götaland');
insert into Address (aid, cid, locality, pincode, city, state) values (68, 54, '93 Linden Drive', '119605', 'San Pedro', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (69, 4, '9805 Quincy Center',  '342565', 'Baun', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (70, 2, '09 Ronald Regan Point', '5292', 'Levski', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (71, 68, '255 Riverside Junction', '24181', 'Amangarh', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (72, 21, '24 Farmco Junction',  '342565', 'Shimen', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (73, 41, '4180 La Follette Drive', '7920-015', 'Alvito', 'Beja');
insert into Address (aid, cid, locality, pincode, city, state) values (74, 78, '00 Westridge Hill',  '345525', 'Yangjiafang', 'Goa');
insert into Address (aid, cid, locality, pincode, city, state) values (75, 16, '7 Almo Park',  '358525', 'Sirte', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (76, 40, '6450 Brickson Park Junction',  '343125', 'Huangshapu', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (77, 29, '25358 Veith Crossing', '32941', 'Melbourne', 'Florida');
insert into Address (aid, cid, locality, pincode, city, state) values (78, 7, '99 Rockefeller Junction',  '343455', 'Duanjia', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (79, 13, '46 Bobwhite Park',  '345543', 'Cibolek Kidul', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (80, 72, '95 Commercial Alley',  '312325', 'Besisahar', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (81, 51, '19 Riverside Hill',  '3422555', 'Ampelókipoi', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (82, 86, '080 Riverside Lane',  '343455', 'Mboursou Léré', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (83, 70, '50 Porter Pass',  '342455', 'Yelyzavethradka', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (84, 9, '1129 Marcy Alley',  '342625', 'Pedraza La Vieja', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (85, 89, '62 East Place',  '341893', 'Samsan', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (86, 47, '53928 Grover Trail', '4500', 'San Pedro', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (87, 59, '22 Mitchell Lane',  '232525', 'Fatufaun', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (88, 3, '79701 2nd Street',  '366425', 'Smach Mean Chey', 'MAHARASHTRA');
insert into Address (aid, cid, locality, pincode, city, state) values (89, 2, '626 Magdeline Plaza',  '323325', 'Douz', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (90, 73, '45508 Hermina Crossing',  '325525', 'Zekou', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (91, 94, '51 Crownhardt Alley',  '323525', 'Krasnyy Lyman', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (92, 32, '28 Golf View Pass', '9406', 'Marbel', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (93, 55, '96047 Main Pass',  '323525', 'Thị Trấn Mường Lát', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (94, 80, '9 Reindahl Center',  '332555', 'Watubura', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (95, 18, '4587 Amoth Pass',  '323525', 'Xianghuaqiao', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (96, 38, '318 Springs Junction',  '32525', 'Ellinikó', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (97, 99, '9 Upham Lane', '5420', 'Bail', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (98, 83, '7503 Farmco Avenue', '27509 CEDEX', 'Pont-Audemer', 'Haute-Normandie');
insert into Address (aid, cid, locality, pincode, city, state) values (99, 13, '3 Graedel Way',  '325525', 'Zongzhai', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (100, 49, '56 Morrow Parkway', '6501', 'Pawing', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (101, 97, '47012 5th Circle', '870106', 'Tsurusaki', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (102, 13, '28572 Eastlawn Place',  '328335', 'Ronggo', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (103, 88, '1954 Anderson Plaza',  '232525', 'Krebet', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (104, 82, '1295 Armistice Road',  '344625', 'Minian', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (105, 88, '9781 East Street', '5504', 'Surup', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (106, 29, '19150 Fair Oaks Plaza', '830-0114', 'Fukumitsu', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (107, 85, '3300 Crest Line Center',  '342525', 'Mamboma', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (108, 97, '0 Sommers Crossing',  '326525', 'Qinghaihu', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (109, 81, '2557 Huxley Way',  '346665', 'Ciparakan', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (110, 19, '16870 Ridge Oak Crossing', '95-047', 'Jeżów', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (111, 49, '56938 Badeau Alley', '812-0045', 'Hachinohe', 'FLORIDA');
insert into Address (aid, cid, locality, pincode, city, state) values (112, 60, '255 Corscot Avenue',  '325525', 'Jincheng', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (113, 62, '253 Mallory Parkway',  '345255', 'Khashuri', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (114, 81, '65 Brentwood Court', '55530-000', 'Gameleira', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (115, 93, '6885 Rigney Place',  '366525', 'Zafar', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (116, 14, '422 Vidon Park',  '333325', 'Laguna de Perlas', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (117, 69, '2 Rockefeller Trail',  '245525', 'Mlalo', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (118, 77, '2 Talisman Plaza', '86180-000', 'Cambé', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (119, 87, '7132 Arizona Junction',  '942525', 'Encañada', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (120, 14, '66570 Ludington Way', '5002', 'Santa Barbara', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (121, 80, '4963 High Crossing Parkway',  '949525', 'Qiting', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (122, 6, '78040 Milwaukee Place', '105 32', 'Stockholm', 'Stockholm');
insert into Address (aid, cid, locality, pincode, city, state) values (123, 86, '642 Grover Way', '77800-000', 'Araguaína', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (124, 57, '617 Ronald Regan Drive', '671820', 'Naushki', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (125, 89, '452 Roxbury Parkway', '14074 CEDEX 5', 'Caen', 'Basse-Normandie');
insert into Address (aid, cid, locality, pincode, city, state) values (126, 97, '04 Meadow Valley Lane',  '343636', 'Banepa', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (127, 63, '6383 Springview Circle', '188668', 'Leskolovo', 'Ile-Franscisco');
insert into Address (aid, cid, locality, pincode, city, state) values (128, 79, '0 Montana Hill', '235555', 'Sarimukti Kaler', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (129, 100, '51255 Gale Avenue',  '236825', 'Wanying', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (130, 21, '06282 Gina Pass',  '342599', 'Karajeun', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (131, 80, '381 Blue Bill Park Street', '95874 CEDEX', 'Bezons', 'Île-de-France');
insert into Address (aid, cid, locality, pincode, city, state) values (132, 74, '2 Lawn Avenue', '865600', 'Yambol', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (133, 92, '55666 Eastlawn Road',  '342535', 'Sindangrasa', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (134, 80, '89075 Rowland Crossing',  '345825', 'Qobustan', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (135, 41, '5662 Transport Street', '15705', 'Santiago De Compostela', 'Galicia');
insert into Address (aid, cid, locality, pincode, city, state) values (136, 28, '858 Goodland Plaza',  '338825', 'Maoer', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (137, 81, '6923 Upham Park', '110267', 'Calaoagan', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (138, 98, '432 Pierstorff Pass',  '33325', 'Wenchang', 'DELHI');
insert into Address (aid, cid, locality, pincode, city, state) values (139, 79, '38717 Westend Drive', '352189', 'Otrado-Kubanskoye', 'UP');
insert into Address (aid, cid, locality, pincode, city, state) values (140, 62, '40345 Muir Avenue', '813866', 'Río Colorado', 'UP');

-- Admin
insert into Admin (fname, email, password) values ('Peter', 'psudy0@over-blog.com', '9fc2r9P');

-- Payment

insert into Payment (modeofpayment, aid) values ('NEFT', 52);
insert into Payment (modeofpayment, aid) values ('COD', 23);
insert into Payment (modeofpayment, aid) values ('NEFT', 60);
insert into Payment (modeofpayment, aid) values ('NEFT', 43);
insert into Payment (modeofpayment, aid) values ('NEFT', 90);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 26);
insert into Payment (modeofpayment, aid) values ('NEFT', 19);
insert into Payment (modeofpayment, aid) values ('NEFT', 25);
insert into Payment (modeofpayment, aid) values ('COD', 10);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 22);
insert into Payment (modeofpayment, aid) values ('COD', 4);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 2);
insert into Payment (modeofpayment, aid) values ('NEFT', 53);
insert into Payment (modeofpayment, aid) values ('COD', 86);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 76);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 38);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 78);
insert into Payment (modeofpayment, aid) values ('COD', 94);
insert into Payment (modeofpayment, aid) values ('COD', 74);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 19);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 61);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 97);
insert into Payment (modeofpayment, aid) values ('NEFT', 79);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 34);
insert into Payment (modeofpayment, aid) values ('NEFT', 55);
insert into Payment (modeofpayment, aid) values ('COD', 48);
insert into Payment (modeofpayment, aid) values ('NEFT', 45);
insert into Payment (modeofpayment, aid) values ('NEFT', 36);
insert into Payment (modeofpayment, aid) values ('COD', 66);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 90);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 49);
insert into Payment (modeofpayment, aid) values ('COD', 65);
insert into Payment (modeofpayment, aid) values ('NEFT', 66);
insert into Payment (modeofpayment, aid) values ('COD', 5);
insert into Payment (modeofpayment, aid) values ('COD', 77);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 69);
insert into Payment (modeofpayment, aid) values ('COD', 72);
insert into Payment (modeofpayment, aid) values ('COD', 57);
insert into Payment (modeofpayment, aid) values ('COD', 17);
insert into Payment (modeofpayment, aid) values ('NEFT', 22);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 76);
insert into Payment (modeofpayment, aid) values ('NEFT', 77);
insert into Payment (modeofpayment, aid) values ('COD', 78);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 57);
insert into Payment (modeofpayment, aid) values ('NEFT', 29);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 45);
insert into Payment (modeofpayment, aid) values ('COD', 25);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 30);
insert into Payment (modeofpayment, aid) values ('COD', 6);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 77);
insert into Payment (modeofpayment, aid) values ('NEFT', 78);
insert into Payment (modeofpayment, aid) values ('NEFT', 78);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 84);
insert into Payment (modeofpayment, aid) values ('COD', 85);
insert into Payment (modeofpayment, aid) values ('COD', 7);
insert into Payment (modeofpayment, aid) values ('NEFT', 36);
insert into Payment (modeofpayment, aid) values ('NEFT', 73);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 41);
insert into Payment (modeofpayment, aid) values ('COD', 51);
insert into Payment (modeofpayment, aid) values ('NEFT', 52);
insert into Payment (modeofpayment, aid) values ('COD', 60);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 63);
insert into Payment (modeofpayment, aid) values ('COD', 29);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 92);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 20);
insert into Payment (modeofpayment, aid) values ('NEFT', 6);
insert into Payment (modeofpayment, aid) values ('COD', 76);
insert into Payment (modeofpayment, aid) values ('NEFT', 100);
insert into Payment (modeofpayment, aid) values ('NEFT', 29);
insert into Payment (modeofpayment, aid) values ('NEFT', 51);
insert into Payment (modeofpayment, aid) values ('NEFT', 59);
insert into Payment (modeofpayment, aid) values ('COD', 48);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 43);
insert into Payment (modeofpayment, aid) values ('NEFT', 37);
insert into Payment (modeofpayment, aid) values ('NEFT', 76);
insert into Payment (modeofpayment, aid) values ('COD', 50);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 5);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 52);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 73);
insert into Payment (modeofpayment, aid) values ('COD', 44);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 29);
insert into Payment (modeofpayment, aid) values ('COD', 80);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 3);
insert into Payment (modeofpayment, aid) values ('NEFT', 76);
insert into Payment (modeofpayment, aid) values ('COD', 1);
insert into Payment (modeofpayment, aid) values ('COD', 49);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 100);
insert into Payment (modeofpayment, aid) values ('COD', 19);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 11);
insert into Payment (modeofpayment, aid) values ('NEFT', 73);
insert into Payment (modeofpayment, aid) values ('NEFT', 42);
insert into Payment (modeofpayment, aid) values ('NEFT', 3);
insert into Payment (modeofpayment, aid) values ('NEFT', 73);
insert into Payment (modeofpayment, aid) values ('COD', 5);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 80);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 79);
insert into Payment (modeofpayment, aid) values ('NEFT', 25);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 8);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 44);
insert into Payment (modeofpayment, aid) values ('COD', 29);
insert into Payment (modeofpayment, aid) values ('COD', 85);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 30);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 70);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 84);
insert into Payment (modeofpayment, aid) values ('COD', 9);
insert into Payment (modeofpayment, aid) values ('NEFT', 44);
insert into Payment (modeofpayment, aid) values ('COD', 65);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 85);
insert into Payment (modeofpayment, aid) values ('NETBANKING', 42);
insert into Payment (modeofpayment, aid) values ('NEFT', 49);

-- deliveryboy

insert into deliveryboy (name, age, rating) values ('Lissy', 50, 3.6);
insert into deliveryboy (name, age, rating) values ('Keri', 65, 3.8);
insert into deliveryboy (name, age, rating) values ('Alisha', 37, 2.4);
insert into deliveryboy (name, age, rating) values ('Norene', 38, 2.4);
insert into deliveryboy (name, age, rating) values ('Edithe', 45, 4.6);
insert into deliveryboy (name, age, rating) values ('Evvie', 65, 4.9);
insert into deliveryboy (name, age, rating) values ('Elton', 64, 2.6);
insert into deliveryboy (name, age, rating) values ('Natalie', 69, 4.4);
insert into deliveryboy (name, age, rating) values ('Marylynne', 63, 2.1);
insert into deliveryboy (name, age, rating) values ('Dorian', 27, 4.2);
insert into deliveryboy (name, age, rating) values ('Halette', 43, 2.8);
insert into deliveryboy (name, age, rating) values ('Burton', 44, 2.3);
insert into deliveryboy (name, age, rating) values ('Melloney', 40, 3.6);
insert into deliveryboy (name, age, rating) values ('Catherine', 28, 3.1);
insert into deliveryboy (name, age, rating) values ('Leigh', 32, 2.8);
insert into deliveryboy (name, age, rating) values ('Britte', 28, 4.2);
insert into deliveryboy (name, age, rating) values ('Julietta', 65, 4.0);
insert into deliveryboy (name, age, rating) values ('Ruby', 54, 4.3);
insert into deliveryboy (name, age, rating) values ('Christy', 41, 4.1);
insert into deliveryboy (name, age, rating) values ('Calida', 24, 3.3);
insert into deliveryboy (name, age, rating) values ('Ximenez', 61, 3.0);
insert into deliveryboy (name, age, rating) values ('Arly', 58, 3.2);
insert into deliveryboy (name, age, rating) values ('Agnola', 35, 3.5);
insert into deliveryboy (name, age, rating) values ('Ulrick', 30, 3.4);
insert into deliveryboy (name, age, rating) values ('Nanine', 32, 4.8);
insert into deliveryboy (name, age, rating) values ('Loria', 69, 4.0);
insert into deliveryboy (name, age, rating) values ('Margit', 63, 3.4);
insert into deliveryboy (name, age, rating) values ('Debee', 55, 5.0);
insert into deliveryboy (name, age, rating) values ('Orion', 54, 2.6);
insert into deliveryboy (name, age, rating) values ('Quinta', 34, 3.8);
insert into deliveryboy (name, age, rating) values ('Shaylyn', 50, 3.6);
insert into deliveryboy (name, age, rating) values ('Braden', 50, 4.0);
insert into deliveryboy (name, age, rating) values ('Berni', 62, 3.7);
insert into deliveryboy (name, age, rating) values ('Meggi', 56, 5.0);
insert into deliveryboy (name, age, rating) values ('Gweneth', 27, 4.0);
insert into deliveryboy (name, age, rating) values ('Holly-anne', 24, 2.1);
insert into deliveryboy (name, age, rating) values ('Seth', 33, 4.8);
insert into deliveryboy (name, age, rating) values ('Shana', 21, 4.6);
insert into deliveryboy (name, age, rating) values ('Javier', 59, 3.4);
insert into deliveryboy (name, age, rating) values ('Aaren', 56, 3.9);
insert into deliveryboy (name, age, rating) values ('Berget', 29, 4.2);
insert into deliveryboy (name, age, rating) values ('Wallie', 35, 3.1);
insert into deliveryboy (name, age, rating) values ('Meridel', 31, 3.1);
insert into deliveryboy (name, age, rating) values ('Selig', 34, 3.8);
insert into deliveryboy (name, age, rating) values ('Sidnee', 19, 3.2);
insert into deliveryboy (name, age, rating) values ('Tobey', 66, 4.2);
insert into deliveryboy (name, age, rating) values ('Walker', 62, 3.6);
insert into deliveryboy (name, age, rating) values ('Ynes', 20, 2.6);
insert into deliveryboy (name, age, rating) values ('Regen', 48, 2.8);
insert into deliveryboy (name, age, rating) values ('Fenelia', 60, 2.6);
insert into deliveryboy (name, age, rating) values ('Trisha', 66, 3.8);
insert into deliveryboy (name, age, rating) values ('Florian', 49, 4.8);
insert into deliveryboy (name, age, rating) values ('Kessia', 24, 4.7);
insert into deliveryboy (name, age, rating) values ('Aileen', 35, 2.1);
insert into deliveryboy (name, age, rating) values ('Tildi', 46, 3.8);
insert into deliveryboy (name, age, rating) values ('Harold', 27, 4.3);
insert into deliveryboy (name, age, rating) values ('Brena', 69, 4.4);
insert into deliveryboy (name, age, rating) values ('Erika', 18, 4.4);
insert into deliveryboy (name, age, rating) values ('Devlen', 22, 2.6);
insert into deliveryboy (name, age, rating) values ('Hakim', 34, 3.1);
insert into deliveryboy (name, age, rating) values ('Avram', 29, 4.0);
insert into deliveryboy (name, age, rating) values ('Jone', 49, 3.4);
insert into deliveryboy (name, age, rating) values ('Freida', 56, 3.7);
insert into deliveryboy (name, age, rating) values ('Marshal', 66, 3.6);
insert into deliveryboy (name, age, rating) values ('Francoise', 50, 5.0);
insert into deliveryboy (name, age, rating) values ('Burg', 36, 2.9);
insert into deliveryboy (name, age, rating) values ('Wadsworth', 22, 2.2);
insert into deliveryboy (name, age, rating) values ('Katinka', 32, 3.5);
insert into deliveryboy (name, age, rating) values ('Glyn', 18, 4.5);
insert into deliveryboy (name, age, rating) values ('Brew', 50, 2.7);
insert into deliveryboy (name, age, rating) values ('Richmound', 39, 2.1);
insert into deliveryboy (name, age, rating) values ('Ashia', 63, 3.3);
insert into deliveryboy (name, age, rating) values ('Edmund', 46, 4.9);
insert into deliveryboy (name, age, rating) values ('Wernher', 29, 4.7);
insert into deliveryboy (name, age, rating) values ('Bridie', 38, 3.4);
insert into deliveryboy (name, age, rating) values ('Fredericka', 30, 2.2);
insert into deliveryboy (name, age, rating) values ('Maxy', 69, 4.9);
insert into deliveryboy (name, age, rating) values ('Kania', 58, 4.7);
insert into deliveryboy (name, age, rating) values ('Mabelle', 69, 2.9);
insert into deliveryboy (name, age, rating) values ('Burty', 64, 3.7);
insert into deliveryboy (name, age, rating) values ('Ardra', 25, 3.7);
insert into deliveryboy (name, age, rating) values ('Francisco', 26, 3.9);
insert into deliveryboy (name, age, rating) values ('Dido', 29, 4.8);
insert into deliveryboy (name, age, rating) values ('Gardener', 60, 3.5);
insert into deliveryboy (name, age, rating) values ('Normy', 40, 2.5);
insert into deliveryboy (name, age, rating) values ('Rudolfo', 50, 3.5);
insert into deliveryboy (name, age, rating) values ('Crosby', 45, 2.4);
insert into deliveryboy (name, age, rating) values ('Hakim', 63, 2.5);
insert into deliveryboy (name, age, rating) values ('Mikey', 57, 3.6);
insert into deliveryboy (name, age, rating) values ('Malachi', 62, 4.1);
insert into deliveryboy (name, age, rating) values ('Miguela', 33, 2.2);
insert into deliveryboy (name, age, rating) values ('Kirsten', 31, 4.7);
insert into deliveryboy (name, age, rating) values ('Lucita', 32, 2.1);
insert into deliveryboy (name, age, rating) values ('Kennan', 54, 2.5);
insert into deliveryboy (name, age, rating) values ('Shaylynn', 31, 3.2);
insert into deliveryboy (name, age, rating) values ('Rosemary', 51, 4.4);
insert into deliveryboy (name, age, rating) values ('Alfy', 38, 2.9);
insert into deliveryboy (name, age, rating) values ('Gil', 64, 2.1);
insert into deliveryboy (name, age, rating) values ('Flory', 26, 5.0);
insert into deliveryboy (name, age, rating) values ('Josi', 48, 2.9);
insert into deliveryboy (name, age, rating) values ('Averill', 27, 3.0);
insert into deliveryboy (name, age, rating) values ('Noak', 40, 2.8);
insert into deliveryboy (name, age, rating) values ('Hailey', 19, 2.4);
insert into deliveryboy (name, age, rating) values ('Gaby', 40, 4.7);
insert into deliveryboy (name, age, rating) values ('Kasper', 22, 2.4);
insert into deliveryboy (name, age, rating) values ('Caz', 25, 4.3);
insert into deliveryboy (name, age, rating) values ('Kendell', 70, 4.1);
insert into deliveryboy (name, age, rating) values ('Ario', 20, 2.3);
insert into deliveryboy (name, age, rating) values ('Nicola', 36, 4.4);
insert into deliveryboy (name, age, rating) values ('Gnni', 30, 3.9);
insert into deliveryboy (name, age, rating) values ('Jasmin', 36, 2.4);
insert into deliveryboy (name, age, rating) values ('Donovan', 43, 3.0);
insert into deliveryboy (name, age, rating) values ('Prudence', 51, 2.0);
insert into deliveryboy (name, age, rating) values ('Addie', 31, 4.6);
insert into deliveryboy (name, age, rating) values ('Matthew', 47, 4.4);
insert into deliveryboy (name, age, rating) values ('Blinni', 57, 2.9);
insert into deliveryboy (name, age, rating) values ('Tam', 49, 2.9);
insert into deliveryboy (name, age, rating) values ('Ruy', 22, 2.5);
insert into deliveryboy (name, age, rating) values ('Dodie', 62, 4.6);
insert into deliveryboy (name, age, rating) values ('Delphinia', 68, 2.9);
insert into deliveryboy (name, age, rating) values ('Siward', 28, 3.1);
insert into deliveryboy (name, age, rating) values ('Bridie', 28, 3.6);
insert into deliveryboy (name, age, rating) values ('Andy', 70, 2.7);
insert into deliveryboy (name, age, rating) values ('Myron', 37, 3.5);
insert into deliveryboy (name, age, rating) values ('Judah', 55, 2.2);
insert into deliveryboy (name, age, rating) values ('Ulick', 38, 3.8);
insert into deliveryboy (name, age, rating) values ('Amalie', 68, 4.8);
insert into deliveryboy (name, age, rating) values ('Colline', 46, 4.5);
insert into deliveryboy (name, age, rating) values ('Fabe', 39, 3.9);
insert into deliveryboy (name, age, rating) values ('Sherie', 56, 2.6);
insert into deliveryboy (name, age, rating) values ('Codie', 69, 3.0);
insert into deliveryboy (name, age, rating) values ('Heda', 20, 3.3);
insert into deliveryboy (name, age, rating) values ('Farly', 70, 3.2);
insert into deliveryboy (name, age, rating) values ('Tatiana', 62, 3.4);
insert into deliveryboy (name, age, rating) values ('Lucila', 41, 4.6);
insert into deliveryboy (name, age, rating) values ('Luther', 36, 3.7);
insert into deliveryboy (name, age, rating) values ('Adriano', 32, 2.0);
insert into deliveryboy (name, age, rating) values ('Heinrik', 50, 2.2);
insert into deliveryboy (name, age, rating) values ('Leopold', 32, 2.3);
insert into deliveryboy (name, age, rating) values ('Berti', 41, 4.3);
insert into deliveryboy (name, age, rating) values ('Celka', 37, 4.5);
insert into deliveryboy (name, age, rating) values ('Honor', 65, 2.2);
insert into deliveryboy (name, age, rating) values ('Cindy', 57, 3.6);
insert into deliveryboy (name, age, rating) values ('Storm', 70, 2.7);
insert into deliveryboy (name, age, rating) values ('Thacher', 55, 3.4);
insert into deliveryboy (name, age, rating) values ('Dinnie', 45, 2.4);
insert into deliveryboy (name, age, rating) values ('Rab', 70, 3.0);
insert into deliveryboy (name, age, rating) values ('Valerie', 37, 2.7);
insert into deliveryboy (name, age, rating) values ('Yetty', 39, 4.3);
insert into deliveryboy (name, age, rating) values ('Rosina', 38, 4.2);

-- delivery
insert into delivery (payid, did) values (1, 1);
insert into delivery (payid, did) values (2, 2);
insert into delivery (payid, did) values (3, 3);
insert into delivery (payid, did) values (4, 4);
insert into delivery (payid, did) values (5, 5);
insert into delivery (payid, did) values (6, 6);
insert into delivery (payid, did) values (7, 7);
insert into delivery (payid, did) values (8, 8);
insert into delivery (payid, did) values (9, 9);
insert into delivery (payid, did) values (10, 10);
insert into delivery (payid, did) values (11, 11);
insert into delivery (payid, did) values (12, 12);
insert into delivery (payid, did) values (13, 13);
insert into delivery (payid, did) values (14, 14);
insert into delivery (payid, did) values (15, 15);
insert into delivery (payid, did) values (16, 16);
insert into delivery (payid, did) values (17, 17);
insert into delivery (payid, did) values (18, 18);
insert into delivery (payid, did) values (19, 19);
insert into delivery (payid, did) values (20, 20);
insert into delivery (payid, did) values (21, 21);
insert into delivery (payid, did) values (22, 22);
insert into delivery (payid, did) values (23, 23);
insert into delivery (payid, did) values (24, 24);
insert into delivery (payid, did) values (25, 25);
insert into delivery (payid, did) values (26, 26);
insert into delivery (payid, did) values (27, 27);
insert into delivery (payid, did) values (28, 28);
insert into delivery (payid, did) values (29, 29);
insert into delivery (payid, did) values (30, 30);
insert into delivery (payid, did) values (31, 31);
insert into delivery (payid, did) values (32, 32);
insert into delivery (payid, did) values (33, 33);
insert into delivery (payid, did) values (34, 34);
insert into delivery (payid, did) values (35, 35);
insert into delivery (payid, did) values (36, 36);
insert into delivery (payid, did) values (37, 37);
insert into delivery (payid, did) values (38, 38);
insert into delivery (payid, did) values (39, 39);
insert into delivery (payid, did) values (40, 40);
insert into delivery (payid, did) values (41, 41);
insert into delivery (payid, did) values (42, 42);
insert into delivery (payid, did) values (43, 43);
insert into delivery (payid, did) values (44, 44);
insert into delivery (payid, did) values (45, 45);
insert into delivery (payid, did) values (46, 46);
insert into delivery (payid, did) values (47, 47);
insert into delivery (payid, did) values (48, 48);
insert into delivery (payid, did) values (49, 49);
insert into delivery (payid, did) values (50, 50);
insert into delivery (payid, did) values (51, 51);
insert into delivery (payid, did) values (52, 52); 
insert into delivery (payid, did) values (53, 53);
insert into delivery (payid, did) values (54, 54);
insert into delivery (payid, did) values (55, 55);
insert into delivery (payid, did) values (56, 56);
insert into delivery (payid, did) values (57, 57);
insert into delivery (payid, did) values (58, 58);
insert into delivery (payid, did) values (59, 59);
insert into delivery (payid, did) values (60, 60);
insert into delivery (payid, did) values (61, 61);
insert into delivery (payid, did) values (62, 62);
insert into delivery (payid, did) values (63, 63);
insert into delivery (payid, did) values (64, 64);
insert into delivery (payid, did) values (65, 65);
insert into delivery (payid, did) values (66, 66);
insert into delivery (payid, did) values (67, 67);
insert into delivery (payid, did) values (68, 68);
insert into delivery (payid, did) values (69, 69);
insert into delivery (payid, did) values (70, 70);
insert into delivery (payid, did) values (71, 71);
insert into delivery (payid, did) values (72, 72);
insert into delivery (payid, did) values (73, 73);
insert into delivery (payid, did) values (74, 74);
insert into delivery (payid, did) values (75, 75);
insert into delivery (payid, did) values (76, 76);
insert into delivery (payid, did) values (77, 77);
insert into delivery (payid, did) values (78, 78);
insert into delivery (payid, did) values (79, 79);
insert into delivery (payid, did) values (80, 80);
insert into delivery (payid, did) values (81, 81);
insert into delivery (payid, did) values (82, 82);
insert into delivery (payid, did) values (83, 83);
insert into delivery (payid, did) values (84, 84);
insert into delivery (payid, did) values (85, 85);
insert into delivery (payid, did) values (86, 86);
insert into delivery (payid, did) values (87, 87);
insert into delivery (payid, did) values (88, 88);
insert into delivery (payid, did) values (89, 89);
insert into delivery (payid, did) values (90, 90);
insert into delivery (payid, did) values (91, 91);
insert into delivery (payid, did) values (92, 92);
insert into delivery (payid, did) values (93, 93);
insert into delivery (payid, did) values (94, 94);
insert into delivery (payid, did) values (95, 95);
insert into delivery (payid, did) values (96, 1);
insert into delivery (payid, did) values (97, 1);
insert into delivery (payid, did) values (98, 12);
insert into delivery (payid, did) values (99, 11);
insert into delivery (payid, did) values (100, 12);

-- orderdetails
insert into orderdetails (orderdate, payid) values ('2022-07-06', 1);
insert into orderdetails (orderdate, payid) values ('2022-05-19', 2);
insert into orderdetails (orderdate, payid) values ('2022-08-18', 3);
insert into orderdetails (orderdate, payid) values ('2022-08-17', 4);
insert into orderdetails (orderdate, payid) values ('2022-09-09', 5);
insert into orderdetails (orderdate, payid) values ('2022-07-21', 6);
insert into orderdetails (orderdate, payid) values ('2022-06-07', 7);
insert into orderdetails (orderdate, payid) values ('2022-08-25', 8);
insert into orderdetails (orderdate, payid) values ('2022-09-29', 9);
insert into orderdetails (orderdate, payid) values ('2022-09-10', 10);
insert into orderdetails (orderdate, payid) values ('2022-06-01', 11);
insert into orderdetails (orderdate, payid) values ('2022-03-02', 12);
insert into orderdetails (orderdate, payid) values ('2022-12-06', 13);
insert into orderdetails (orderdate, payid) values ('2022-03-05', 14);
insert into orderdetails (orderdate, payid) values ('2022-09-22', 15);
insert into orderdetails (orderdate, payid) values ('2022-08-03', 16);
insert into orderdetails (orderdate, payid) values ('2022-10-07', 17);
insert into orderdetails (orderdate, payid) values ('2022-04-10', 18);
insert into orderdetails (orderdate, payid) values ('2022-06-29', 19);
insert into orderdetails (orderdate, payid) values ('2022-04-21', 20);
insert into orderdetails (orderdate, payid) values ('2022-08-10', 21);
insert into orderdetails (orderdate, payid) values ('2023-01-29', 22);
insert into orderdetails (orderdate, payid) values ('2022-03-26', 23);
insert into orderdetails (orderdate, payid) values ('2022-11-20', 24);
insert into orderdetails (orderdate, payid) values ('2022-03-13', 25);
insert into orderdetails (orderdate, payid) values ('2022-11-28', 26);
insert into orderdetails (orderdate, payid) values ('2022-05-28', 27);
insert into orderdetails (orderdate, payid) values ('2022-11-01', 28);
insert into orderdetails (orderdate, payid) values ('2022-09-23', 29);
insert into orderdetails (orderdate, payid) values ('2022-03-08', 30);
insert into orderdetails (orderdate, payid) values ('2022-07-03', 31);
insert into orderdetails (orderdate, payid) values ('2022-08-11', 32);
insert into orderdetails (orderdate, payid) values ('2022-07-24', 33);
insert into orderdetails (orderdate, payid) values ('2022-11-02', 34);
insert into orderdetails (orderdate, payid) values ('2022-09-16', 35);
insert into orderdetails (orderdate, payid) values ('2023-01-31', 36);
insert into orderdetails (orderdate, payid) values ('2022-05-06', 37);
insert into orderdetails (orderdate, payid) values ('2022-02-24', 38);
insert into orderdetails (orderdate, payid) values ('2022-12-12', 39);
insert into orderdetails (orderdate, payid) values ('2022-10-23', 40);
insert into orderdetails (orderdate, payid) values ('2022-12-25', 41);
insert into orderdetails (orderdate, payid) values ('2022-06-23', 42);
insert into orderdetails (orderdate, payid) values ('2022-04-21', 43);
insert into orderdetails (orderdate, payid) values ('2022-05-26', 44);
insert into orderdetails (orderdate, payid) values ('2022-10-01', 45);
insert into orderdetails (orderdate, payid) values ('2023-02-09', 46);
insert into orderdetails (orderdate, payid) values ('2022-08-05', 47);
insert into orderdetails (orderdate, payid) values ('2022-02-21', 48);
insert into orderdetails (orderdate, payid) values ('2022-08-07', 49);
insert into orderdetails (orderdate, payid) values ('2022-04-13', 50);
insert into orderdetails (orderdate, payid) values ('2022-08-31', 51);
insert into orderdetails (orderdate, payid) values ('2022-03-01', 52);
insert into orderdetails (orderdate, payid) values ('2022-11-18', 53);
insert into orderdetails (orderdate, payid) values ('2022-12-14', 54);
insert into orderdetails (orderdate, payid) values ('2022-03-18', 55);
insert into orderdetails (orderdate, payid) values ('2022-09-22', 56);
insert into orderdetails (orderdate, payid) values ('2023-01-16', 57);
insert into orderdetails (orderdate, payid) values ('2023-01-07', 58);
insert into orderdetails (orderdate, payid) values ('2022-07-26', 59);
insert into orderdetails (orderdate, payid) values ('2022-08-20', 60);
insert into orderdetails (orderdate, payid) values ('2023-01-26', 61);
insert into orderdetails (orderdate, payid) values ('2022-06-17', 62);
insert into orderdetails (orderdate, payid) values ('2022-09-15', 63);
insert into orderdetails (orderdate, payid) values ('2022-07-08', 64);
insert into orderdetails (orderdate, payid) values ('2022-05-19', 65);
insert into orderdetails (orderdate, payid) values ('2022-07-15', 66);
insert into orderdetails (orderdate, payid) values ('2022-09-18', 67);
insert into orderdetails (orderdate, payid) values ('2022-11-02', 68);
insert into orderdetails (orderdate, payid) values ('2022-04-14', 69);
insert into orderdetails (orderdate, payid) values ('2022-11-16', 70);
insert into orderdetails (orderdate, payid) values ('2022-08-17', 71);
insert into orderdetails (orderdate, payid) values ('2023-01-21', 72);

insert into orderdetails (orderdate, payid) values ('2022-10-07', 74);
insert into orderdetails (orderdate, payid) values ('2022-08-07', 75);
insert into orderdetails (orderdate, payid) values ('2022-09-30', 76);
insert into orderdetails (orderdate, payid) values ('2022-10-29', 77);
insert into orderdetails (orderdate, payid) values ('2022-07-21', 78);
insert into orderdetails (orderdate, payid) values ('2022-02-19', 79);
insert into orderdetails (orderdate, payid) values ('2022-07-11', 80);
insert into orderdetails (orderdate, payid) values ('2022-10-11', 81);
insert into orderdetails (orderdate, payid) values ('2022-06-20', 82);
insert into orderdetails (orderdate, payid) values ('2022-07-01', 83);
insert into orderdetails (orderdate, payid) values ('2022-11-16', 84);
insert into orderdetails (orderdate, payid) values ('2022-07-29', 73);
insert into orderdetails (orderdate, payid) values ('2022-07-29', 85);
insert into orderdetails (orderdate, payid) values ('2022-07-29', 86);
insert into orderdetails (orderdate, payid) values ('2022-08-23', 87);
insert into orderdetails (orderdate, payid) values ('2022-03-05', 88);
insert into orderdetails (orderdate, payid) values ('2022-09-17', 89);
insert into orderdetails (orderdate, payid) values ('2022-11-09', 90);
insert into orderdetails (orderdate, payid) values ('2023-01-28', 91);
insert into orderdetails (orderdate, payid) values ('2023-01-12', 92);
insert into orderdetails (orderdate, payid) values ('2022-12-08', 93);
insert into orderdetails (orderdate, payid) values ('2022-09-02', 94);
insert into orderdetails (orderdate, payid) values ('2022-03-11', 95);
insert into orderdetails (orderdate, payid) values ('2022-06-20', 96);
insert into orderdetails (orderdate, payid) values ('2022-04-20', 97);
insert into orderdetails (orderdate, payid) values ('2022-02-16', 98);
insert into orderdetails (orderdate, payid) values ('2022-11-30', 97);
insert into orderdetails (orderdate, payid) values ('2022-11-26', 100);

-- cart
insert into Cart (payid, pid, cid, quantity, price,status) values (1, 10, 44, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (2, 10, 47, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (3, 10, 36, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (4, 10, 23, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (5, 10, 2, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (6, 10, 14, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (7, 10, 14, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (8, 10, 50, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (9, 10, 11, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (10, 10, 4, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (11, 10, 13, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (12, 10, 42, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (13, 10, 15, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (14, 10, 23, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (15, 10, 14, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (16, 10, 19, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (17, 10, 2, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (18, 10, 44, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (19, 10, 22, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (20, 10, 27, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (21, 10, 9, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (22, 10, 37, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (23, 10, 50, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (24, 10, 38, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (25, 10, 48, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (26, 10, 27, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (27, 10, 44, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (28, 10, 48, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (29, 10, 1, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (30, 10, 43, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (31, 10, 42, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (32, 10, 25, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (33, 10, 23, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (34, 10, 32, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (35, 10, 21, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (36, 10, 28, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (37, 10, 26, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (38, 10, 21, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (39, 10, 1, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (40, 10, 47, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (41, 10, 33, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (42, 10, 11, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (43, 10, 40, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (44, 10, 18, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (45, 10, 47, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (46, 10, 12, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (47, 10, 32, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (48, 10, 14, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (49, 10, 25, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (50, 10, 12, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (51, 10, 18, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (52, 10, 6, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (53, 10, 16, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (54, 10, 12, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (55, 10, 34, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (56, 10, 49, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (57, 10, 15, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (58, 10, 16, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (59, 10, 39, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (60, 10, 13, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (61, 10, 19, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (62, 10, 2, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (63, 10, 25, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (64, 10, 50, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (65, 10, 25, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (66, 10, 11, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (67, 10, 27, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (68, 10, 38, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (69, 10, 41, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (70, 10, 22, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (71, 10, 1, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (72, 10, 28, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (73, 10, 39, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (74, 10, 20, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (75, 10, 27, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (76, 10, 33, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (77, 10, 7, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (78, 10, 3, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (79, 10, 40, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (80, 10, 22, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (81, 10, 15, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (82, 10, 31, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (83, 10, 43, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (84, 10, 18, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (85, 10, 22, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (86, 10, 18, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (87, 10, 19, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (88, 10, 23, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (89, 10, 43, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (90, 10, 21, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (91, 10, 1, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (92, 10, 41, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (93, 10, 9, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (94, 10, 31, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (95, 10, 35, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (96, 11, 48, 1, 1041,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (97, 12, 17, 1, 846,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (98, 10, 44, 10, 2900,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (99, 1, 44, 1, 1241,'delivered');
insert into Cart (payid, pid, cid, quantity, price,status) values (100, 2, 44, 1, 1375,'delivered');

insert into Cart ( pid, cid, quantity, price) values ( 10, 44, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 3, 44, 1, 1494);
insert into Cart ( pid, cid, quantity, price) values ( 4, 44, 1, 1500);
insert into Cart ( pid, cid, quantity, price) values ( 10, 23, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 2, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 14, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 14, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 50, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 11, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 4, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 13, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 42, 10, 2900);
insert into Cart ( pid, cid, quantity, price) values ( 10, 15, 10, 2900);


-- ----selecting products that belong to JEANS---
SELECT * FROM Product where catid in (
	SELECT catid FROM category where name="Jeans");
-- ----proving all product ids are unique ------ -- 
SELECT name FROM Product WHERE pid in (
	SELECT pid FROM Product GROUP BY pid HAVING COUNT(*)>=2);
-- ----to view past orders of a customer with name Sam --- 
SELECT * FROM Product WHERE pid in (
	SELECT pid FROM Cart WHERE cid = (SELECT cid FROM customer WHERE fname ='Sam' AND lname='Gorham')  AND status ='delivered');
-- -----to view products in cart of a customer with name Sam Gorham
SELECT p.name as productName ,p.rating,p.price,c.quantity,p.manufacturingDate FROM product p,cart c ,customer cu WHERE c.status='not delivered' AND c.cid=cu.cid AND cu.fname='Sam' AND p.pid =c.pid;

-- ------top 10 most expensive products----
SELECT * FROM Product ORDER BY price DESC LIMIT 10;
-- detail of customer who ordered a Jeans
SELECT * FROM Customer WHERE cid in 
	(SELECT cid FROM Cart WHERE status ='delivered' AND pid in 
		(SELECT pid FROM Product WHERE cid in 
			(SELECT catid FROM category where name='Jeans')));
-- ---find min and max product in store----
SELECT (SELECT name FROM Product WHERE price =(SELECT MIN(price) FROM PRODUCT)) AS min_cost_product,
	(SELECT MIN(price) FROM PRODUCT) AS min_cost, 
	(SELECT name FROM Product WHERE price = (SELECT MAX(price) FROM PRODUCT)) AS max_cost_product,
	(SELECT MAX(price) FROM PRODUCT) AS max_cost ;
-- ---------CATEGORY AND PRODUCTS-------            
SELECT Product.name AS ProductName,Category.name AS CategoryName FROM Product JOIN Category ON category.catid=product.catid ;
-- -----products sold between last three months---
SELECT * FROM Product WHERE pid in(
	SELECT pid FROM Cart WHERE payid in(
		SELECT payid FROM orderdetails WHERE orderdate>= DATE_SUB("2023-01-01", INTERVAL 3 MONTH)));
-- ----times differnet modes are used
SELECT modeofpayment,COUNT(*) AS noOfTimesUsed FROM Payment GROUP BY modeofpayment;
-- ----top 10 customers who have spent the most on purchases, along with their total spending
SELECT c.cid, c.fname, c.lname, SUM(p.price * ct.quantity) AS total_spending
FROM customer c
JOIN cart ct ON c.cid = ct.cid
JOIN product p ON ct.pid = p.pid
GROUP BY c.cid, c.fname, c.lname
ORDER BY total_spending DESC
LIMIT 10;
-- ----avg rating of products in category wise
SELECT cat.name, AVG(p.rating) as avg_rating FROM product p JOIN category cat ON p.catid = cat.catid GROUP BY cat.catid;
-- ---products and belonging category
SELECT Product.name AS ProductName,Category.name AS CategoryName FROM Product JOIN Category ON category.catid=product.catid ;

-- --number of times a delivery boy has delivered
SELECT deliveryboy.name, COUNT(delivery.payid) AS num_deliveries
FROM deliveryboy
JOIN delivery ON deliveryboy.did = delivery.did
GROUP BY deliveryboy.did
ORDER BY num_deliveries DESC;


-- top 5 customers who have spent the most on orders
SELECT c.fname,c.email, SUM(cart.price) AS total_spent
FROM customer c
JOIN cart ON c.cid = cart.cid
WHERE cart.status = 'delivered'
GROUP BY c.email
ORDER BY total_spent DESC
LIMIT 5;

-- ---details of all orders that have been delivered by delivery boy with id 1
SELECT c.fname, c.mname, c.lname, p.name as product_name, od.orderdate, db.name as delivery_boy_name
FROM customer c
JOIN cart ct ON c.cid = ct.cid
JOIN product p ON ct.pid = p.pid
JOIN payment pm ON ct.payid = pm.payid
JOIN orderdetails od ON pm.payid = od.payid
JOIN delivery d ON pm.payid = d.payid
JOIN deliveryboy db ON d.did = db.did
WHERE d.did = 1 AND ct.status = 'delivered';

-- ---customer details with no of orders and total amount spent
SELECT c.fname AS customer_fname, c.lname AS customer_lname, a.locality, a.city, a.state, 
COUNT(DISTINCT o.payid) AS num_orders, SUM(od.total_price) AS total_spent
FROM customer c 
JOIN address a ON c.cid = a.cid 
LEFT JOIN payment p ON a.aid = p.aid 
LEFT JOIN orderdetails o ON p.payid = o.payid 
LEFT JOIN (SELECT payid, SUM(quantity * price) AS total_price FROM cart GROUP BY payid) od ON p.payid = od.payid 
GROUP BY c.cid, a.aid 
ORDER BY total_spent DESC;
-- --customers and products that were ordered by COD as modeofpayment
SELECT c.fname AS customer_fname, c.lname AS customer_lname, p.name AS product_name ,p.price,p.quantity
FROM customer c
INNER JOIN cart ct ON c.cid = ct.cid
INNER JOIN product p ON ct.pid = p.pid
INNER JOIN payment pm ON ct.payid = pm.payid
WHERE pm.modeofpayment = 'COD';
-- --List the total number of orders and the total revenue generated by each retailer
SELECT r.fname, r.lname, COUNT(o.payid) AS total_orders, SUM(p.price) AS total_revenue
FROM Retailer r
JOIN product p ON r.rid = p.rid
JOIN cart ON p.pid = cart.pid
JOIN orderdetails o ON cart.payid = o.payid
GROUP BY r.rid
ORDER BY total_revenue DESC;


UPDATE Cart SET status = "delivered" WHERE pid = "10" AND cid="99";
UPDATE Product SET quantity = quantity + 5 WHERE catid in (SELECT catid FROM category WHERE name = "Pants");
DELETE FROM deliveryboy WHERE rating<=3 OR rating >5 ORDER BY rating ASC limit 20;
DELETE FROM Product WHERE rid = "10";
-- DELETE FROM Product WHERE price<0 ;
ALTER TABLE category CHANGE COLUMN name category_name VARCHAR(255) NOT NULL;
UPDATE Product p
INNER JOIN (
  SELECT pid, SUM(quantity) as delivered_quantity
  FROM cart
  WHERE status = 'delivered'
  GROUP BY pid
) c ON p.pid = c.pid
SET p.quantity = p.quantity - c.delivered_quantity;

-- delimiter $$ 

-- get mode of payments for different addresses and total count of each type of mode
SELECT modeofpayment,aid,count(*) 
FROM PAYMENT
GROUP BY MODEOFPAYMENT,AID WITH ROLLUP ;

-- get products with price<3000 and rating>3 grouped on the basis of category ID and manufacturing date
SELECT catid, manufacturingDate, count(pid)
FROM PRODUCT
where rating>3 and price<3000
GROUP BY catid, manufacturingDate WITH ROLLUP ;

-- get no of customers for each state and city
SELECT State, City, count(aid) as COUNT_OF_CUSTOMERS
FROM ADDRESS where cid between 10 and 2000
GROUP BY State, City WITH ROLLUP;

-- get number of products for each retailer and category
SELECT COALESCE(retailer.rid, 'ALL products') as Retailer_ID, catid AS Category_ID, count(*) as COUNT_OF_PRODUCTS
FROM PRODUCT,RETAILER where product.rid = retailer.rid
GROUP BY retailer.rid, catid WITH ROLLUP ;

-- Select @@version 

-- select * from customer ;
-- Non-conflicting transactions
START TRANSACTION;
INSERT INTO customer (fname,password,number,email) VALUES ('Sam','75fyu$&^G','9393931547','sam@example1.com');
INSERT INTO customer (fname,password,number,email) VALUES ('Eric','g#W&HGsjS','9912904954','eric@example1.com');
COMMIT;

START TRANSACTION;
UPDATE product SET price = price*1.1 WHERE pid = 34;
UPDATE product SET price = price*1.2 WHERE pid = 12;
COMMIT;

START TRANSACTION;
DELETE FROM customer WHERE fname = 'Sam' and number='9393931547' and email='sam@example1.com';
DELETE FROM customer WHERE fname = 'Eric' and number='9912904954' and email='eric@example1.com';
COMMIT;

START TRANSACTION;
UPDATE product SET price = price/1.1 WHERE pid = 34;
UPDATE product SET price = price/1.2 WHERE pid = 12;
COMMIT;

START TRANSACTION;
UPDATE product SET price = price*1.1 WHERE pid = 15;
INSERT INTO customer (fname,password,number,email) VALUES ('Sam','75fyu$&^G','9393931547','sam@example1.com');
rollback;
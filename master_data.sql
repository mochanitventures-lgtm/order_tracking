--Idempotent Script (Re-runable)
ALTER TABLE odts.user_roles
ALTER COLUMN role_id RESTART WITH 1;
DELETE FROM odts.user_roles;
INSERT INTO odts.user_roles (role_name, role_desc) VALUES
('DEALER', 'Dealer user'),
('DISPATCHER', 'Dispatcher user'),
('OFFICE_EXECUTIVE', 'Office operations'),
('SALES_OFFICER', 'Sales team'),
('ADMIN', 'System admin')
ON CONFLICT (role_name) DO NOTHING;
SELECT * FROM user_roles;

ALTER TABLE odts.locations
ALTER COLUMN location_id RESTART WITH 1;
DELETE FROM odts.locations;
INSERT INTO odts.locations (location_name, location_desc, location_is_active_flag) VALUES
('RAKE', 'Railway rake location', TRUE),
('GODOWN', 'Storage warehouse', TRUE),
('PLANT', 'Manufacturing plant', TRUE)
ON CONFLICT (location_name) DO NOTHING;
SELECT * FROM odts.locations;

ALTER TABLE odts.products
ALTER COLUMN product_id RESTART WITH 1;
DELETE FROM odts.products;
INSERT INTO odts.products (product_name, product_desc, product_is_active_flag)
VALUES
('GOLD', 'Premium grade product', TRUE),
('POWER', 'High performance product', TRUE),
('PLUS', 'Standard product', TRUE)
ON CONFLICT (product_name) DO NOTHING;
SELECT * FROM odts.products;

select * from odts.dealers;
delete from odts.dealers;
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110032672','ADESH TRADERS','VARANASI',9415204148,'ANAND GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110097794','AJAY PAINT AND HARDWARE STORES','VARANASI',9450872462,'HIMANSHU AGRAHARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033143','AKASH ENTERPRISES','VARANASI',9415202341,'SHUBHASH JAISWAL',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110117683','AKK TRADERS','VARANASI',7860091091,'Ashwani Kumar Khanna',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110235610','AMAN BUILDING MATERIALS','VARANASI',9450251409,'RAMASHREY SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110221017','AMAR CONSTRUCTIONS AND SUPPLIER','VARANASI',9336835074,'SUNIL KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033203','ANJALI ENTERPRISES','VARANASI',9415336241,'ANIL KUMAR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110202061','ANKIT BUILDING MATERIALS','VARANASI',9453397468,'ABHAY KUMAR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110208385','ANUJ TRADING COMPANY','VARANASI',8052212829,'SIMPAL KESHARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110207934','AWANTI CEMENT AGENCY','VARANASI',8887652664,'RAJENDRA NATH GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110217758','AYUSH TRADING COMPANY','VARANASI',9451609946,'HARIDASH JAISHAWAL',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110235576','BEMISHAL CEMENT AGENCY','VARANASI',8318590576,'MOHAMMAD SALMAN',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110232851','BHAGIRATHI CONSTRUCTION AND SUPPLIE','VARANASI',9044339800,'LALLAN SHARMA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110092659','BHOLE NATH ENTERPRISES','VARANASI',9454231797,'Dilip Kumar Rai',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033101','BIRASAN ENTERPRISES','VARANASI',9415223227,'Sanjay Ghosh',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110187050','DAYAL TRADERS','VARANASI',9919156255,'SANTOSH KUMAR GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110131504','DEVARSHI ENTERPRISES','VARANASI',7754994433,'Ramesh Pratap Singh',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110204851','DIVYANSH BUILDING MATERIAL','VARANASI',9795337722,'ROSHAN YADAV',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110209421','FVS TRADING CORPORATION','VARANASI',9125461413,'ARSHAD ANSARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110144134','G S TRADERS','VARANASI',9415696821,'GHANSHYAM YADAV',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110184692','GEETA BUILDING MATERIAL','VARANASI',9839144542,'NAND',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110178852','HARSH CEMENT AGENCY','VARANASI',9838674727,'PANKAJ KUMAR DUBEY',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110173220','HEMANT ENTERPRISES','VARANASI',9415980801,'OM PRAKASH CHAURASIA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110206595','JAY AMBEY ENTERPRISES','VARANASI',9451137695,'SANI KUMAR CHAURASIYA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110202060','JYOTI BUILDING MATERIALS','VARANASI',8115332151,'JYOTI BHUSHAN SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110171676','KAMAL ENTERPRISES','VARANASI',7007810004,'RATNESH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110236010','KESHARWANI AGENCIES','VARANASI',9415619899,'RAVI SHANKER KESARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110170402','KOMAL ENTERPRISES','VARANASI',7376746105,'AMIT',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110045030','KRIPA SHANKAR SINGH','VARANASI',9415300220,'Balkeshwar Prasad Singh',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110225636','KRIPA TRADERS','VARANASI',9120292964,'PRAJJWAL CHAUBEY',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110205222','KRISHNA ENTERPRISES','VARANASI',9219785608,'NRIPENDRA SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110203758','KRV ENTERPRISES','VARANASI',9717082620,'SUREKHA DEVI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110234954','M K ENTERPRISES','VARANASI',9695795004,'MANOJ KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110190952','MAA VAISHNO ENTERPRISES','VARANASI',9450330719,'ANIL KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110172831','MAA VASHINO HARDWARE BUILDING','VARANASI',9918777813,'GURU',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110130915','MAHARAJ JI BUILDING MATERIAL','VARANASI',9839903666,'KRISHNA AVATAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110187741','MAHAVEER ENTERPRISES','VARANASI',9695004001,'PANKAJ KUMAR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110092656','MALTI BUILDING MATERIAL','VARANASI',9839519855,'Chote Lal Pathak',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110208384','MATICOTECH INFRASTRUCTURE PVT LTD','VARANASI',8707339385,'SHIKHA SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110217209','MISHRA BUILDING SOLUTIONS','VARANASI',7007599046,'PRAVINA DEVI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110231172','MOURYA ENTERRPISES','VARANASI',7524936871,'NANDLAL MAURYA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110228566','NEW PRADEEP STEELS','VARANASI',9839093699,'PRADIP KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110200556','OM BUILDING MATERIAL','VARANASI',9919568696,'MUKESH YADAV',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110170948','OM SHIV BHOLE BUILDING MATERIAL','VARANASI',8840542177,'RITU TIWARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110234216','OM SHREE SAI NATH ENTERPRISES','VARANASI',9919781361,'MUHAMMAD SALIM',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033198','OM TRADERS','VARANASI',9451582416,'Shiv Bhajan Pandey',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110220921','PARTH BUILDCON','VARANASI',9611375476,'ANJESH KUMAR TRIPATHI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110178792','PATHAK BUILDING MATERIALS','VARANASI',9839505929,'PRADEEP KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110237589','PAWAN ENTERPRISES','VARANASI',8090412525,'PAWAN KUMAR CHOUBEY',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110046614','PURWAR CEMENT BHANDAR','VARANASI',9415305397,'ADITYA GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033210','R K BUILDING MATERIAL','VARANASI',9415343325,'RISHIKESH SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110225594','RAGINI ENTERPRISES','VARANASI',9088666333,'RAGINI SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110070000','RAJARAM OMPRAKASH IRON STORE','VARANASI',9956585951,'OM PRAKASH GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033157','ROSHAN CEMENT AGENCY','VARANASI',9415304457,'UMESH KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110235599','ROYAL TRADERS','VARANASI',8318617656,'WASEEM AKHTAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110180027','S K ENTERPRISES','VARANASI',9919010488,'SATISH KUMAR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110206768','SAHU TRADERS','VARANASI',7905825188,'SHWETA GUPTA',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110093690','SAI CEMENT AGENCY','VARANASI',9453203994,'Tribhuvan Mishra',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110078716','SAMRAT IRON STORES','VARANASI',9415285959,'Shyam Sundar Singh Kashyap',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033156','SATYA NARAIN CEMENT AGENCY','VARANASI',9839910609,'Shyam Narain Singh',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033205','SHIVA CEMENT AGENCY','VARANASI',9415988037,'Dhirendra Kumar Yadav',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033207','SHIVAM CEMENT AGENCY','VARANASI',9415446150,'RAJESH KUMAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110159541','SHREE BALAJI ENTERPRISES','VARANASI',9336182012,'NANDINI SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110235580','SHREE MAHADEV BUILDING MATERIAL','VARANASI',7785804546,'RAJAT SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033213','SHREE RAM IRON STORES','VARANASI',9415447483,'BRIJESH KUMAR VARMAN',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110206767','SHREE RAM STEEL','VARANASI',6392041429,'ASHOK SETH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110234300','SHRI GANPATI INFRATECH','VARANASI',7376590900,'PRATIBHA TIWARI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110224954','SHRI RAM ENTERPRISES','VARANASI',7071973919,'AYUSH JAISWAL',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110183722','SHRI SIDDHI VINAYAK BUILDING','VARANASI',6394817496,'JAY',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110235624','SINGH BROTHERS','VARANASI',9838808962,'ANIL KUMAR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110220933','SN INFRA MARKET','VARANASI',7905258004,'AMIT UPADHYAY',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110228028','SRI MAHADEV ENTERPRISES','VARANASI',8574508918,'VIJAY BAHADUR SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110166533','SUMITRA TRADERS','VARANASI',8318581393,'SUMITRA DEVI',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110068757','SUNDER CEMENT AGENCY','VARANASI',7905926492,'SURENDRA KUMAR YADAV',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110188732','VIDHYA ENTERPRISES','VARANASI',9559895003,'MAHENDRA PRATAP SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110162175','VIJAY SHANKAR CONSTRUCTION','VARANASI',9935262692,'VIJAY SHANKAR',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110145353','VINAY BUILDING MATERIALS','VARANASI',9450012613,'RANJEET SINGH',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
Insert into odts.dealers (dealer_code, dealer_company_name, dealer_address, dealer_phone, dealer_name,  created_by, created_at, updated_by, updated_at) values ( '9110033145','VISHWANATH PRASAD SATYA CHARAN','VARANASI',9415228637,'SANJAY BARANWAL',0, CURRENT_TIMESTAMP,0, CURRENT_TIMESTAMP);
commit;



insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110032672','9110032672','ADESH TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110032672','9111344015','A.K.BROTHERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110032672','9111066282','NARAIN CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110097794','9110097794','AJAY PAINT AND HARDWARE STORES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111395954','ADARSH BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9110033143','AKASH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111341619','SHRI LAXMIPATI BALAJEE INTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111396089','SHIV SHAKTI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111393309','SHIVAM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111450847','PRITAM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111450845','PURVANCHAL STEEL UDYOG','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111395959','NAV DURGA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111395237','ARVIND CHAUBEY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111282887','AYUSH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111395238','KHUSHI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111441930','DILEEP KUMAR JAISWAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111486627','AZEEM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111153859','SUNIL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111482874','MAA AMBE BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111249789','SHRI BALAJI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111437592','RAJNATH BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111393307','MISHRA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111441929','SATYANANT ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111396088','SENGER BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111393308','BAJRANG HARDWARE & BUILDING MATERIA','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033143','9111441928','SADGURU ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111439952','OM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111490755','S K ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111472814','CHIRANJEEVI CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9110117683','AKK TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111396158','AMBA TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111372887','BHARAT ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111367518','NASEER KHAN','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111369361','SHYAMA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111470298','AVANI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111388702','KHAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111356849','SHUBHI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111389988','VARANASI CONCRETE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110117683','9111388703','KHAN AND SONS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110235610','9110235610','AMAN BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110221017','9111480449','OM SAKSHI TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110221017','9110221017','AMAR CONSTRUCTIONS AND SUPPLIER','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110221017','9111463830','A P BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110221017','9111489817','DHEER ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033203','9111348632','SHYAM LAL JINDAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033203','9110033203','ANJALI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033203','9111394841','VERMA LIME STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110202061','9110202061','ANKIT BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110208385','9110208385','ANUJ TRADING COMPANY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110208385','9111442997','MAA SANKTHA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110207934','9110207934','AWANTI CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110207934','9111414832','DINESH KUMAR VERMA','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110207934','9111443375','SAROJ DEVI','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110217758','9110217758','AYUSH TRADING COMPANY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110235576','9110235576','BEMISHAL CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110232851','9110232851','BHAGIRATHI CONSTRUCTION AND SUPPLIE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110092659','9110092659','BHOLE NATH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033101','9111063700','KAMAKYHA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033101','9111311873','KHALIK BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033101','9110033101','BIRASAN ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110187050','9111480498','AARADHY BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110187050','9110187050','DAYAL TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110187050','9111434373','R S CONSTRUCTION AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111447527','HARSHIT ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9110131504','DEVARSHI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111330368','VERMA CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111066186','CHANDEL ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111432362','VIBHA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111392099','GAURAV TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111205007','S KUMAR BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111299352','POORNIMA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110131504','9111408192','OM ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110204851','9110204851','DIVYANSH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110209421','9111452654','SHIDRATH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110209421','9111489795','VISHAL BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110209421','9110209421','FVS TRADING CORPORATION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110209421','9111470084','SHIVAM SINGH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110144134','9110144134','G S TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110144134','9111400344','ABRAR KHAN','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110144134','9111413749','ABHAY YADAV','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110184692','9110184692','GEETA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110178852','9110178852','HARSH CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110173220','9110173220','HEMANT ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110173220','9111489818','JAI AMBEY TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206595','9110206595','JAY AMBEY ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206595','9111458482','R R CHAURASHIYA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110202060','9110202060','JYOTI BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110202060','9111456432','PARVATI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110171676','9110171676','KAMAL ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110236010','9110236010','KESHARWANI AGENCIES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110170402','9110170402','KOMAL ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110045030','9110045030','KRIPA SHANKAR SINGH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110225636','9110225636','KRIPA TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110205222','9110205222','KRISHNA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110205222','9111439951','NARAYAN ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110205222','9111437590','AKANCHHA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110146501','9110146501','KRISHNA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110203758','9110203758','KRV ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110234954','9110234954','M K ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110190952','9110190952','MAA VAISHNO ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110172831','9111456645','PATEL ENTERPRISE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110172831','9111480441','JAI MAA KALI HARDWARE SANITARY AND','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110172831','9111450846','ARPIT ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110172831','9110172831','MAA VASHINO HARDWARE BUILDING','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110172831','9111382007','KARAN CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110130915','9110130915','MAHARAJ JI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110187741','9110187741','MAHAVEER ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110092656','9110092656','MALTI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110208384','9111490758','GAUTAMI STEELS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110208384','9110208384','MATICOTECH INFRASTRUCTURE PVT LTD','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110217209','9111452655','JAMUNA PRASAD GAYA PRASAD','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110217209','9110217209','MISHRA BUILDING SOLUTIONS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110231172','9110231172','MOURYA ENTERRPISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111432573','ROHIT CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9110228566','NEW PRADEEP STEELS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111343558','SIDDHART TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111424087','VIVEK CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111380045','GOPAL ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111346005','KRISHNA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111188823','FRIENDS ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111203452','JAISWAL CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111331033','MAA BAGESHWARI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111345770','GAURAV ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111346004','AGRAHARI CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111394842','BABA KINARAM TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111486628','ADITI CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111236126','SUNIL KUMAR','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111392096','SANJANA STEELS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111416945','SHUBH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111418150','MAYANK TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111475008','HAYAN TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111188825','SALIM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111456418','JAI MAA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111410766','ANKUR AGRAHARI','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111378581','GANPATI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111238061','ALOK KUMAR GUPTA','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111188822','RAM SUMER & SONS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111449028','KRISHNA TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111380046','HARE KRISHNA CEMENT STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111437591','INDRASANI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111271757','ASHUTOSH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228566','9111190464','SHIV BUILDING MATERILS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110200556','9110200556','OM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110170948','9110170948','OM SHIV BHOLE BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110234216','9110234216','OM SHREE SAI NATH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033198','9110033198','OM TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110220921','9111460257','SHUBHI TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110220921','9110220921','PARTH BUILDCON','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110178792','9110178792','PATHAK BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110237589','9110237589','PAWAN ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111150322','SHASHANK CEMENT AGENCEY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111150321','JAISWAL CEMENT STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111169467','JAI PRAKASH SINGH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111169457','JP BUILDERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111367092','ADITYA RAJ JAISWAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9111169452','PUJA CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110046614','9110046614','PURWAR CEMENT BHANDAR','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033210','9110033210','R K BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110225594','9111472813','JYOTSANA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110225594','9110225594','RAGINI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110225594','9111472812','MAA GAYATRI TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110070000','9110070000','RAJARAM OMPRAKASH IRON STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033157','9110033157','ROSHAN CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110235599','9110235599','ROYAL TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110180027','9110180027','S K ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206768','9111471419','PATEL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206768','9111207346','SONU BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206768','9111435449','PATEL KHADH BHANDAR','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206768','9110206768','SAHU TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110093690','9110093690','SAI CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110078716','9110078716','SAMRAT IRON STORES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033156','9110033156','SATYA NARAIN CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033205','9110033205','SHIVA CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9110033207','SHIVAM CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111463014','ADARSH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111478154','ANNAPURNA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111462090','RAJBALI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111416890','RAKSHAK BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111304913','SWASHTIK BUILDING M.','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111442994','NILKANTH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111304910','VIKAS CEMENT AGENCIES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111435451','PATEL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111066207','NEW PATEL CEMENT SALES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111364351','AVANISH CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111464761','A K ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111066230','RAJ BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111154857','RAJENDER CEMENT AGENCY.','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111063755','ANAND BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111470083','OM SAI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111330948','AARAV ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111315471','PAL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033207','9111063797','PUJA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110159541','9111371492','SRI JAGDAMBA CEMENT STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110159541','9111449234','PRADEEP KUMAR','CHANDAULI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110159541','9111413909','PANKAJ KUMAR','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110159541','9110159541','SHREE BALAJI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110235580','9110235580','SHREE MAHADEV BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033213','9110033213','SHREE RAM IRON STORES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9110206767','SHREE RAM STEEL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111441931','DEEPAK IRON STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111456089','DEEPAK CEMENT AND HARDWARE STORE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111469058','JAIN ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111488051','MARUTI BUILDING MATERIAL AND','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111480499','JAISWAL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111451366','DHIRENDRA KUMAR','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111442996','SINGH BROTHER CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111470299','VIVEK ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111445246','SETH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111449029','SHAURY CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111441150','SHARDA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111480595','SKS ENTERPRISES','CHANDAULI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111453795','PRAVEEN PATHAK','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111490757','RAI TRADING COMPANY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111456429','ASHA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111442995','AYUSH SHARMA','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110206767','9111439938','VIDHAN CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110234300','9110234300','SHRI GANPATI INFRATECH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110224954','9111474990','MAA DURGA TREADING','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110224954','9110224954','SHRI RAM ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110224954','9111486606','DHANSHRI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110183722','9110183722','SHRI SIDDHI VINAYAK BUILDING','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110183722','9111394846','JAGDISH NARAYAN','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110235624','9110235624','SINGH BROTHERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110220933','9110220933','SN INFRA MARKET','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110228028','9110228028','SRI MAHADEV ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9110166533','SUMITRA TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111393559','PANKAJ JAISWAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111489791','MAA ANNAPURNA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111488050','AMAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111456150','SATISH KUMAR JAISWAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111375229','RAMESH CHANDRA TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110166533','9111451270','DASHARATH KUMAR RAI','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110068757','9110068757','SUNDER CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110188732','9110188732','VIDHYA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110188732','9111400343','VIDYA STEEL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9110162175','VIJAY SHANKAR CONSTRUCTION','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111396267','OM PRAKASH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111367520','KHUSHBOO BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111475713','MAYA MISHRA','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111392094','AVI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111367519','NEW MAA SHITLA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111382006','AMAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111448528','OM TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111409381','RIDDHI SIDDHI TRADING','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111369360','BABA BAIJNATH ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111434374','KEDAR BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111404209','KRISHNA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111448487','KIRAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111367522','NITISH YADAV','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111457767','SHIV SHAKTI ASSOCIATE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110162175','9111373717','TARA DEVI','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110145353','9110145353','VINAY BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111449027','TIRUPATI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111457222','CHANDAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111383616','SHIVAM ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111329304','SANDEEP BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304866','HARDIK HARDWERE AND BUILDING MAT','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111457192','DEEP SHIKHA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9110033145','VISHWANATH PRASAD SATYA CHARAN','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111066192','RADHESHYAM GUPTA CEMENT STOCKIST','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111358887','PRINCE BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111062067','ALAKH NARAIN SINGH','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111342165','PRADHAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304871','SAMRAT BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111329098','YADAV BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111480495','SURENDRA KUMAR JAISWAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111225822','SANJAY BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111147165','RATAN LAL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111439453','BHAVANI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111468256','SHREE PARAMHANS BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111328483','SHRI KRISHNA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111468257','SHREYANS BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111203466','SRI RADHESHYAM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111414555','GUPTA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111443376','SHREE RAM CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111470081','BABA JI BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111394845','JANTA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111384024','TIRUPATI CONSTRUCTION COMPANY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304442','AZAD BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111488048','ALOK BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111488056','RAJ ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111346195','MAA VIDYAVATI ENTERPRISES & SONS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111437589','KUSH BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111451895','SARASWATI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111198403','STAR STEEL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111360310','SHRI KESHARI BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111062034','RAMJI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111470082','D K PRADHAN BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111454465','GANGA BUILDING MATERIALS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111152711','BABA BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111287417','JAI BAJRANG CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111469057','SHIV SHAKTI PRINCE BUILDING','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111447980','JBS TRADING COMPANY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111405853','SHREE BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111066202','SHIVAM ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111066255','PRATAP BUILDERS AND HARDWARE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111390453','MAA INDRAWATI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111480494','VIDYARAJ TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111464767','SWASTIK ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111388200','VIJAY CONSTRUCTION AND SUPPLY WORKS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111443377','SATYA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304904','AMIT TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111445760','ANKIT TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111395235','CHAURASIYA FERTILIZER','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111061058','DIXIT BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111061087','AGRAHARI BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111149750','GAURAV BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111066263','DIGVIJAY CEMENT AGENCY','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304897','GAUTAM CEMENT AGENCIE','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304906','GIRDHARI ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304903','GOVIND BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111392095','HARI OM BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111340292','PATEL ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111340688','HEMANT BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111332381','JAI MAA SHARDA STEELS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111397839','MAA DURGA ENTERPRISES','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111328432','PATEL BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304895','PANKAJ TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111480496','MAA LAXMI TRADERS','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111304901','MAHABEER BUILDING MATERIAL','VARANASI');
insert into odts.dealer_party (dealer_code, party_code, party_company_name, party_address) values ('9110033145','9111489819','MAA VINDHYAVASINI CONSTRUCTION COMP','VARANASI');
commit;


INSERT INTO odts.users (
    user_role_id, 
    --user_name, 
    user_login_name, 
	password_hash
   -- user_phone, 
   -- user_email
)
WITH dealer_data AS (
    SELECT 
        d.*,
        ROW_NUMBER() OVER (ORDER BY d.dealer_id) AS rn
    FROM odts.dealers d
)
SELECT 
    (SELECT ur.role_id 
     FROM odts.user_roles ur 
     WHERE ur.role_name = 'DEALER') AS role_id,
    -- login name
    CASE 
        WHEN rn BETWEEN 1 AND 20 THEN 'alpha' || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 21 AND 40 THEN 'beta'  || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 41 AND 60 THEN 'gamma' || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 61 AND 80 THEN 'delta' || ((rn - 1) % 20 + 1)
    END AS user_login_name,
    -- password
    CASE 
        WHEN rn BETWEEN 1 AND 20 THEN 'alpha' || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 21 AND 40 THEN 'beta'  || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 41 AND 60 THEN 'gamma' || ((rn - 1) % 20 + 1)
        WHEN rn BETWEEN 61 AND 80 THEN 'delta' || ((rn - 1) % 20 + 1)
    END AS password_plain
FROM dealer_data;

commit;


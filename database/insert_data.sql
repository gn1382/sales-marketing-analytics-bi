-- Customers
INSERT INTO Customer (Name, Email, PhoneNo, Address) 
VALUES
('Ali Ahmadi', 'ali@gmail.com', '09120000001', 'Tehran'),
('Sara Karimi', 'sara@gmail.com', '09120000002', 'Shiraz'),
('Reza Hosseini', 'reza@gmail.com', '09120000003', 'Tabriz'),
('Maryam Mohammadi', 'maryam@gmail.com', '09120000004', 'Mashhad'),
('Hossein Ghasemi', 'hossein@gmail.com', '09120000005', 'Isfahan');

-- Products
INSERT INTO Product (ProductTitle, GTIN, ProductPrice)
VALUES
('Laptop', '111111', 25000),
('Headphone', '222222', 3500),
('Mouse', '333333', 900),
('Keyboard', '444444', 1800),
('Monitor', '555555', 12000);

-- Channels
INSERT INTO Channel (ChannelName)
VALUES
('Instagram'),
('Google Ads'),
('Email'),
('Facebook');

-- Campaigns
INSERT INTO Campaign (CampaignName, Budget, StartDate, EndDate)
VALUES
('Winter Sale', 100000, '2024-01-01', '2024-01-31'),
('New Year Campaign', 150000, '2024-02-01', '2024-02-15'),
('Spring Sale', 130000, '2024-03-01', '2024-03-31');

-- Orders (12 orders)
INSERT INTO [Order] (CustomerId, OrderDate, TotalPrice)
VALUES
(1,'2024-01-10',25900),
(2,'2024-01-12',3500),
(3,'2024-02-05',25900),
(4,'2024-02-18',1800),
(5,'2024-03-03',12000),
(1,'2024-03-10',25900),
(2,'2024-04-02',3500),
(3,'2024-04-15',25900),
(4,'2024-05-05',1800),
(5,'2024-05-20',12000),
(1,'2024-06-01',25900),
(2,'2024-06-15',3500);

-- Order Items
INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice)
VALUES
(1,1,1,25000),(1,3,1,900),
(2,2,1,3500),
(3,1,1,25000),(3,3,1,900),
(4,4,1,1800),
(5,5,1,12000),
(6,1,1,25000),(6,3,1,900),
(7,2,1,3500),
(8,1,1,25000),(8,3,1,900),
(9,4,1,1800),
(10,5,1,12000),
(11,1,1,25000),(11,3,1,900),
(12,2,1,3500);

-- Payments
INSERT INTO Payment (OrderId, PaymentDate, PaymentMethod, PaymentStatus, Amount)
VALUES
(1,'2024-01-10','Card','Success',25900),
(2,'2024-01-12','Card','Success',3500),
(3,'2024-02-05','Online','Success',25900),
(4,'2024-02-18','Card','Success',1800),
(5,'2024-03-03','Online','Success',12000),
(6,'2024-03-10','Card','Success',25900),
(7,'2024-04-02','Online','Success',3500),
(8,'2024-04-15','Card','Success',25900),
(9,'2024-05-05','Card','Success',1800),
(10,'2024-05-20','Online','Success',12000),
(11,'2024-06-01','Card','Success',25900),
(12,'2024-06-15','Online','Success',3500);

-- CampaignProduct
INSERT INTO CampaignProduct (CampaignId, ProductId)
VALUES
(1,1),(1,3),(2,2),(3,5);

-- CampaignChannel
INSERT INTO CampaignChannel (CampaignId, ChannelId)
VALUES
(1,1),(1,2),
(2,1),(2,3),
(3,2),(3,4);

-- CampaignPerformance
INSERT INTO CampaignPerformance (CampaignId, ChannelId, SalesNumber, ClickNumber, Cost)
VALUES
(1,1,20,400,30000),
(1,2,15,300,20000),
(2,1,10,200,15000),
(2,3,8,180,12000),
(3,2,18,350,25000),
(3,4,12,260,18000);

SELECT * FROM [Order];
SELECT * FROM OrderItem;
SELECT * FROM CampaignPerformance;

SELECT COUNT(*)
FROM [Order] o
LEFT JOIN OrderItem oi ON o.OrderId = oi.OrderId
WHERE oi.OrderId IS NULL;

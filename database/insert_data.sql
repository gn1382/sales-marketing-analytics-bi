CREATE DATABASE SalesMarketingBI;
GO
USE SalesMarketingBI;
GO

-- Base tables
CREATE TABLE Customer(
    CustomerId INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    PhoneNo NVARCHAR(20),
    Address NVARCHAR(255)
);

CREATE TABLE Product(
    ProductId INT IDENTITY PRIMARY KEY,
    ProductTitle NVARCHAR(100),
    GTIN NVARCHAR(50),
    ProductPrice DECIMAL(10,2)
);

CREATE TABLE Channel(
    ChannelId INT IDENTITY PRIMARY KEY,
    ChannelName NVARCHAR(50)
);

CREATE TABLE Campaign(
    CampaignId INT IDENTITY PRIMARY KEY,
    CampaignName NVARCHAR(100),
    Budget DECIMAL(12,2),
    StartDate DATE,
    EndDate DATE
);

-- Order tables
CREATE TABLE [Order](
    OrderId INT IDENTITY PRIMARY KEY,
    CustomerId INT,
    OrderDate DATE,
    TotalPrice DECIMAL(10,2),

    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItem(
    OrderItemId INT IDENTITY PRIMARY KEY,
    OrderId INT,
    ProductId INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY (OrderId) REFERENCES [Order](OrderId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

CREATE TABLE Payment(
    PaymentId INT IDENTITY PRIMARY KEY,
    OrderId INT,
    PaymentDate DATE,
    PaymentMethod NVARCHAR(30),
    PaymentStatus NVARCHAR(30),
    Amount DECIMAL(10,2),

    FOREIGN KEY (OrderId) REFERENCES [Order](OrderId)
);

-- Marketing tables
CREATE TABLE CampaignProduct(
    CampaignProductId INT IDENTITY PRIMARY KEY,
    CampaignId INT,
    ProductId INT,

    FOREIGN KEY (CampaignId) REFERENCES Campaign(CampaignId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

CREATE TABLE CampaignChannel(
    CampaignChannelId INT IDENTITY PRIMARY KEY,
    CampaignId INT,
    ChannelId INT,

    FOREIGN KEY (CampaignId) REFERENCES Campaign(CampaignId),
    FOREIGN KEY (ChannelId) REFERENCES Channel(ChannelId)
);

CREATE TABLE CampaignPerformance(
    CampaignPerformanceId INT IDENTITY PRIMARY KEY,
    CampaignId INT,
    ChannelId INT,
    SalesNumber INT,
    ClickNumber INT,
    Cost DECIMAL(10,2),

    FOREIGN KEY (CampaignId) REFERENCES Campaign(CampaignId),
    FOREIGN KEY (ChannelId) REFERENCES Channel(ChannelId)
);

INSERT INTO Customer (Name, Email, PhoneNo, Address)
VALUES
('Ali Ahmadi', 'ali@gmail.com', '09120000001', 'Tehran'),
('Sara Karimi', 'sara@gmail.com', '09120000002', 'Shiraz'),
('Reza Hosseini', 'reza@gmail.com', '09120000003', 'Tabriz');
INSERT INTO Product (ProductTitle, GTIN, ProductPrice)
VALUES
('Laptop', '111111', 25000),
('Headphone', '222222', 3500),
('Mouse', '333333', 900);
INSERT INTO Channel (ChannelName)
VALUES
('Instagram'),
('Google Ads'),
('Email');
INSERT INTO Campaign (CampaignName, Budget, StartDate, EndDate)
VALUES
('Winter Sale', 100000, '2024-01-01', '2024-01-31'),
('New Year Campaign', 150000, '2024-02-01', '2024-02-15');
INSERT INTO [Order] (CustomerId, OrderDate, TotalPrice)
VALUES
(1, '2024-01-10', 25900),
(2, '2024-01-12', 3500);
INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice)
VALUES
(1, 1, 1, 25000),
(1, 3, 1, 900),
(2, 2, 1, 3500);
INSERT INTO Payment (OrderId, PaymentDate, PaymentMethod, PaymentStatus, Amount)
VALUES
(1, '2024-01-10', 'Card', 'Success', 25900),
(2, '2024-01-12', 'Card', 'Success', 3500);
INSERT INTO CampaignProduct (CampaignId, ProductId)
VALUES
(1, 1),
(1, 3),
(2, 2);
INSERT INTO CampaignChannel (CampaignId, ChannelId)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3);
INSERT INTO CampaignPerformance (CampaignId, ChannelId, SalesNumber, ClickNumber, Cost)
VALUES
(1, 1, 15, 300, 20000),
(1, 2, 10, 200, 15000),
(2, 1, 8, 180, 12000);
SELECT * FROM [Order];
SELECT * FROM OrderItem;
SELECT * FROM CampaignPerformance;


DECLARE @i INT = 1;

While @i <= 100
Begin
    Insert Into [Order] (OrderDate, TotalPrice)
    Values (
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
        ABS(CHECKSUM(NEWID())) % 500000 + 100000
    );

    Set @i += 1;
End

Select
    MONTH(OrderDate) As OrderMonth,
    COUNT(*) As OrdersCount,
    SUM(TotalPrice) As TotalSales
From [Order]
Group By MONTH(OrderDate)
Order By OrderMonth;

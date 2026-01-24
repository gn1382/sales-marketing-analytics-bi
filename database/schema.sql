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

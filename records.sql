-- SQL Script: Customer Records Database

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Addresses Table (One-to-Many: One Customer -> Many Addresses)
CREATE TABLE Addresses (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Orders Table (One-to-Many: One Customer -> Many Orders)
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    SKU VARCHAR(50) NOT NULL UNIQUE,
    Stock INT NOT NULL DEFAULT 0
);

-- Create OrderItems Table (Many-to-Many: Orders <-> Products)
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create CustomerPreferences Table (One-to-One with Customers)
CREATE TABLE CustomerPreferences (
    PreferenceID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL UNIQUE,
    PreferredLanguage VARCHAR(50),
    NewsletterSubscribed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SupportTickets Table (One-to-Many: One Customer -> Many Tickets)
CREATE TABLE SupportTickets (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    Subject VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Open',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Tags Table (Tag system for Customers - Many-to-Many)
CREATE TABLE Tags (
    TagID INT AUTO_INCREMENT PRIMARY KEY,
    TagName VARCHAR(50) NOT NULL UNIQUE
);

-- Create CustomerTags Table (Many-to-Many between Customers and Tags)
CREATE TABLE CustomerTags (
    CustomerID INT NOT NULL,
    TagID INT NOT NULL,
    PRIMARY KEY (CustomerID, TagID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);

-- Sample Data Inserts

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '555-1234'),
('Bob', 'Jones', 'bob.jones@example.com', '555-5678'),
('Carol', 'Taylor', 'carol.taylor@example.com', '555-0001'),
('David', 'Brown', 'david.brown@example.com', '555-0002'),
('Eve', 'Wilson', 'eve.wilson@example.com', '555-0003'),
('Frank', 'Moore', 'frank.moore@example.com', '555-0004'),
('Grace', 'Clark', 'grace.clark@example.com', '555-0005'),
('Hank', 'Davis', 'hank.davis@example.com', '555-0006'),
('Ivy', 'Martin', 'ivy.martin@example.com', '555-0007'),
('Jack', 'Lee', 'jack.lee@example.com', '555-0008'),
('Karen', 'Walker', 'karen.walker@example.com', '555-0009'),
('Leo', 'Hall', 'leo.hall@example.com', '555-0010'),
('Mia', 'Allen', 'mia.allen@example.com', '555-0011'),
('Nina', 'Young', 'nina.young@example.com', '555-0012'),
('Oscar', 'Hernandez', 'oscar.hernandez@example.com', '555-0013'),
('Pam', 'King', 'pam.king@example.com', '555-0014'),
('Quinn', 'Wright', 'quinn.wright@example.com', '555-0015'),
('Ray', 'Lopez', 'ray.lopez@example.com', '555-0016'),
('Sara', 'Hill', 'sara.hill@example.com', '555-0017'),
('Tom', 'Scott', 'tom.scott@example.com', '555-0018'),
('Uma', 'Green', 'uma.green@example.com', '555-0019'),
('Vince', 'Adams', 'vince.adams@example.com', '555-0020'),
('Wendy', 'Baker', 'wendy.baker@example.com', '555-0021'),
('Xander', 'Nelson', 'xander.nelson@example.com', '555-0022'),
('Yara', 'Carter', 'yara.carter@example.com', '555-0023'),
('Zack', 'Mitchell', 'zack.mitchell@example.com', '555-0024'),
('Abby', 'Perez', 'abby.perez@example.com', '555-0025'),
('Ben', 'Roberts', 'ben.roberts@example.com', '555-0026'),
('Cindy', 'Turner', 'cindy.turner@example.com', '555-0027'),
('Dan', 'Phillips', 'dan.phillips@example.com', '555-0028');

-- Addresses
INSERT INTO Addresses (CustomerID, Street, City, State, ZipCode, Country) VALUES
(1, '123 Main St', 'New York', 'NY', '10001', 'USA'),
(2, '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA'),
(3, '789 Pine Rd', 'Chicago', 'IL', '60601', 'USA');

-- Products
INSERT INTO Products (ProductName, Description, Price, SKU, Stock) VALUES
('Widget A', 'High quality widget.', 9.99, 'WIDGET-A', 100),
('Widget B', 'Economical widget.', 5.99, 'WIDGET-B', 150),
('Gadget C', 'Advanced gadget.', 19.99, 'GADGET-C', 75);

-- Orders
INSERT INTO Orders (CustomerID, TotalAmount, Status) VALUES
(1, 29.97, 'Shipped'),
(2, 19.98, 'Pending');

-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 9.99),
(1, 2, 1, 5.99),
(2, 3, 1, 19.99);

-- SupportTickets
INSERT INTO SupportTickets (CustomerID, Subject, Description, Status) VALUES
(1, 'Login Issue', 'Unable to log into my account.', 'Open'),
(2, 'Order Delay', 'Order not delivered yet.', 'Closed');


-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2021 at 04:26 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `office_algorithm`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(3) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminID`, `Email`, `UserName`, `Password`, `Status`) VALUES
(1, 'admin@aol.com', 'admin', 'admin', 'Approved'),
(2, 'admin1@aol.com', 'admin1', 'admin1', 'Approved'),
(10, 'test1@aol.com', 'test1', 'As123456', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(3) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `PayMethod` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `Email`, `UserName`, `Password`, `FirstName`, `LastName`, `PayMethod`) VALUES
(1, 'spicegirls@gmail.com', 'spice', 'spice', 'Spice', 'Girls', '0000111122223333'),
(2, 'donkey@aol.com', 'donkey', 'donkey', 'Donkey', 'Adams', '6666222255551111'),
(3, 'jarule@gmail.com', 'ja', 'ja', 'Ja', 'Rule', '0000222211113333'),
(6, 'taco@aol.com', 'taco', 'Taco123!', 'Tony', 'Burger', '1010101001010101'),
(23, 'george@aol.com', 'george', 'As123456', 'George', 'Hope', '1010292938384746');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `PurchaseID` int(3) NOT NULL,
  `CustomerID` int(3) NOT NULL,
  `Date` date NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`PurchaseID`, `CustomerID`, `Date`, `Status`) VALUES
(9, 3, '2021-03-25', 'Processing'),
(10, 1, '2021-06-15', 'Processing'),
(11, 2, '2021-08-19', 'Processing'),
(18, 6, '2021-03-19', 'Processing'),
(19, 1, '2021-06-04', 'Processing'),
(20, 2, '2021-08-19', 'Processing'),
(21, 3, '2021-01-06', 'Processing'),
(22, 6, '2021-04-01', 'Processing'),
(23, 1, '2021-08-01', 'Processing'),
(24, 6, '2021-02-17', 'Processing'),
(25, 6, '2020-12-24', 'Processing'),
(26, 3, '2021-02-27', 'Processing');

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `StockID` int(3) NOT NULL,
  `Item` varchar(30) NOT NULL,
  `Cost` varchar(10) NOT NULL,
  `Available` varchar(10) NOT NULL,
  `Ordered` varchar(10) NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`StockID`, `Item`, `Cost`, `Available`, `Ordered`, `Status`) VALUES
(1, 'Black Stapler', '10.99', '48', '0', 'Approved'),
(3, 'Hotdog Shaped Eraser', '1.99', '37', '0', 'Approved'),
(4, 'Laser Printer', '89.99', '48', '0', 'Pending'),
(5, 'Rubber Band Balls', '7.99', '39', '0', 'Pending'),
(8, 'Pink Stapler', '7.99', '200', '0', 'Pending'),
(9, 'Orange Stapler', '8.99', '39', '0', 'Pending'),
(10, 'Ink Printer', '49.99', '162', '0', 'Pending'),
(20, 'Chalk', '1.99', '678', '0', 'Pending'),
(21, 'Colorful Chalk', '4.99', '260', '0', 'Pending'),
(22, 'Poster Board', '13.99', '490', '0', 'Approved'),
(23, 'Pack of 500 Staples', '18.99', '380', '0', 'Approved'),
(24, 'Pencil Eraser Topper', '.99', '900', '0', 'Approved'),
(25, 'Eraser Brick', '4.99', '68', '0', 'Approved'),
(26, 'Chalk Bucket', '7.99', '111', '0', 'Pending'),
(27, 'Post It Notes', '4,99', '401', '0', 'Pending'),
(28, 'Rainbow Stapler', '9.99', '300', '0', 'Approved'),
(29, 'Yellow Stapler', '5.99', '211', '0', 'Approved'),
(30, '80s Printer', '199.99', '42', '0', 'Pending'),
(31, 'Black Chalk', '2.99', '321', '0', 'Pending'),
(33, 'Gaming Chair', '199.99', '200', '0', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `stockpurchase`
--

CREATE TABLE `stockpurchase` (
  `StockPurchaseID` int(3) NOT NULL,
  `StockID` int(3) NOT NULL,
  `PurchaseID` int(3) NOT NULL,
  `Quantity` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stockpurchase`
--

INSERT INTO `stockpurchase` (`StockPurchaseID`, `StockID`, `PurchaseID`, `Quantity`) VALUES
(10, 1, 9, '5'),
(12, 3, 9, '5'),
(13, 4, 9, '5'),
(25, 3, 10, '4'),
(26, 24, 10, '2'),
(27, 25, 10, '5'),
(28, 1, 11, '15'),
(29, 8, 18, '3'),
(30, 9, 18, '2'),
(31, 3, 19, '15'),
(32, 24, 19, '1'),
(33, 25, 19, '4'),
(34, 1, 19, '4'),
(35, 8, 19, '3'),
(36, 9, 19, '1'),
(37, 28, 19, '5'),
(38, 23, 19, '1'),
(39, 29, 19, '1'),
(40, 22, 19, '2'),
(41, 22, 20, '1'),
(42, 1, 20, '1'),
(43, 8, 21, '1'),
(44, 3, 22, '15'),
(45, 24, 22, '10'),
(46, 25, 22, '20'),
(47, 1, 22, '1'),
(48, 9, 23, '1'),
(49, 23, 23, '5'),
(50, 3, 24, '30'),
(51, 24, 24, '20'),
(52, 25, 24, '7'),
(53, 1, 24, '5'),
(54, 9, 25, '3'),
(55, 8, 25, '1'),
(56, 23, 26, '10'),
(57, 29, 26, '2'),
(58, 28, 26, '2'),
(59, 9, 26, '2');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `SupplierID` int(3) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`SupplierID`, `Email`, `UserName`, `Password`, `Name`, `Status`) VALUES
(1, 'joe@gmail.com', 'joe', 'joe', 'Hotdog Shaped Erasers Inc', 'Approved'),
(2, 'jane@aol.com', 'jane', 'jane', 'Staplers R US', 'Approved'),
(5, 'supplier@hotmail.com', 'supplier', 'supplier', 'Science Fair Poster Boards', 'Approved'),
(6, 'printer@hotmail.com', 'printer', 'printer', 'Subpar Printers', 'Pending'),
(7, 'junk@aol.com', 'junk', 'junk', 'Junk Drawer Emporium', 'Pending'),
(12, 'chalk@yahoo.com', 'chalk', 'Chalk123', 'Broken Pieces of Chalk', 'Pending'),
(37, 'chairs@aol.com', 'chairs', 'As123456', 'Office Chairs', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `supplierstock`
--

CREATE TABLE `supplierstock` (
  `SupplierStockID` int(3) NOT NULL,
  `SupplierID` int(3) NOT NULL,
  `StockID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplierstock`
--

INSERT INTO `supplierstock` (`SupplierStockID`, `SupplierID`, `StockID`) VALUES
(1, 1, 3),
(2, 2, 1),
(10, 6, 4),
(11, 6, 10),
(12, 7, 5),
(22, 2, 8),
(23, 2, 9),
(24, 12, 20),
(25, 12, 21),
(26, 5, 22),
(27, 2, 23),
(28, 1, 24),
(29, 1, 25),
(30, 12, 26),
(31, 7, 27),
(32, 2, 28),
(33, 2, 29),
(34, 6, 30),
(35, 12, 31),
(37, 37, 33);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`PurchaseID`),
  ADD KEY `CustomerID` (`CustomerID`) USING BTREE;

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`StockID`);

--
-- Indexes for table `stockpurchase`
--
ALTER TABLE `stockpurchase`
  ADD PRIMARY KEY (`StockPurchaseID`),
  ADD KEY `StockID` (`StockID`) USING BTREE,
  ADD KEY `PurchaseID` (`PurchaseID`) USING BTREE;

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Indexes for table `supplierstock`
--
ALTER TABLE `supplierstock`
  ADD PRIMARY KEY (`SupplierStockID`),
  ADD KEY `SupplierID` (`SupplierID`) USING BTREE,
  ADD KEY `StockID` (`StockID`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `PurchaseID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `StockID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `stockpurchase`
--
ALTER TABLE `stockpurchase`
  MODIFY `StockPurchaseID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `SupplierID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `supplierstock`
--
ALTER TABLE `supplierstock`
  MODIFY `SupplierStockID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `stockpurchase`
--
ALTER TABLE `stockpurchase`
  ADD CONSTRAINT `stockpurchase_ibfk_1` FOREIGN KEY (`PurchaseID`) REFERENCES `purchase` (`PurchaseID`),
  ADD CONSTRAINT `stockpurchase_ibfk_2` FOREIGN KEY (`StockID`) REFERENCES `stock` (`StockID`);

--
-- Constraints for table `supplierstock`
--
ALTER TABLE `supplierstock`
  ADD CONSTRAINT `supplierstock_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`),
  ADD CONSTRAINT `supplierstock_ibfk_2` FOREIGN KEY (`StockID`) REFERENCES `stock` (`StockID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE CategoryList
(
  CategoryID VARCHAR(50) NOT NULL,
  Category VARCHAR(50) NOT NULL,
  PRIMARY KEY (CategoryID)
);

CREATE TABLE Book
(
  BookID VARCHAR(50) NOT NULL,
  Title VARCHAR(50) NOT NULL,
  CategoryID VARCHAR(50) NOT NULL,
  Author VARCHAR(50) NOT NULL,
  Publisher VARCHAR(50) NOT NULL,
  Price FLOAT NOT NULL,
  Pages INT NOT NULL,
  Copies INT NOT NULL,
  BookLocation VARCHAR(50) NOT NULL,
  ImportDate DATE NOT NULL,
  PRIMARY KEY (BookID),
  FOREIGN KEY (CategoryID) REFERENCES CategoryList(CategoryID)
);

CREATE TABLE StudentCard
(
  StudentID VARCHAR(50) NOT NULL,
  StudentName VARCHAR(50) NOT NULL,
  StudentMajor VARCHAR(50) NOT NULL,
  ExpiryDate DATE NOT NULL,
  PRIMARY KEY (StudentID)
);

CREATE TABLE Student
(
  StudentID VARCHAR(50) NOT NULL,
  Phone VARCHAR(50) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  PRIMARY KEY (StudentID),
  FOREIGN KEY (StudentID) REFERENCES StudentCard(StudentID)
);

CREATE TABLE BorrowReceipt
(
  ReceiptID INT NOT NULL,
  StudentID VARCHAR(50) NOT NULL,
  StudentName VARCHAR(50) NOT NULL,
  BorrowDate DATE NOT NULL,
  ReturnDate DATE NOT NULL,
  Quantity INT NOT NULL,
  ReturnStatus BIT NOT NULL,
  PRIMARY KEY (ReceiptID),
  FOREIGN KEY (StudentID) REFERENCES StudentCard(StudentID)
);

CREATE TABLE BorrowBookList
(
  ReceiptID INT NOT NULL,
  BookID VARCHAR(50) NOT NULL,
  Title VARCHAR(50) NOT NULL,
  Publisher VARCHAR(50) NOT NULL,
  PRIMARY KEY (ReceiptID, BookID),
  FOREIGN KEY (ReceiptID) REFERENCES BorrowReceipt(ReceiptID),
  FOREIGN KEY (BookID) REFERENCES Book(BookID)
  );


INSERT INTO CategoryList(CategoryID, Category)
VALUES
('CS','Computer Science'),
('AM','Application Mathematics'),
('HM','Hospitality Management'),
('IT','Information Technology'),
('BA','Business Administration');

INSERT INTO Book(BookID, Title, CategoryID, Author, Publisher, Price, Pages, Copies, BookLocation, ImportDate)
VALUES
('B001', 'Computer Organization', 'CS', 'Phong Nguyen', 'Peason', 99.99, 501, 150, 'G-01', '2012-10-20'),
('B002', 'Discrete Mathematic', 'AM', 'Su Nguyen', 'MIT', 109.99, 233, 300, 'G-03', '2012-10-18'),
('B003', 'Caculus', 'AM', 'Su Nguyen', 'MIT', 89.99, 607, 200, 'G-03', '2012-10-18'),
('B004', 'Principle of Accounting', 'BA', 'Cuong V', 'Havard', 209.99, 1009, 100, '1-01', '2012-10-15'),
('B005', 'Bar Management', 'HM', 'Ca Ngu', 'SHL', 199.99, 334, 300, '2-01', '2012-10-20'),
('B006', 'C/C++ Fundamental', 'IT', 'James G.', 'MIT', 109.99, 233, 300, 'G-02', '2012-10-18'),
('B007', 'Java Fundamental', 'IT', 'James G.', 'MIT', 109.99, 233, 300, 'G-05', '2012-10-18'),
('B008', 'Python Fundamental', 'IT', 'James G.', 'MIT', 109.99, 233, 300, 'G-06', '2012-10-18');

INSERT INTO StudentCard(StudentID, StudentName, StudentMajor, ExpiryDate)
VALUES
('SE170001', 'Nguyen Hoai Phong', 'Software Engineering','2025-9-11'),
('SE170002', 'Nguyen Van Tu Cuong', 'Software Engineering','2025-9-11'),
('SE170003', 'Nguyen Huynh Ngoc Tram', 'International Business','2025-9-11'),
('SE170004', 'John Doe', 'Computer Science','2025-9-11'),
('SE170005', 'Su Nguyen', 'Hospitality Management','2025-9-11');

INSERT INTO Student(StudentID, Phone, Email)
VALUES
('SE170001','0123456789', 'abcxyz@gmail.com'),
('SE170002','0123456789', 'abcxyz@gmail.com'),
('SE170003','0123456789', 'abcxyz@gmail.com'),
('SE170004','0123456789', 'abcxyz@gmail.com'),
('SE170005','0123456789', 'abcxyz@gmail.com');

INSERT INTO BorrowReceipt(ReceiptID, StudentID, StudentName, BorrowDate, ReturnDate, Quantity, ReturnStatus)
VALUES
(1,'SE170001','Nguyen Hoai Phong','2017-1-20',(SELECT DATEADD(day, 7, '2017-1-20')),3,0),
(2,'SE170002','Nguyen Van Tu Cuong','2017-3-19',(SELECT DATEADD(day, 7, '2017-3-19')),1,1),
(3,'SE170003','Nguyen Huynh Ngoc Tram','2017-7-18',(SELECT DATEADD(day, 7, '2017-7-18')),2,0),
(4,'SE170004','John Doe','2017-1-10',(SELECT DATEADD(day, 7, '2017-1-10')),3,0),
(5,'SE170005','Su Nguyen','2017-1-10',(SELECT DATEADD(day, 7, '2017-1-10')),1,1);

INSERT INTO BorrowBookList(ReceiptID, BookID, Title, Publisher)
VALUES
(1, 'B001', 'Computer Organization', 'Peason'),
(1, 'B002', 'Discrete Mathematic', 'MIT'),
(1, 'B003', 'Caculus', 'MIT'),
(2, 'B003','Caculus','MIT'),
(3, 'B003', 'Caculus', 'MIT'),
(3, 'B004', 'Principle of Accounting', 'Havard'),
(4, 'B001', 'Computer Organization', 'Peason'),
(4, 'B002', 'Discrete Mathematic', 'MIT'),
(4, 'B003', 'Caculus', 'MIT'),
(5, 'B005', 'Bar Management', 'SHL');

--SELECT DISTINCT * FROM Book
--SELECT DISTINCT * FROM StudentCard
--SELECT DISTINCT * FROM Student
--SELECT DISTINCT * FROM BorrowReceipt
--SELECT DISTINCT * FROM BorrowBookList
--SELECT DISTINCT * FROM CategoryList

--Liệt kê tất cả thông tin của các đầu sách
--gồm tên sách, mã sách, giá tiền, tác giả thuộc loại sách có mã “IT”

SELECT Title, BookID, Price, Author
FROM Book
WHERE CategoryID = 'IT'

--Liệt kê các phiếu mượn
--gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã sinh viên có ngày mượn trong tháng 01/2017.

SELECT BorrowBookList.ReceiptID, BookID, CONVERT(varchar, borrowdate, 105) AS BorrowDate, StudentID
FROM BorrowBookList
INNER JOIN BorrowReceipt
ON BorrowBookList.ReceiptID = BorrowReceipt.ReceiptID
WHERE (SELECT CONVERT(varchar, borrowdate, 105)) LIKE '%01-2017%'

-- Liệt kê các phiếu mượn 
-- chưa trả sách cho thư viên theo thứ tự tăng dần của ngày mượn sách.

SELECT *
FROM BorrowReceipt
WHERE ReturnStatus = 0
ORDER BY BorrowDate ASC

-- Liệt kê tổng số đầu sách của mỗi loại sách (gồm mã loại sách, tên loại sách, tổng số lượng sách mỗi loại).

SELECT CategoryID, Category, (SELECT COUNT(Title) FROM Book WHERE CategoryID = CategoryList.CategoryID) AS NumberOfBooks
FROM CategoryList

-- Đếm xem có bao nhiêu lượt sinh viên đã mượn sách

SELECT COUNT(ReceiptID) AS BorrowReceiptCount FROM BorrowReceipt 
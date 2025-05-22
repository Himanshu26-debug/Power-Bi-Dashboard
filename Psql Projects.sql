create database Bookstore;
create table Books(
Book_ID INT PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);
select * from Books;

create table Customers(
Customer_ID INT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);

SELECT * from Customers;

create table Orders(
Order_ID INT PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

Select * from Orders;
Select * from Customers;
Select * from Books;

--List all books in Finction Genre
select * from Books where genre = 'Fiction';

--Find book published after 1950
select * from Books where published_year> 1950;

--List all customers from Canada
select * from Customers where country = 'Canada';

--List order place in November 2023
select * from Orders where order_date between '2023-10-31' and '2023-12-1';

--Show total stocks of books available
select sum(stock) from Books;

--Find Most expensive Books
select * from Books order by price desc;

--Show all customers who ordered more than 1 quantity of a book
select * from Orders where quantity >1;

--Retreive all orders where the total amount exceed 20$
select * Orders where total amount>20;

--Show all the genre book available in books table
select distinct genre from Books;

--Find the book with the lowest stock
select * from Books order by stock asc;

--calculate the total revenue generate from all orders
select * from Orders;
select sum(total_amount) from Orders;


select * from Books;
select * from Orders;

select * from Orders order by order_date desc;

--Retrieve the total number of books sold from each genre
select Books.genre, sum(orders.quantity) 
from Orders 
join Books on Books.book_id = Orders.book_id 
group by Books.genre;

--Find the average price of books in the Fantasy Genre
select avg(price) from Books where genre = 'Fantasy';

--List all the customers who have placed atleast 2 orders
select * from Orders;
select Orders.customer_id,Customers.name, count(Orders.order_id) 
from Orders join Customers on Customers.customer_id = Orders.customer_id
group by Orders.customer_id, Customers.name having count(order_id) >=2;

-- Find the most frequently ordered book;
select Book_id, count(order_id) 
from Orders 
group by Book_id 
order by count(order_id)  desc Limit 1;

--Show 3 most expensive books from fantasy genre
select * from Books
where genre = 'Fantasy' 
order by price desc;

--Show the total quantity of books sold by each author
select b.author, sum(o.quantity) from Orders o
join Books b on o.book_id = b.book_id 
group by b.author
order by sum(o.quantity) desc ;

--Show the cities where customers who spent over 30 are located
select * from Customers;
select distinct c.city , total_amount from Orders o 
join Customers c on o.customer_id = c.customer_id
where o.total_amount>30;

--Find the customer who spent the most on orders
select c.customer_id, c.name, sum(total_amount) 
from Orders o join Customers c on o.customer_id = c.customer_id
group by c.customer_id
order by sum(total_amount) desc;

--Calculate the stock remaining after fullfiling all orders
select b.book_id, b.title, b.stock, coalesce(sum(quantity),0) AS Order_quantity, 
b.stock - coalesce(sum(quantity),0) AS Remaining_Quantity
from Books b
left join Orders o on o.book_id=b.book_id
group by b.book_id;

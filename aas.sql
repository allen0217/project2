SELECT (SELECT no_of_copies FROM bookstore.books,bookstore.book_copies 
WHERE books.book_id =book_copies.book_id AND books.book_id = "0967697603"  and book_copies.branch_id = "2") - 
(SELECT COUNT(*) from bookstore.book_loans WHERE book_loans.book_id = "0967697603") 
AS Number 
from bookstore.books,bookstore.book_loans 
WHERE books.book_id = "0967697603";
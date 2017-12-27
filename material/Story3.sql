-- The first section is the most canonical SQL statement. 
SELECT customer_id, cust2.first_name, 
  category_id, cat2.name, number_purchased FROM
(
  SELECT
    cust.id AS customer_id, 
    cat.id AS category_id,
    COUNT(*) AS number_purchased
  FROM Customers Cust
    INNER JOIN Documents d ON cust.id = d.customer_id
    INNER JOIN Document_Lines dl ON d.id = dl.document_id
    INNER JOIN Products p ON dl.product_id = p.id
    INNER JOIN Composite_Ones pc ON p.id = pc.product_id
    INNER JOIN Categories cat ON pc.category_id = cat.id
  GROUP BY cust.id, cat.id
)
AS Table1
  INNER JOIN Customers cust2 ON Table1.customer_id = cust2.id
  INNER JOIN Categories cat2 ON Table1.category_id = cat2.id;



-- The second section is VALID in SQLite, the assumed database this app uses. It may be not, however, valid in some SQL, eg. SQL Server, because of the GROUP_BY clause.
-- This statement is what I will use for User Story #4.
 SELECT
    customers.id AS customer_id, 
    customers.first_name,
    categories.id AS category_id,
    categories.name,
    COUNT(*) AS number_purchased
  FROM customers
    INNER JOIN documents d ON customers.id = d.customer_id
    INNER JOIN document_lines dl ON d.id = dl.document_id
    INNER JOIN products p ON dl.product_id = p.id
    INNER JOIN composite_ones pc ON p.id = pc.product_id
    INNER JOIN categories ON pc.category_id = categories.id
  GROUP BY customers.id, categories.id;



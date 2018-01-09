# README

_Merry Christmas!_
<br/><br/>

### Set up the environment 
* Ruby version  
Ruby 2.3.1
rbenv 1.0.0
Bundler 1.16.0
gem 2.5.1

* System dependencies  
In addition to standard gems, these are needed: rspec-rails, factory-bot, shoulda-matchers, faker, database_cleaner.
See gemfile for more details.

* Database creation and initialization  
Run `rake db:setup` first. I **assume** using SQLite3 as database for Active Record (ORM)

* How to run the test suite  
Run `bundle exec rspec`. 



### Tasks
* Story 1  
Basically this is a many_to_many relationship between Product and Category. To make things clear I made an intermediate entity called CompositeOne as the cross reference between Product and Category. For future improvements, another field "Unit of Measure" may be added to Product so that an product can be sold in any amount in a more meaningful way. 

* Story 2  
A customer places orders. An order (known as Document in database) has zero or more order lines (DocumentLine) because one order may be made up of several different products. Order line is a part of an order, and one order line is where the same product bought on this order reside together. 
For example Tom's order of 10 apples and 2 steaks may be made up by 2 order lines where first is 10 apples and second is 2 steaks. (Depending on how Tom placed his order, there could also be 3 order lines: 5 apples for himself 5 apples for his mom and 2 steaks) 
I have made an ER diagram to illustrate this better. See /material/ER_Diagram.jpg for more detail.

* Story 3  
The SQL query can be found at material/Story3.sql. I **assume** all records determined by customer+category combination need to be returned.

* Story 4  
I  **assume** this is not meant to be an API endpoint or Ruby method when the brief says "part of a function in the application". To get the result of Story 3, simply run `rails console` 
and then 
`sql="SELECT customers.id AS customer_id, customers.first_name, categories.id AS category_id, categories.name, COUNT(*) AS number_purchased FROM customers INNER JOIN documents d ON customers.id = d.customer_id INNER JOIN document_lines dl ON d.id = dl.document_id INNER JOIN products p ON dl.product_id = p.id INNER JOIN composite_ones pc ON p.id = pc.product_id INNER JOIN categories ON pc.category_id = categories.id GROUP BY customers.id, categories.id";` 
and last run `records_array = ActiveRecord::Base.connection.execute(sql);`

* Story 5  
The endpoint is /products/action_2(.:format). It accepts three parameters: start (ISO date), finish (ISO date), and period. 
To test this API, first run the app on the server, `rails s`. Then interact with the app (using Postman or through another terminal of course). 
  * For example I use Httpie, I would send the following request: `http :3000/products/action_2 start=2017-11-11 finish=2017-12-26 period=week
`. Please use YYYY-MM-DD format for dates and available options for period parameter are (all lowercase) day, week, and month. 
  * If you use Postman, send this GET request `http://0.0.0.0:3000/products/action_2?start=2017-11-11&finish=2017-12-26&period=week`
  * Please note, this API uses Document's created_at date rather than placed_on date for the benefit of using transactional database. Placed_on column of Document table is currently reserved and not used. 

* Story 6  
/material/file.csv is exported when the request above is properly handled. 

* Story 7  
The endpoint is /customers/:customer_id/documents(.:format). It accepts no extra parameters except a valid customer_id.
To test this API, simply send the request with Httpie `http get :3000/customers/1/documents` or with Postman `http://0.0.0.0:3000/customers/1/documents` (1 is a customer id). 
For visual simplicity, I did not include any order details (document lines) in the result. If this is desired, it can be easily improved. 

### Additional tasks
	•	We want to give customers the ability to create lists of products for one-click ordering of bulk items. How would you design the tables, what are the pros and cons of your approach?
    
Answer: If I understand it correctly, this is to permit customers to place recurring orders over some time (for example every month). In this case, I would just created another Document record with status field being "recurring". This Document record would have the same information (document lines) as other documents. For example one such document can have 2 lines: 1 cat litter and 3 CDs. "Recurring" and only "recurring" documents would be available on the page for customers to choose from (one-click ordering).
* Pros: Simple solution on the backend without adding more entities. Customers can order "recurring" orders whenever they want, rather than on a fixed monthly schedule. 
* Cons: Flexibility may be compromised. Take a "recurring" document of 100 apples and 2 boxes of cat litter for example, a customer ususlly places such an order every month. Then suddenly they welcome a guest cat from their friends. They want one more box of cat litter and the same amount of apples. This "recurring" order approach does not give them the freedom to change quantity of one item while keeping others. 

	
	•	If Shipt knew exact inventory of stores, and when facing a high traffic and limited supply of particular item, how do you distribute the inventory among customers checking out?
Answer: I am not entire sure what is this high traffic about. Is it high demand of particular items, or high web request traffic, or high vehicular traffic for our Shipt shoppers? I'll answer the question **assuming** it means high demand of particular item.   
The primary strategy is first come first serve. Whoever places orders containing this particular item will get their orders fulfilled first. When orders are placed at the same time, there are some secondary strategies, including shorter distance (between stores and customers who need this item) over longer distance, or prime/senior customers over new customers, or orders with fewer back-ordered items taking the priority. In short, the goal is to utilize the inventory to the most extent and disappoint fewer customers. Those less fortunate customers may be awarded a voucher or coupon for future if they'd like.   

_Again, thanks for reviewing the project and happy holidays!_


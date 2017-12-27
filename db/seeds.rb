# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customers = Customer.create([{first_name: 'sherlock', last_name: 'holmes'}, {first_name: 'tom', last_name: 'cruise'}, {first_name: 'lucas', last_name: 'yang'}])
products = Product.create([{name: 'product1'}, {name: 'sku015'}, {name: 'bag'}, {name: 'product2'}, {name: 'water'}, {name: 'lumber'}, {name: 'helium'}, {name: 'rice'}, {name: 'egg'}, {name: 'ski pass'}])
categories = Category.create([{name: 'food'}, {name: 'gas'}, {name: 'liquid'}, {name: 'solid'}, {name: 'virtual'}])
composite_ones1 = CompositeOne.create([{product_id: 5, category_id: 3}, {product_id: 6, category_id: 4}, {product_id: 7, category_id: 2}])
composite_ones2 = CompositeOne.create([{product_id: 8, category_id: 1}, {product_id: 8, category_id: 4}, {product_id: 9, category_id: 1}])
composite_ones3 = CompositeOne.create([{product_id: 9, category_id: 3}, {product_id: 9, category_id: 4}, {product_id: 10, category_id: 5}])

# status can be awaiting (for delivery), on its way, or delivered
document1 = Document.create({status: 'awaiting', customer_id: 1, placed_on: Time.now - (60 * 60 * 24 * 4)}) # 4 days ago
document2 = Document.create({status: 'delivered', customer_id: 3, placed_on: Time.now})
document3 = Document.create({status: 'delivered', customer_id: 3, placed_on: Time.now})
document4 = Document.create({status: 'on its way', customer_id: 2, placed_on: Time.now})
document4 = Document.create({status: 'delivered', customer_id: 3, placed_on: Time.now})

d_l1 = DocumentLine.create({qty: 10, document_id: 1, product_id: 5})
d_l2 = DocumentLine.create({qty: 11, document_id: 1, product_id: 6})
d_l3 = DocumentLine.create({qty: 12, document_id: 1, product_id: 7})
d_l4 = DocumentLine.create({qty: 13, document_id: 2, product_id: 5})
d_l5 = DocumentLine.create({qty: 14, document_id: 2, product_id: 6})
d_l6 = DocumentLine.create({qty: 15, document_id: 3, product_id: 7})
d_l7 = DocumentLine.create({qty: 18, document_id: 1, product_id: 8})
d_l8 = DocumentLine.create({qty: 3, document_id: 4, product_id: 10})
d_l9 = DocumentLine.create({qty: 2, document_id: 5, product_id: 10})

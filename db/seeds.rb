User.find_or_create_by(email: 'admin@admin.com') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
  user.role = 'admin'
end
puts 'Admin created: admin@admin.com / 123456'

categories = [ 'Electronics', 'Peripherals', 'Audio', 'Mobile' ]
categories.each do |name|
  Category.find_or_create_by(name: name)
end
puts "Categories created: #{Category.count}"

products = [
  { name: 'Notebook Pro X1', price: 4500.00, stock: 15, category: 'Electronics' },
  { name: 'Mechanical Keyboard', price: 350.00, stock: 30, category: 'Peripherals' },
  { name: 'Wireless Mouse', price: 180.00, stock: 50, category: 'Peripherals' },
  { name: 'Monitor 4K 27in', price: 2800.00, stock: 10, category: 'Electronics' },
  { name: 'Headset Pro', price: 450.00, stock: 25, category: 'Audio' },
  { name: 'Smartphone Ultra', price: 3200.00, stock: 20, category: 'Mobile' },
  { name: 'Wireless Earbuds', price: 280.00, stock: 40, category: 'Audio' },
  { name: 'USB-C Hub', price: 150.00, stock: 60, category: 'Peripherals' }
]

products.each do |p|
  category = Category.find_by(name: p[:category])
  puts "Creating #{p[:name]} in category #{category&.name}"
  product = Product.find_or_create_by(name: p[:name]) do |prod|
    prod.price = p[:price]
    prod.stock = p[:stock]
    prod.category = category
  end
  puts "Errors: #{product.errors.full_messages}" if product.errors.any?
end
puts "Products created: #{Product.count}"

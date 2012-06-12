
class Item
	def initialize(name, price)
		@name = name
		@price = price
	end

	def name
		return @name
	end

	def price
		return @price
	end

	def name=(new_name)
		@name = new_name
	end
	def price=(new_price)
		@price = new_price
	end
	def sales_tax
		puts @name
	end

	def import_duty
		
	end
end

class Basket
	

	def initialize
		@shopping_basket = Array.new
		@exempt = ["pills","book","chocolate", "chips"]
	end

	def shopping_basket
		return @shopping_basket		
	end

	def add(item, quantity)
		item_hash = Hash.new
		item_hash[:item] = item
		item_hash[:quantity] = quantity
		@shopping_basket << item_hash
	end

	def sales_tax(name)
		
		sales_tax_rate = 0.1
		singularized_array = Array.new
		name_array = name.downcase.split(" ")

		name_array.each do |word|
			singularized_array << word.chomp("s")
		end

		@exempt.each do |word|
		
			if singularized_array.include?(word) || name_array.include?(word)
				sales_tax_rate = 0
			end
		end
		return sales_tax_rate
	end

	def import_duty(name)
		import_duty = 0

		import_duty_name_array = name.downcase.split(" ")
			if import_duty_name_array.include?("imported")
				import_duty = 0.05
			end
			return import_duty
	end
	
	def receipt
		itemized_receipt_array = []		
		sales_tax_rate = 0
		import_duty = 0
		sales_tax_total = 0		
		receipt_total = 0

		@shopping_basket.each do |item_hash|
	
			item = item_hash[:item]
			quantity = item_hash[:quantity]
			name = item.name
			price = item.price

			sales_tax_rate = sales_tax(name)			
			import_duty = import_duty(name)
			item_sales_tax = ((((sales_tax_rate + import_duty) * price)*20).ceil/20.0) * quantity

			sales_tax_total = sales_tax_total + (item_sales_tax).round(2)

			itemized_receipt_array << "#{quantity} #{name} #{(price * quantity + (item_sales_tax)).round(2)}"
			receipt_total = receipt_total + (price * quantity + (item_sales_tax)).round(2)
		end

		return itemized_receipt_array, "Sales Taxes #{sales_tax_total.round(2)}", "Total #{receipt_total.round(2)}"
	end
end


#______________________ INPUTS ______________________________

# Input 1:
# 1 book at 12.49
# 1 music CD at 14.99
# 1 chocolate bar at 0.85

book = Item.new("book", 12.49)
music = Item.new("music", 14.99)
chocolate = Item.new("chocolate bar", 0.85)

shopping_basket = Basket.new

shopping_basket.add(book, 1)
shopping_basket.add(music, 1)
shopping_basket.add(chocolate, 1)

puts "Output 1:"
puts shopping_basket.receipt

# Input 2:
# 1 imported box of chocolates at 10.00
# 1 imported bottle of perfume at 47.50

imported_chocolates = Item.new("imported box of chocolates", 10.00)
imported_perfume = Item.new("imported bottle of perfume", 47.50)

shopping_basket = Basket.new

shopping_basket.add(imported_chocolates, 1)
shopping_basket.add(imported_perfume, 1)

puts "Output 2:"
puts shopping_basket.receipt

 
# Input 3:
# 1 imported bottle of perfume at 27.99
# 1 bottle of perfume at 18.99
# 1 packet of headache pills at 9.75
# 1 box of imported chocolates at 11.25

imported_perfume = Item.new("imported bottle of perfume", 27.99)
perfume = Item.new("bottle of perfume", 18.99)
headache_pills = Item.new("packet of headache pills", 9.75)
imported_chocolates = Item.new("box of imported chocolates", 11.25)

shopping_basket = Basket.new

shopping_basket.add(imported_perfume, 1)
shopping_basket.add(perfume, 1)
shopping_basket.add(headache_pills, 1)
shopping_basket.add(imported_chocolates, 1)

puts "Output 3:"
puts shopping_basket.receipt
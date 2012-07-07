
class Item
	attr_accessor :name, :price, :quantity, :imported

	def initialize(name, price, quantity, exempt = nil, imported = nil)
		@name = name
		@price = price
		@quantity = quantity		
		@imported = imported.nil? ? false : true
		@exempt = exempt.nil? ? false : true
	end	
	def is_imported?
		@imported
	end
	def is_exempt?
		@exempt
	end
end

class Basket
	attr_reader :shopping_basket

	def initialize
		@shopping_basket = Array.new
		@exempt = ["pills","book","chocolate", "chips"]
	end

	def add(item)
		item_hash = Hash.new
		item_hash[:item] = item
		@shopping_basket << item_hash
	end
	def sales_tax(item)
		item.is_exempt? ? 0 : 0.10
	end
	

	def import_duty(item)
		item.is_imported? ? 0.05 : 0
	end
	
	def receipt
		itemized_receipt_array = []		
		sales_tax_rate = 0
		import_duty = 0
		sales_tax_total = 0		
		receipt_total = 0

		@shopping_basket.each do |item_hash|
	
			item = item_hash[:item]
			quantity = item.quantity
			name = item.name
			price = item.price

			sales_tax_rate = sales_tax(item)			
			import_duty = import_duty(item)
			surcharges = ((((sales_tax_rate + import_duty) * price)*20).ceil/20.0) * quantity

			sales_tax_total = sales_tax_total + (surcharges).round(2)

			itemized_receipt_array << "#{quantity} #{name} #{(price * quantity + (surcharges)).round(2)}"
			receipt_total = receipt_total + (price * quantity + (surcharges)).round(2)
		end

		return itemized_receipt_array, "Sales Taxes #{sales_tax_total.round(2)}", "Total #{receipt_total.round(2)}"
	end
end


#______________________ INPUTS ______________________________

# Input 1:
# 1 book at 12.49
# 1 music CD at 14.99
# 1 chocolate bar at 0.85
book = Item.new("book", 12.49, 1, "exempt")
music = Item.new("music", 14.99, 1)
chocolate = Item.new("chocolate bar", 0.85, 1, "exempt")

shopping_basket = Basket.new

shopping_basket.add(book)
shopping_basket.add(music)
shopping_basket.add(chocolate)

puts "Output 1:"
puts shopping_basket.receipt

# Input 2:
# 1 imported box of chocolates at 10.00
# 1 imported bottle of perfume at 47.50

imported_chocolates = Item.new("box of chocolates", 10.00, 1,"exempt", "imported" )
imported_perfume = Item.new("bottle of perfume", 47.50, 1,nil, "imported")

shopping_basket = Basket.new

shopping_basket.add(imported_chocolates)
shopping_basket.add(imported_perfume)

puts "Output 2:"
puts shopping_basket.receipt

 
# Input 3:
# 1 imported bottle of perfume at 27.99
# 1 bottle of perfume at 18.99
# 1 packet of headache pills at 9.75
# 1 box of imported chocolates at 11.25

imported_perfume = Item.new("bottle of perfume", 27.99, 1,nil, "imported")
perfume = Item.new("bottle of perfume", 18.99, 1)
headache_pills = Item.new("packet of headache pills", 9.75, 1,"exempt")
imported_chocolates = Item.new("box of chocolates", 11.25, 1,"exempt","imported")

shopping_basket = Basket.new

shopping_basket.add(imported_perfume)
shopping_basket.add(perfume)
shopping_basket.add(headache_pills)
shopping_basket.add(imported_chocolates)

puts "Output 3:"
puts shopping_basket.receipt
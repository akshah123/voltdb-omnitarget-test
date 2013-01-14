require 'voltrb'

def get_random_string(size=26)
	o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
	puts o
	return (0...size).map{ o[rand(o.length)] }.join
end

def get_random_click_data()
  transaction_id  =  (0...26).map{ o[rand(o.length)] }.join
  cost = rand(50)
  revenue = rand(50)
  is_valid = [true,false].sample
  is_dynamic_revenue = [true,false].sample
  return [transaction_id, cost, revenue, is_valid, is_dynamic_revenue]
end
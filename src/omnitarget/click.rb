require 'voltrb'

$o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten

def get_random_string(size=26, random_length = true)
	if(random_length)
		size = rand(1..size)
	end
	result = (0...size).map{ $o[rand($o.length)] }.join
	
	result
end

def time(step = "")
  start = Time.now
  yield
  exec_time = Time.now - start
  puts step + " took " +  exec_time.to_s + " seconds"
  exec_time
end

def get_random_click()
  transaction_id  =  get_random_string(50,false)
  click_date  = Time.now
  click_date_interval = click_date
  related_click = ""
  is_unique = [true,false].sample
  offer_id = rand(1..1500)
  aff_id = rand(1..1500)
  aff_id_new_old = rand(1..1500)
  aff_id_new = rand(1..1500)
  url_id = rand(1..1500)
  finance_rule_id = rand(1..2000)
  ad_id = rand(1..1500)
  campaign_id = rand(1..2000)
  creative_id = rand(1..1500)
  placement_id = rand(1..1500)
  dma = rand(1..1500)
  city = get_random_string(30)
  state = get_random_string(15)
  zip = get_random_string(10)
  country = get_random_string(15)
  latitude = rand(90)
  longitude = rand(90)
  image = get_random_string(10)
  text  = get_random_string(10)
  dynamic_location_text = get_random_string(10)
  callout = get_random_string(10)
  callout_text  = get_random_string(10)
  animation  = get_random_string(10)
  time_of_day= rand(0..23)
  source  = get_random_string(15)
  sub1  = get_random_string(15)
  sub2 = get_random_string(15)
  sub3  = get_random_string(15)
  sub4  = get_random_string(15)
  sub5  = get_random_string(15)
  params  = get_random_string(15)
  impression_cost  = rand(2)
  cost = rand(50)
  revenue = rand(100)
  referrer = get_random_string(255)
  browser  = get_random_string(250)
  os  = get_random_string(15)
  ip = "192.168.31.138"
  return [transaction_id, click_date, click_date_interval, related_click, is_unique, offer_id, aff_id, aff_id_new_old, aff_id_new, url_id, finance_rule_id, ad_id, campaign_id, creative_id, placement_id, dma, city, state, zip, country, latitude, longitude, image, text, dynamic_location_text, callout, callout_text, animation, time_of_day, source, sub1, sub2, sub3, sub4, sub5, params, impression_cost, cost, revenue, referrer, browser, os, ip]
end

def insert_click(client, click)
	puts click
	begin
		client.call_procedure("CLICK.insert", *click)
	rescue VoltRb::VoltError => bang
		puts "Error: #{bang.status_string}"
	rescue Exception => e
		puts e
	end

end

client = VoltRb::Client.new

response = client.call_procedure("@ExplainProc", "CLICK.insert")
response.results[0].each { |row| puts row }

time("Insert data") do
	1.times do 
		insert_click(client, get_random_click())
	end
end

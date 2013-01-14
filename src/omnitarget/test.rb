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
  offer_id = rand(1..1500)
  return [transaction_id, offer_id]
end

def insert_click(client, click)
	puts click
	begin
		client.call_procedure("TEST.insert", click[0], click[1])
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

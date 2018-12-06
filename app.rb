require 'sinatra'

get '/' do
	erb :home
end

post '/home' do
	delivery = params[:delivery]
	redirect '/pizza?delivery=' + delivery
end


get '/pizza' do
	pizzalist = params[:pizzalist]
	delivery = params[:delivery]
	erb :pizza, locals: {delivery: delivery, pizzalist: pizzalist}
end


post '/pizza' do
delivery = params[:delivery]
another = params[:another]
address = params[:address]
size = params[:size]
crust = params[:crust]
	if params[:meats] != nil
			meats = params[:meats]
	end
	if params[:veggies] != nil
			veggies = params[:veggies]
	end
	if params[:extras] != nil
		extras = params[:extra]
	end
pizza = params[:pizzalist]
pizzalist = []
pizzalist << size
pizzalist << crust
pizzalist << meats
pizzalist << veggies
pizzalist << pizza

	if another == "yes"
		redirect '/pizza?pizzalist=' + pizzalist.join(',') + '&delivery=' + delivery = '&address=' + address
	else
		redirect '/summary?delivery=' + delivery + '&address=' + address + '&pizzalist=' + pizzalist.join(",")
	end
end

get '/summary' do
	pizzalist = params[:pizzalist].split(',')
	delivery = params[:delivery]
	address = params[:address]
	price = 0.00
	pizzalist.each do |item|
		if item == "small"
			price += 5.00
		end
		if item == "medium"
			price += 7.00
		end
		if item == "large"
			price += 10.00
		end
	end
	puts price
	erb :summary, locals: {pizzalist: pizzalist, delivery: delivery, address: address, price: price}
end

post '/summary' do
	address = params[:address]
	newpizza = []
	toppings = params
	toppings.each do |key, value|
		if value == "yes"
			newpizza << key
		end
	end
	redirect '/final?&newpizza=' + newpizza.join(',') + '&address=' + address
end

get '/final' do
	newpizza = params[:newpizza].split(',')
	address = params[:address]
	erb :final, locals: {newpizza: newpizza, address: address}
end

require 'sinatra'

get '/' do
	erb :pizza
end

get '/pizza' do
	pizzalist = params[:pizzalist]
	erb :pizza, locals: {pizzalist: pizzalist}
end

post '/pizza' do
another = params[:another]
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
		redirect '/pizza?pizzalist=' + pizzalist.join(',')
	else
		redirect '/summary?pizzalist=' + pizzalist.join(",")
	end
end

get '/summary' do
	pizzalist = params[:pizzalist].split(',')
	erb :summary, locals: {pizzalist: pizzalist}
end

post '/summary' do
	delivery = params[:delivery]
	toppings = params
	pizza = []
	toppings.each do |key, value|
		if value == "yes"
			pizza << key.tr("0-9", "")
		end
	end
	redirect '/confirm?delivery=' + delivery + '&pizza=' + pizza.join(",")
end

get '/confirm' do
	delivery = params[:delivery]
	pizza = params[:pizza].split(",")
		price = 0.00
		price += pizza.count("small") * 6.00
		price += pizza.count("medium") * 8.00
		price += pizza.count("large") * 10.00
		price += pizza.count("thin") * 0.50
		price += pizza.count("stuffed") * 1.50
		price += pizza.count("pepperoni") * 0.50
		price += pizza.count("ham") * 0.50
		price += pizza.count("bacon") * 0.50
		price += pizza.count("sausage") * 0.50
		price += pizza.count("mushrooms") * 0.50
		price += pizza.count("peppers") * 0.50
		price += pizza.count("pineapple") * 0.50
	erb :confirm, locals: {delivery: delivery, price: price, pizza: pizza}
end

post '/confirm' do
	delivery = params[:delivery]
	address = params[:address]
	price = params[:price]
	pizza = params[:pizza]
redirect '/final?delivery=' + delivery + '&address=' + address + '&price=' + price + '&pizza=' + pizza
end

get '/final' do
	pizza = params[:pizza].split(",")
	delivery = params[:delivery]
	address = params[:address]
	price = params[:price].to_i
	if delivery == "delivery"
		price += 10.00
	end
	erb :final, locals: {delivery: delivery, address: address, price: price, pizza: pizza}
end

require 'sinatra'

get '/' do
	erb :home
end

post '/home'

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
	newpizza = []
	toppings = params
	toppings.each do |key, value|
		if value == "yes"
			newpizza << key
		end
	end
	pizzas = []
		newpizza.each do |item|
			pizzas << item.tr("0-9", "")
		end
	redirect '/confirm?newpizza=' + newpizza.join(',') + '&delivery=' + delivery + '&pizzas=' + pizzas.join(',')
end

get '/confirm' do
	delivery = params[:delivery]
	pizzas = params[:pizzas].split(',')

		price = 0.00
		price += pizzas.count("small") * 6.00
		price += pizzas.count("medium") * 8.00
		price += pizzas.count("large") * 10.00
		price += pizzas.count("thin") * 0.50
		price += pizzas.count("stuffed") * 1.50
		price += pizzas.count("pepperoni") * 0.50
		price += pizzas.count("ham") * 0.50
		price += pizzas.count("bacon") * 0.50
		price += pizzas.count("sausage") * 0.50
		price += pizzas.count("mushrooms") * 0.50
		price += pizzas.count("peppers") * 0.50
		price += pizzas.count("pineapple") * 0.50
	erb :confirm, locals: {delivery: delivery, price: price, pizzas: pizzas}
end

post '/confirm' do
delivery = params[:delivery]
address = params[:address]
redirect '/final?delivery=' + delivery + '&address=' + address
end

get '/final' do
	delivery = params[:delivery]
	address = params[:address]
	price = params[:price].to_i
	if delivery == "yes"
		price += 10
	end
	erb :final, locals: {delivery: delivery, address: address, price: price}
end

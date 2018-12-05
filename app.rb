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

	erb :summary, locals: {pizzalist: pizzalist, delivery: delivery, address: address}
end

post '/summary' do
	newpizza = []
	toppings = params
	p "toppings #{toppings}"
	toppings.each do |key, value|
		if toppings.value?('yes')
			newpizza << key
		end
	end
	redirect '/final?&newpizza=' + newpizza.join(',')
end

get '/final' do
	newpizza = params[:newpizza].split(',')

	erb :final, locals: {newpizza: newpizza}
end

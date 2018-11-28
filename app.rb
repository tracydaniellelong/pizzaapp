require 'sinatra'

get '/' do
	erb :home
end

post '/home' do
	delivery = params[:delivery]
	redirect '/pizza?delivery=' + delivery
end

get '/pizza' do
	delivery = params[:delivery]
	erb :pizza, locals:{delivery: delivery}
end

post '/pizza' do
	size = params[:size]
	crust = params[:crust]
	cheese = params[:cheese]
	sauce = params[:sauce]
	if params[:meats]
		meats = params[:meats].join(',')
	else
		meats = "no"
	end
	if params[:veggies]
		veggies = params[:veggies].join(',')
	else
		veggies = "no"
	end
	if params[:extra]
		extra = params[:extra].join(',')
	else
		extra = "no"
	end
	delivery = params[:delivery]
	address = params[:address]
	redirect '/summary?size=' + size + '&crust=' + crust + '&cheese=' + cheese + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&extra=' + extra + '&delivery=' + delivery + '&address=' + address
end

get '/summary' do
	price = 0.00
	size = params[:size]
		if size == 'small'
			price += 5.00
		elsif size == 'medium'
			price += 6.00
		elsif size == 'large'
			price += 7.00
		end
	crust = params[:crust]
		if crust == 'thin'
			price += 0.50
		elsif crust == 'regular'
			price += 0.75
		elsif crust == 'stuffed'
			price += 1.00
		end
	cheese = params[:cheese]
		if cheese == 'regular' || cheese == 'none'
			price += 0.00
		else
			price += 0.50
		end
	sauce = params[:sauce]
		if sauce == 'pizza sauce'
			price += 0.25
		elsif sauce == 'ranch'
			price += 0.30
		elsif sauce == 'no sauce'
			price += 0.00
		else
			price += 0.50
		end
		if params[:meats] != ["no"]
			meats = params[:meats].split(',')
			price += (meats.count * 0.25)
		end
		if params[:veggies] != ["no"]
			veggies = params[:veggies].split(',')
			price += (veggies.count * 0.25)
		end
		if params[:extra] != ["no"]
			extra = params[:extra].split(',')
			price += (extra.count * 0.25)
		end
	delivery = params[:delivery]
		if delivery == "yes"
			price += 10.00
		end
	address = params[:address]
	erb :summary, locals:{size: size, crust: crust, cheese: cheese, sauce: sauce, meats: meats, veggies: veggies, extra: extra, price: price.to_f, delivery: delivery, address: address}
end


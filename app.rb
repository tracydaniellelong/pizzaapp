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
	meats = params[:meats].join(',') if params[:meats]
	meats = "none" if !params[:meats]
	veggies = params[:veggies].join(',') if params[:veggies]
	veggies = "none" if !params[:meats]
	extra = params[:extra].join(',') if params[:extra]
	extra = "none" if !params[:extra]
	delivery = params[:delivery]
	address = params[:address] if params[:address]
	address = "" if !params[:address]
	redirect '/summary?size=' + size + '&crust=' + crust + '&meats=' + meats + '&veggies=' + veggies + '&extra=' + extra + '&delivery=' + delivery + '&address=' + address
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
	meats = params[:meats] if params[:meats]
	meats = "none" if !params[:meats]
		if meats.length >= 1
			price += (meats.length * 0.50)
		end
	veggies = params[:veggies] if params[:veggies]
	veggies = "none" if !params[:veggies]
		if veggies.length >= 1 
			price += (veggies.length * 0.50)
		end
	extra = params[:extra] if params[:extra]
	extra = "none" if !params[:extra]
		if extra.length >= 1
			price += (extra.length * 0.50)
		end
	delivery = params[:delivery]
		if delivery == "yes"
			price += 10.00
		end
	address = params[:address]
	erb :summary, locals:{size: size, crust: crust, meats: meats, veggies: veggies, extra: extra, price: price, delivery: delivery, address: address}
end


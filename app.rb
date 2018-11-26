require 'sinatra'

get '/' do
	erb :home
end

post '/home' do
	quantity = params[:quantity].to_s
	delivery = params[:delivery]
	redirect '/pizza?quantity=' + quantity + '&delivery=' + delivery
end

get '/pizza' do
	quantity = params[:quantity]
	delivery = params[:delivery]
	erb :pizza, locals:{delivery: delivery, quantity: quantity}
end

post '/pizza' do
	size = params[:size]
	crust = params[:crust]
	meats = params[:meats].join(',')
	veggies = params[:veggies].join(',')
	extra = params[:extra].join(',')
	quantity = params[:quantity].to_s
	delivery = params[:delivery]
	redirect '/summary?size=' + size + '&crust=' + crust + '&meats=' + meats + '&veggies=' + veggies + '&extra=' + extra
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
		else
			redirect '/'
		end
	meats = params[:meats]
	veggies = params[:veggies]
	extra = params[:extra]
	delivery = params[:delivery]
	quantity = params[:quantity]
	erb :summary, locals:{size: size, crust: crust, meats: meats, veggies: veggies, extra: extra, price: price, delivery: delivery}
end


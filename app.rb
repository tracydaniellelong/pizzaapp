require 'sinatra'

get '/' do
	erb :home
end

post '/home' do
	size = params[:size]
	crust = params[:crust]
	meats = params[:meats].join(',')
	veggies = params[:veggies].join(',')
	extra = params[:extra].join(',')
	redirect '/pizza?size=' + size + '&crust=' + crust + '&meats=' + meats + '&veggies=' + veggies + '&extra=' + extra
end

get '/pizza' do
	size = params[:size]
	crust = params[:crust]
	meats = params[:meats].split(',')
	veggies = params[:veggies].split(',')
	extra = params[:extra].split(',')
	erb :pizza
end

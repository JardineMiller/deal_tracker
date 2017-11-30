require('sinatra')
require('sinatra/reloader')
require('date')

get '/admin' do
  erb (:"/admin/index")
end

get '/admin/login' do
  erb (:"admin/login")
end



get '/admin/burgers' do   #BURGER - INDEX
  @burgers = Burger.all
  erb (:"/admin/burgers/index")
end

get '/admin/burgers/new' do #BURGER - NEW
  @restaurants = Restaurant.all
  @burgers = Burger.all_types
  erb (:"/admin/burgers/new")
end

post '/admin/burgers' do #BURGER - CREATE
  @burger = Burger.new(params)
  @burger.save
  redirect to '/admin/burgers'
end

get '/admin/burgers/:id/edit' do #BURGER - EDIT
  @burger = Burger.find(params[:id])
  @burgers = Burger.all_types
  @restaurants = Restaurant.all
  erb (:"/admin/burgers/edit")
end

put '/admin/burgers/:id' do #BURGER - UPDATE
  Burger.new(params).update
  redirect to '/admin/burgers'
end

delete '/admin/burgers/:id' do #BURGER - DELETE
  burger = Burger.find(params[:id])
  burger.delete
  redirect to '/admin/burgers'
end



get '/admin/restaurants' do #RESTAURANT - INDEX
  @restaurants = Restaurant.all
  erb (:"/admin/restaurants/index")
end

get '/admin/restaurants/new' do #RESTAURANT - NEW
  erb (:"/admin/restaurants/new")
end

post '/admin/restaurants' do #RESTAURANT - CREATE
  @restaurant = Restaurant.new(params)
  @restaurant.save
  redirect to '/admin/restaurants'
end

get '/admin/restaurants/:id/edit' do #RESTAURANT - EDIT
  @restaurant = Restaurant.find(params[:id])
  erb (:"/admin/restaurants/edit")
end

put '/admin/restaurants/:id' do #RESTAURANT - UPDATE
  Restaurant.new(params).update
  redirect to '/admin/restaurants'
end

delete '/admin/restaurants/:id' do #RESTAURANT - DELETE
  restaurant = Restaurant.find(params[:id])
  restaurant.delete
  redirect to '/admin/restaurants'
end



get '/admin/deals' do #DEALS - INDEX
  @deals = Deal.distinct_all
  erb (:"/admin/deals/index")
end

get '/admin/deals/new' do #DEALS - NEW
  @discounts = Discount.all
  @burgers = Burger.all
  erb (:"/admin/deals/new")
end

post '/admin/deals' do #DEALS - CREATE
  @deal = Deal.new(params)
  @deal.save
  redirect to '/admin/deals'
end

get '/admin/deals/:id/edit' do #DEALS - EDIT
  @deal = Deal.find(params[:id])
  @deals = Deal.distinct_all
  @discounts = Discount.all
  @burgers = Burger.all
  @days = Deal.days
  erb (:"/admin/deals/edit")
end

put '/admin/deals/:id' do #RESTAURANT - UPDATE
  Deal.new(params).update
  redirect to '/admin/deals'
end

delete '/admin/deals/:id' do #RESTAURANT - DELETE
  deal = Deal.find(params[:id])
  deal.delete_deal
  redirect to '/admin/deals'
end



get '/admin/discounts' do #DISCOUNTS - INDEX
  @discounts = Discount.all
  erb (:"/admin/discounts/index")
end

get '/admin/discounts/new' do #DISCOUNTS - NEW
  @discounts = Discount.types
  erb (:"/admin/discounts/new")
end

post '/admin/discounts' do #DISCOUNTS - CREATE
  @discount = Discount.new(params)
  @discount.save
  redirect to '/admin/discounts'
end

get '/admin/discounts/:id/edit' do #DISCOUNTS - EDIT
  @discount = Discount.find(params[:id])
  erb (:"/admin/discounts/edit")
end

put '/admin/discounts/:id' do #DISCOUNTS - UPDATE
  Discount.new(params).update
  redirect to '/admin/discounts'
end

delete '/admin/discounts/:id' do #DISCOUNTS - DELETE
  discount = Discount.find(params[:id])
  discount.delete
  redirect to '/admin/discounts'
end


require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

# This is the Index route.  The /pizzas will send it to a place in the browser.
get '/pizzas' do
# This gives us all the pizzas; we create a variable that we can make available in the view file.
# We have to now put the @pizzas into the index.erb view
  @pizzas = Pizza.all()
# This will render to an HTML file.  We'll create it next.
  erb(:index)
end

# NEW DATA/ORDER
# Here, we just want to create a new page.  Don't need to get data, just return a form.
# THIS Has to be above the next one, because otherwise every request will look at :id and just stop there without traveling down.
get '/pizzas/new' do
  erb(:new)
end

# This is how we show what pizzas there are
get '/pizzas/:id' do
  @pizza = Pizza.find(params[:id])
  erb(:show)
end

# create route for new pizzas; posts to our database
post '/pizzas' do
  @pizza = Pizza.new(params)
  @pizza.save()
  erb(:create)

end

# Delete
post '/pizzas/:id/delete' do
  @pizza = Pizza.find(params[:id])
  @pizza.delete()
  redirect to('/pizzas')
end

# Edit - will look similar to new
get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  @pizza.delete()
  @pizza.update()
  # @pizza.save()
  erb(:edit)
end


# Update - similar to create

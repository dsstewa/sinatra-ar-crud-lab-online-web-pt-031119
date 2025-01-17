
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do #homepage
    redirect to "/articles"
  end
   
  
get "/articles" do #index
  @articles = Article.all
  erb :index
end

get '/articles/new' do #new article
  @article = Article.new
  erb :new
end

post '/articles' do #create
  @article = Article.create(title: params[:title], content: params[:content])
  redirect "/articles/#{@article.id}"

end

get "/articles/:id" do #show
  #binding.pry
  @article = Article.find_by_id(params[:id])
  #binding.pry
  erb :show
end

get '/articles/:id/edit' do
   @article = Article.find(params[:id])
   erb :edit
end

patch "/articles/:id"  do #update

  @article = Article.find(params[:id])
  @article.update(params[:article])
  redirect to "/articles/#{article.id}"
end

delete "/articles/:id" do #delete
  Article.destroy(params[:id])
 redirect to "/articles"
end

end

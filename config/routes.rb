Rails.application.routes.draw do
  # Routes for the Poem resource:

  # CREATE
  post("/insert_poem", { :controller => "poems", :action => "create" })
          
  # READ
  get("/", { :controller => "poems", :action => "index" })
  get("/poems", { :controller => "poems", :action => "index" })
  
  get("/poems/:path_id", { :controller => "poems", :action => "show" })
  
  # UPDATE
  
  post("/modify_poem/:path_id", { :controller => "poems", :action => "update" })
  
  # DELETE
  get("/delete_poem/:path_id", { :controller => "poems", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

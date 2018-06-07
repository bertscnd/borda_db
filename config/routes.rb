Rails.application.routes.draw do
  # Routes for the Survey resource:
  # CREATE
  get "/surveys/new", :controller => "surveys", :action => "new"
  post "/create_survey", :controller => "surveys", :action => "create"

  # READ
  get "/surveys", :controller => "surveys", :action => "index"
  get "/surveys/:id", :controller => "surveys", :action => "show"

  # UPDATE
  get "/surveys/:id/edit", :controller => "surveys", :action => "edit"
  post "/update_survey/:id", :controller => "surveys", :action => "update"

  # DELETE
  get "/delete_survey/:id", :controller => "surveys", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

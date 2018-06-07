Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "surveys#index"
  # Routes for the Survey_response resource:
  # CREATE
  get "/survey_responses/new", :controller => "survey_responses", :action => "new"
  post "/create_survey_response", :controller => "survey_responses", :action => "create"

  # READ
  get "/survey_responses", :controller => "survey_responses", :action => "index"
  get "/survey_responses/:id", :controller => "survey_responses", :action => "show"

  # UPDATE
  get "/survey_responses/:id/edit", :controller => "survey_responses", :action => "edit"
  post "/update_survey_response/:id", :controller => "survey_responses", :action => "update"

  # DELETE
  get "/delete_survey_response/:id", :controller => "survey_responses", :action => "destroy"
  #------------------------------

  # Routes for the Survey_response_option resource:
  # CREATE
  get "/survey_response_options/new", :controller => "survey_response_options", :action => "new"
  post "/create_survey_response_option", :controller => "survey_response_options", :action => "create"

  # READ
  get "/survey_response_options", :controller => "survey_response_options", :action => "index"
  get "/survey_response_options/:id", :controller => "survey_response_options", :action => "show"

  # UPDATE
  get "/survey_response_options/:id/edit", :controller => "survey_response_options", :action => "edit"
  post "/update_survey_response_option/:id", :controller => "survey_response_options", :action => "update"

  # DELETE
  get "/delete_survey_response_option/:id", :controller => "survey_response_options", :action => "destroy"
  #------------------------------

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

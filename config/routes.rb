  Devapi::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "api/registrations",
  :sessions => "api/sessions",
  :passwords => "api/passwords"}

  namespace :api do
    resources :events
  end


  end

  
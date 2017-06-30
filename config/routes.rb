Rails.application.routes.draw do

  devise_for :users

  root 'pages#home'

  get '/input_form/' => 'pages#input_form', as: 'input_form'

  get '/index/' => 'pages#index', as: 'index'

  post '/import_file' => 'pages#import_file', as: 'import_file'

  get '/anonymized_file/show/:id' => 'pages#anonymized_file_show', as: 'anonymized_file_show'

end

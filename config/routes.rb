# Plugin"s routes
# See: http://guides.rubyonrails.org/routing.html

GollumRails::Engine.routes.draw do

  get  "/index" => "wiki#index",   :as => :wiki_root
  get "/new" => "wiki#new" ,       :as => :new_wiki_page

  post "/create" => "wiki#create" ,:as => :create_wiki_page
  
  constraints( :page => /.*/ ) do
    match "/edit/:page" => "wiki#edit" ,   :as => :edit_wiki_page , :via => [:get , :post]
    match "/rename/:page" => "wiki#rename",:as => :rename_wiki_page , :via => [:get , :post]
    get ":page" => "wiki#page" ,           :as => :wiki_page
  end

end

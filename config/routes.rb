# Plugin"s routes
# See: http://guides.rubyonrails.org/routing.html

GollumRails::Engine.routes.draw do

  get  "/index" => "wiki#index",     :as => :wiki_root
  post "/preview" => "wiki#preview", :as => :wiki_preview
  get  "/list/:str" => "wiki#list",  :as => :wiki_list
  match "/new" => "wiki#new_page" ,  :as => :new_wiki_page , :via => [:get , :post]

  constraints( :page => /.*/ ) do
    match "/edit/:page" => "wiki#edit" ,   :as => :edit_wiki_page   , :via => [:get , :post]
    match "/rename/:page" => "wiki#rename",:as => :rename_wiki_page , :via => [:get , :post]
    match "/delete/:page" => "wiki#delete",:as => :delete_wiki_page , :via => [:get , :post]
    get ":page" => "wiki#page" ,           :as => :wiki_page
  end

end

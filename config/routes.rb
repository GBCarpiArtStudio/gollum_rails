# Plugin"s routes
# See: http://guides.rubyonrails.org/routing.html

GollumRails::Engine.routes.draw do

  get  "/index" => "wiki#index", as: :wiki_root
  get "/new" => "wiki#new" , :as => :new_wiki_page

  constraints(:folder => /.*/, :page => /.*/ ) do
    get ":page" => "wiki#page" , :as => :wiki_page
  end

end

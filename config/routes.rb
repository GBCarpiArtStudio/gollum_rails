# Plugin"s routes
# See: http://guides.rubyonrails.org/routing.html

GollumRails::Engine.routes.draw do

  constraints(:folder => /.*/, :page => /.*/ ) do
    get  "/index" => "wiki#index", as: :wiki_root
  end

end

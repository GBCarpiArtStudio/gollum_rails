# Plugin"s routes
# See: http://guides.rubyonrails.org/routing.html

GollumRails::Engine.routes.draw do

  constraints(:folder => /.*/, :page => /.*/ ) do
    get  "/pages/index" => "pages#index", as: :pages_root
  end

end

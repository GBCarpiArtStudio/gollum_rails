Rails.application.routes.draw do
  mount GollumRails::Engine => "/wiki"
end

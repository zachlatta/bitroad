Bitroad::Application.routes.draw do
  resources :listings do
    member do
      patch "purchase"
    end
  end

  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home].each do |page|
    get page, controller: "pages", action: page
  end
end

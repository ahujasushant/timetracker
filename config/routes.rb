class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end
Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    devise_for :users
  end
  get 'accounts/new'
  get 'accounts/create'
  get 'welcome/index'
  root 'welcome#index'
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

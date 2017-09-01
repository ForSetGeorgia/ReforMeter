Rails.application.routes.draw do
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    post '/users', to: 'users#create'

    devise_for :users,
               controllers: {
                 confirmations: 'users/confirmations',
                 omniauth: 'users/omniauth',
                 passwords: 'users/passwords',
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 unlocks: 'users/unlocks'
               },
               path_names: {sign_in: 'login', sign_out: 'logout'},
               constraints: { format: :html }

    match '/admin', :to => 'admin#index', :as => :admin, :via => :get
    namespace :admin do
      resources :external_indicators, constraints: { format: :html } do
        member do
          get 'data', constraints: { format: :html }
          patch 'data', constraints: { format: :html }
        end
      end
      resources :reports, except: :show, constraints: { format: :html }
      resources :experts, except: :show, constraints: { format: :html } do
        member do
          post 'up', to: 'experts#up'
          post 'down', to: 'experts#down'
        end
      end
      resources :reforms, except: :show, constraints: { format: :html }
      resources :reform_colors, except: :show, constraints: { format: :html }
      # resources :quarters, except: :show, constraints: { format: :html } do
      #   resources :news, except: :index, constraints: { format: :html }
      #   resource :expert_survey, except: :index, constraints: { format: :html }
      #   resources :reform_surveys, except: :index, constraints: { format: :html }
      #   member do
      #     post 'publish', constraints: { format: :html }
      #     post 'unpublish', constraints: { format: :html }
      #   end
      # end

      resources :news, constraints: { format: :html }

      resources :verdicts, except: :show, constraints: { format: :html } do
        resources :reform_surveys, except: :index, constraints: { format: :html } do
          member do
            post 'publish', constraints: { format: :html }
            post 'unpublish', constraints: { format: :html }
          end
        end
        member do
          post 'publish', constraints: { format: :html }
          post 'unpublish', constraints: { format: :html }
        end
      end

      resources :page_contents, constraints: { format: :html }
      resources :users, constraints: { format: :html }
    end

    get '/about' => 'root#about'
    get '/economic_effects' => 'root#economic_effects'
    get '/download_data_and_reports' => 'root#download_data_and_reports'
    post '/download_data_and_reports' => 'root#download_data_and_reports'
    get '/reforms' => 'root#reforms'
    # if there is no time period then send back to reforms page with reform as query string
    get '/reforms/:reform_id', to: redirect('/%{locale}/reforms?reform=%{reform_id}')
    get '/reforms/:reform_id/:verdict_id' => 'root#reform_show', as: :reform_show
    # get '/review_board' => 'root#review_board'
    # get '/review_board/:id' => 'root#review_board_show', as: :review_board_show
    get '/reform_verdicts' => 'root#reform_verdicts'
    get '/reform_verdicts/:id' => 'root#reform_verdict_show', as: :reform_verdict_show

    post '/charts/create_share_image', to: 'charts#create_share_image'

    root 'root#index'

    # handles /en/fake/path/whatever
    get '*path', to: redirect("/#{I18n.default_locale}")
  end

  # handles /
  get '', to: redirect("/#{I18n.default_locale}")

  # handles /not-a-locale/anything
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")


end

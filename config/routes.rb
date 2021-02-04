Rails.application.routes.draw do
  scope module: :public do
    devise_for :customers , controllers:{
      registrations: 'public/registrations',
      sessions: 'public/sessions',
      passwords: 'public/passwords'
    }

    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :items , only:[:index , :show]

    resource :customers , only:[:show]
    get '/customers/edit/edit' => 'customers#edit'
    patch '/customers/update' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'

    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items , except:[:new , :edit , :show]

    post '/orders/orderconfirmation' => 'orders#orderconfirmation'
    get '/orders/ordercomplete' => 'orders#ordercomplete'
    resources :orders , except:[:edit , :update , :destroy]

    resources :addresses , except:[:new , :show]
  end

  namespace :admin do
    devise_for :admins , path: '' , controllers: {
      sessions: 'admin/sessions',
      registrations: 'admin/registrations',
      passwords: 'admin/passwords'
    }

    root to: 'homes#top'

    resources :items , except:[:destroy]

    resources :genres , except:[:show , :new , :destroy]

    resources :customers , except:[:new , :create , :destroy]

    resources :orders , only:[:index , :show , :update]

    resources :ordered_products , only:[:update]
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do #namespace: hogeで名前空間を付与することができる。
    namespace :v1 do #namespaceは複数配置することも可能
      resources :restaurants do #特定のリソースに対するルーティングはresourcesを使う。七つのルーティングを自動で作成してくれます。
        resources :foods, only: %i[index]
      end
      resources :line_foods, only: %i[index create]
      put 'line_foods/replace', to: 'line_foods#replace' #'line_foods/replace'というURLに対してPUTリクエストがきたら、line_foods_controller.rbのreplaceメソッドを呼ぶ
      #resourcesとの違いはアプリケーション独自のルーティングとコントローラー、そのアクションに対応させられるという点です。
      resources :orders, only: %i[create]
    end
  end


end

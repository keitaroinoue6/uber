module Api #名前空間の指定
  module V1 #restaurant_controller.rbはapi/vi/ディレクトリにある
    class RestaurantsController < ApplicationController
      def index
        restaurants = Restaurant.all #Restaurantモデルを全て取得して、代入している

        render json: { #render json:{}という形でJSON形式でデータを返却しています。
          restaurants: restaurants
        }, status: :ok #status: :okとすることで、リクエストが成功したことと、200 OKと一緒にデータを返すようになる
      end
    end
  end
end

module Api
  module V1
    class FoodsController < ApplicationController
      def index
        restaurant = Restaurant.find(params[:restaurant_id]) #このコントローラーはリクエスト時にparams[:restaurant_id]というパラメータを受け取ります。この中には店舗のIdが入ります
        #idを基に全てのRestaurantの中からfindで対応するデータを一つだけ探し出し、その結果をrestaurant変数に代入している
        foods = restaurant.foods #restaurantにはparams[:restaurant_id]に対応するrestaurantが一つ入っています。
        #そのrestaurantのリレーション先のfoods一覧をrestaurant.foodsと書くことで取得できます。

        render json: {
          foods: foods
        }, status: :ok
      end
    end
  end
end
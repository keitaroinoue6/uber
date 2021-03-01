module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create] #onlyオプションをつけることで、特定のアクションの実行前にだけ追加することができる。

      def create
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          #上記は複数のscope(active, other_reataurant)を組み合わせて、「他店舗でアクティブなLineFood」をActive_Relationの形で取得。
          # それが存在するかどうかをexists?で判断している。ここでtureになる場合は、JSON形式のデータを返却してreturnして処理を追える。
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            # existing_restaurantですでに作成されている他店舗の情報と
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
            # new_reataurantでこのリクエストで作成しようとした新店舗の情報の2つを返しています
          }, status: :not_acceptable #テストコードは406 Not Acceptable
        end

        set_line_food(@ordered_food)
        #上記でline_foodインスタンスを生成しています

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
        #params[:food_id]を受け取って、対応するFoodを一つ抽出し、@order_foodというグローバル変数に代入。
        #こうすることでこの後実行されるcreateアクションの中でも@oreder_foodを参照することができる。
      end

      def set_line_food(ordered_food)
        if ordered_food.line_food.present? #判断を行っている
          #二つのパターンがあります。一つは新しくline_foodを生成する場合、もう一つはすでに同じfoodに関するline_foodが存在する場合。
          @line_food = ordered_food.line_food 
          @line_food.attributes = { #ordered_food.line_food.present?がtrueの場合はline_foodインスタンスの既存の情報を更新します
            count: ordered_food.line_food.count + params[:count],
            active: true
          }
        else
          @line_food = ordered_food.build_line_food( #全く新しいline_foodを作成する場合はインスタンスを新規作成しています
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end

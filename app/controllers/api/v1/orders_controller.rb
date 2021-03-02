module Api
  module V1
    class OrdersController < ApplicationController
      def create
        posted_line_foods = LineFood.where(id: params[:line_food_ids])
        #今回はアプリケーションの使用上、複数の仮注文があるため、複数のidの配列パラメーターとしてフロントから送られてきます。
        #これらをLineFood.whereに渡すことで対象のidのデータを取得し、posted_line_foodsという変数に代入
        order = Order.new( #Order.newし、orderインスタンスを生成しています。
          restaurant_id: posted_line_foods.first.restaurant_id,
          total_price: total_price(posted_line_foods),
        )
        if order.save_with_update_line_foods!(posted_line_foods)
          render json: {}, status: :no_content # 成功した場合にはstatus: :no_contentと空データを返します。
        else
          render json: {}, status: :internal_server_error #失敗した場合はstatus: :internal_sever_errorを返します。
        end
      end

      private

      def total_price(posted_line_foods)
        posted_line_foods.sum {|line_food| line_food.total_amount } + posted_line_foods.first.restaurant.fee
      end
    end
  end
end

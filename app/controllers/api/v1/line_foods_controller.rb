module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create] #onlyオプションをつけることで、特定のアクションの実行前にだけ追加することができる。
      
      def index
        line_food = LineFood.active #LineFoodモデルの中からactiveなものを取得して、変数に代入している
        #モデル名.scope名という形でactive: trueなLineFoodの一覧がActiveRecord_Relationの形で取得
        if line_foods.exists? #.existsメソッドは対象のインスタンスのデータがDBに存在するかどうかの確認
          render json: { #正常パターンとしてデータを返す
            line_food_ids: line_foods.map { |line_food| line_food.id },
            #登録されているLineFoodのidを配列型式にしています。Rubyの.mapメソッドは配列やハッシュオブジェクトなどを一つずつ取り出し、.mapより後ろのブッロクを当てている
            restaurant: line_foods[0].restaurant,
            #一つの仮注文につき一つの店舗という仕様のため、line_foodの中にある先頭のline_foodインスタンスの店舗の情報を詰めています。
            count: line_fods.sum { |line_food| line_food[:count] },
            #各line_foodインスタンスには数量を表す:countがあります。フロントエンドにはそれぞれの数量を返して、フロント側で合算するという方法もある。
            amount: line_foods.sum { |line_food| line_food.total_amount }, 
            #最後のamountには各line_foodがインスタンスメソッドtotal_amountを呼んで、またその数値を合算している。これは「数量*単価」のさらに合計を計算している。
          }, status: :ok
        else
          render json: {}, status: :no_content
          #空データがJSON形式で返されます。
        end
      end

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

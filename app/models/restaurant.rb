class Restaurant < ApplicationRecord
  has_many :foods
  has_many :line_foods, through: :foods
  belongs_to :order, optional: true

  validates :name, :fee, :time_required, present: true　#カラムのデータが必ず存在することを定義している
  validates :name, length: { maximum: 30 } #最大文字数を30文字以下と制限している
  validates :fee, numericality: { greater_than: 0 } #手数料が0以上であることの制限をしています。配送手数料なので誤って-100などのマイナスの値が入らないようにするため
end
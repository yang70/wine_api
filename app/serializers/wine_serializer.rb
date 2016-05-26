class WineSerializer < ActiveModel::Serializer
  attributes :id, :name, :varietal, :quantity

  belongs_to :user
end

class WineSerializer < ActiveModel::Serializer
  attributes :id, :name, :varietal, :quantity
end

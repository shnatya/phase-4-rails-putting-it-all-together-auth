class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :minutes_to_complete, :instructions
  belongs_to :user
end

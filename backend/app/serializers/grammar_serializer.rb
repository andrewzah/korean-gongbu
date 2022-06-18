class GrammarSerializer
  include JSONAPI::Serializer

  attributes :name, :description_en, :category_en, :additional_info
end

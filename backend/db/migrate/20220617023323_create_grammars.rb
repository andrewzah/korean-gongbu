class CreateGrammars < ActiveRecord::Migration[7.0]
  def change
    create_table :grammars do |t|
      t.text :name
      t.text :description_en, null: true
      t.text :category_en, null: true
      t.text :additional_info, null: true

      t.timestamps
    end
  end
end

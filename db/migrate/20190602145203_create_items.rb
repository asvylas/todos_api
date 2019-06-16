# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.boolean :done
      t.references :todo

      t.timestamps
    end
  end
end

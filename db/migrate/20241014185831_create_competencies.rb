class CreateCompetencies < ActiveRecord::Migration[7.0]
  def change
    create_table :competencies do |t|
      t.string :name, null: false
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

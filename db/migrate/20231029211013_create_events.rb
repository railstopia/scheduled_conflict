class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :calendar, null: false, foreign_key: true
      t.tsrange :during

      t.timestamps
    end
  end
end

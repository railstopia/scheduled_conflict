class CreateCalendars < ActiveRecord::Migration[7.1]
  def change
    create_table :calendars do |t|

      t.timestamps
    end
  end
end

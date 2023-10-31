class AddExclusionConstraintOnEvents < ActiveRecord::Migration[7.1]
  def up
    execute "ALTER TABLE events ADD EXCLUDE USING GIST (calendar_id WITH = , "\
      "during WITH &&)"
  end

  def down
    execute "ALTER TABLE events DROP CONSTRAINT events_calendar_id_during_excl"
  end
end

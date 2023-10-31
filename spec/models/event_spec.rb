require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:calendar) { Calendar.create! }
  let!(:timestamp) { 2.hours.from_now.beginning_of_hour }

  before do
    Event.create(
      during: timestamp...(timestamp + 1.hour),
      calendar: calendar
    )
  end

  it "prevents creation of an overlapping event" do
    expect {
      Event.create(
        during: (timestamp + 30.minutes)...(timestamp + 90.minutes),
        calendar: calendar
      )
    }.to raise_error(
      ActiveRecord::StatementInvalid,
      /PG::ExclusionViolation/
    )
  end

  it "permits creating overlapping events on different calendars" do
    other_calendar = Calendar.create!
    another_event =
      Event.create!(
        during: (timestamp + 30.minutes)...(timestamp + 90.minutes),
        calendar: other_calendar
      )
    expect(another_event.persisted?).to be(true)
  end

  it "permits back to back events" do
    new_event = Event.create!(
      during: (timestamp + 60.minutes)...(timestamp + 90.minutes),
      calendar: calendar
    )
    expect(new_event.persisted?).to be(true)
  end
end

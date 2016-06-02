class Slot < ActiveRecord::Base
  belongs_to :booking_request

  def to_s
    "#{chosen_date.to_s(:gov_uk)} - #{period}"
  end

  def period
    'Morning' if name == '0800-1200'
    'Afternoon' if name == '1300-1700'
    "#{name[0,2].to_i > 12 ? (name[0,2].to_i - 12).to_s : name[0,2]}:#{name[2,2]}#{name[0,2].to_i > 11 ? 'pm' : 'am'}"
  end
end

require 'factory_bot_rails'

10.times do
  FactoryBot.create(:company_with_units, units_count: 6)
end

50.times do
  FactoryBot.create :feedback
end

10.times do
  FactoryBot.create :user
end

Company.all.each do |company|
  5.times do
    FactoryBot.create(:employee, company: company)
  end

  3.times do
    FactoryBot.create(:staff_member, company: company)
  end
end

FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'tama00' }
    password_confirmation { password }
    last_name             { '田中' }
    family_name           { '正造' }
    kana_last_name        { 'タナカ' }
    kana_family_name      { 'ショウゾウ' }
    birth_day             { Faker::Date.backward }
  end
end

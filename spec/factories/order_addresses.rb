FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567'}
    prefecture_id { 2 }
    city { '東京都' }
    house_number { '1-1' }
    building {'とってもいいアパート'}
    phone { '08011112222' }
    association :user
    association :item
    token { "tok_abcdefghijk00000000000000000" }
  end
end

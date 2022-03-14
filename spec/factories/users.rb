FactoryBot.define do
  factory :user do
    nickname              {Faker::Team.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    first_name            {'太郎'}
    last_name             {'山田'}
    first_name_kana       {'タロウ'}
    last_name_kana        {'ヤマダ'}
    birth_date            {Faker::Date.between(from: 40.year.ago, to: 20.year.ago)} 
  end
end

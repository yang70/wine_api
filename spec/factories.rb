FactoryGirl.define do

  factory :wine do
    sequence(:name) { |n| "Wine #{n}" }
    varietal [ 
      'Chardonnay', 
      'Sauvignon Blanc', 
      'Semillon', 
      'Moscato', 
      'Pinot Grigio', 
      'Gewurztraminer', 
      'Riesling', 
      'White', 
      'Champagne',
      'Syrah',
      'Shiraz',
      'Merlot',
      'Cabernet Sauvignon',
      'Malbec',
      'Pinot Noir',
      'Zinfandel',
      'Sangiovese',
      'Barbera',
      'Cabernet Franc',
      'Petite Sirah',
    ].sample
    quantity 1
    user
  end

  factory :user do
    sequence(:email) { |n| "email-#{n}@foo.com" }
    password              "password"
    password_confirmation "password"

    factory :user_with_wines do
      transient do
        wine_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:wine, evaluator.wine_count, user: user)
      end
    end
  end
end

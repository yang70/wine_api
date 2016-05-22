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
  end
end

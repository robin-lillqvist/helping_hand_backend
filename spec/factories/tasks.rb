FactoryBot.define do
  factory :task do
    user 
    long { '52.15'}
    lat{ '52.15'}
    status {'pending'}
    name {'Robin'}
    address {'Bolidenvägen 12'}
    phone {'0729999999'}
  end
end

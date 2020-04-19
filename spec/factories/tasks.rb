FactoryBot.define do
  factory :task do
    user 
    long { '52.15'}
    lat{ '52.15'}
    status {'pending'}
  end
end

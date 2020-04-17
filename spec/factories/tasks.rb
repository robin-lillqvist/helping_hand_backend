FactoryBot.define do
  factory :task do
    status {'pending'}
    user
  end
end

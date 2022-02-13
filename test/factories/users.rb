FactoryBot.define do
  factory :user do
    id {1}
    email {'test@user.com'}
    password {'qwerty'}
    username {'test_name'}
    first_name {'test_first'}
    last_name {'test_last'}
  end
end

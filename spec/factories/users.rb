FactoryBot.define do
  factory :user do
    name              { 'techcamp'}
    email                 { 'test@test'}
    password              { 'test123' }
    password_confirmation { password }
    sex_id                { 2 }
  end
end

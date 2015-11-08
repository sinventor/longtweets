FactoryGirl.define do
  invite_subjects = %w[
    футбол
    хоккей
    концерт
  ]

  sequence :text do |n|
    "Через 3 часа собираемся на #{invite_subjects[(n - 1) % invite_subjects.length]}"
  end

  factory :direct_message do
    user
    text

    factory :valid_direct_message do
      recipient 'IvanLo;FedorTrick'
    end
  end
end
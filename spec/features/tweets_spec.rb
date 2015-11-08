require 'rails_helper'

RSpec.feature "Tweets", type: :feature do

  describe 'CREATE tweet from authorized user\'s name' do
    it 'should send tweet in background using sidekiq worker' do
      visit '/'
      expect(page).to have_content('Войти')

      click_on 'Войти'
      expect(page).to have_content('Выйти')

      click_on 'Твиты'
      expect(page).to have_content('Обновить статус')

      click_on 'Обновить статус'
      fill_in 'tweet[text]', with: 'It provides HTTPlug, a collection of interfaces and exceptions to define a minimal HTTP client contract on top of PSR-7 request and response.'
      click_button 'Создать твит'

      expect(Tweet.count).to eq(1)
      expect(page).to have_content('Твит был успешно создан')
      expect(page.driver.status_code).to eq(200)

      expect(TweetWorker).to have_enqueued_job(User.last.id, Tweet.last.id)
    end
  end

end

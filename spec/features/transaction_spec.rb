require 'rails_helper'

RSpec.describe 'Testing Recipes:', type: :feature do
  before do
    @user = User.create(
      name: 'Tester',
      email: 'test@gmail.com',
      password: '123456'
    )

    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Log in')

    @transaction = Transaction.create(
      name: 'Cinema',
      amount: 25.50,
      user_id: @user.id
    )

    visit transactions_path
  end

  it 'Show a created transaction' do
    expect(page).to have_content(@transaction.name)
  end
end

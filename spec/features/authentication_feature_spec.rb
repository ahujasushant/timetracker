require 'rails_helper'

describe 'User Authentication' do
  let!(:user) { create :user }
  let!(:account) { create(:account, owner: user) }

  it 'allows signin with valid credentials' do
    sign_user_in(user, subdomain: account.subdomain)

    expect(page).to have_content('Signed in successfully.')
  end

  it 'does not allows signin with invalid credentials' do
    sign_user_in(user, subdomain: account.subdomain, password: 'something')

    expect(page).to have_content('Invalid Email or password')
  end

  it 'does not allow users to sign in unless subdomain' do
    expect { visit new_user_session_path }.to raise_error ActionController::RoutingError
  end

  it 'allows users to sign out' do
    sign_user_in(user, subdomain: account.subdomain)

    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end

  def sign_user_in(user, args)
    visit new_user_session_url(subdomain: args[:subdomain])
    fill_in 'Email', with: user.email
    fill_in 'Password', with: args[:password] || user.password
    click_button 'Log in'
  end
end
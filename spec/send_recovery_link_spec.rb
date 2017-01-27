require 'spec_helper'
require './app/send_recover_link'

describe SendRecoverLink do
  let(:user) { double :user, email: 'johndoe@internet.com', password_token: '0987654321' }
  let(:mail_gun_client) { double :mail_gun_client }
  let(:sandbox_domain_name) { ENV['MAILGUN_SANDBOX'] }

  it 'sends message to mailgun when called' do
    params = {from: 'postmaster@sandboxf9a344be433e426b9e37036cc8f9ed17.mailgun.org', to: user.email, subject: 'reset your password', text: "Click here to reset your password: http://fast-temple-28875.herokuapp.com/reset_password?token=#{user.password_token}" }
    expect(mail_gun_client).to receive(:send_message).with(sandbox_domain_name, params)
    described_class.call(user, mail_gun_client)
  end
end

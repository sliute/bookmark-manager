require 'mailgun'

class SendRecoverLink
  def initialize(mailer: nil)
    @mailer = mailer || Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
  end

  def self.call(user, mailer = nil)
    new(mailer: mailer).call(user)
  end

  def call(user)
    mailer.send_message(ENV['MAILGUN_SANDBOX'], {from: 'postmaster@sandboxf9a344be433e426b9e37036cc8f9ed17.mailgun.org',
        to: user.email,
        subject: 'reset your password',
        text: "Click here to reset your password: http://fast-temple-28875.herokuapp.com/reset_password?token=#{user.password_token}"})
  end

  private

  attr_reader :mailer
end

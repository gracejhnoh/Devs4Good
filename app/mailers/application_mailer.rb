class ApplicationMailer < ActionMailer::Base
  default from: 'devs4good@gmail.com'
  layout 'mailer'

  def default_url_options
    if Rails.env.development? || Rails.env.test?
      {:host => "localhost:3000"}
    # :nocov:
    elsif Rails.env.production?
      {:host => "devs4good.herokuapp.com"}
    else
      {}
    end
    # :nocov:
  end
end

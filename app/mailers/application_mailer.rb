class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@myscanapp.com'
  layout 'mailer'
end

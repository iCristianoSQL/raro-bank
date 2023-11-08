# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'rarobank@raro.com.br'
  layout 'mailer'
end

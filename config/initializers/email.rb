if Rails.env.production? || Rails.env.staging?
  Rails.application.config.action_mailer.delivery_method = :smtp

  Rails.application.config.action_mailer.smtp_settings = {
    :address              => ENV['APPLICATION_EMAIL_SMTP_ADDRESS'],
    :port                 => 587,
    :domain               => 'forset.ge',
    :user_name            => ENV['APPLICATION_EMAIL_SMTP_AUTH_USER'],
    :password             => ENV['APPLICATION_EMAIL_SMTP_AUTH_PASSWORD'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }
end

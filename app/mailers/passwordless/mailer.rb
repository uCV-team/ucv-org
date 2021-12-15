# frozen_string_literal: true

module Passwordless
  # The mailer responsible for sending Passwordless' mails.
  class Mailer < Passwordless.parent_mailer.constantize
    # Sends a magic link (secret token) email.
    # @param session [Session] A Passwordless Session
    def magic_link(session)
      @session = session

      @magic_link = send(Passwordless.mounted_as)
                    .token_sign_in_url(session.token, only_path: true)

      email_field = @session.authenticatable.class.passwordless_email_field
      mail(
        to: @session.authenticatable.send(email_field),
        from: ENV['MAIL_FROM'],
        subject: I18n.t('passwordless.mailer.subject')
      )
    end
  end
end

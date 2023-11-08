# frozen_string_literal: true

class TransfersMailer < ApplicationMailer
  def token_notification(transfer)
    @sender_email = transfer.sender.email
    @token = transfer.token

    mail(to: [@sender_email], subject: 'Token de Confirmação de Transferência')
  end

  def transfer_notification(transfer)
    @sender_email = transfer.sender.email
    @receiver_email = transfer.receiver.email
    @amount = transfer.amount

    mail(to: [@receiver_email], subject: 'Transferência Concluída')
  end
end

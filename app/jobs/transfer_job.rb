
class TransferJob < ApplicationJob
  queue_as :default

  def perform
    if within_transfer_hours?
      transfers = Transfer.where(status: :pending)
      transfers.each do |transfer|
        transfer.status = :confirmed
        transfer.execute_transfer
        transfer.save(validate: false)
        TransfersMailer.transfer_notification(transfer).deliver_now
      end
    end
  end

  private

  def within_transfer_hours?
    current_time = Time.now
    current_time.strftime("%H:%M") >= "08:00" && current_time.strftime("%H:%M") <= "18:00" && (1..5).include?(current_time.wday)
  end
end

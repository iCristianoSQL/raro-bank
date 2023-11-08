class TransfersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transfer, only: [:show]

  def new
    @transfer = Transfer.new
    @contacts = contacts
  end

  def create
    if within_transfer_hours?
      @transfer = Transfer.new(transfer_params)
      @transfer.sender = current_user
      receiver = find_receiver

      if receiver && !validate_receiver
        if sufficient_balance?(@transfer.amount)
          @transfer.receiver = receiver
          @transfer.status = :pending
          Transfer.transaction do
            @transfer.save!
          end
          TransfersMailer.token_notification(@transfer).deliver_now
          flash[:notice] = "Transferência criada com sucesso."
          redirect_to transfer_path(@transfer)
        else
          flash.now[:alert] = "Saldo insuficiente para realizar a transferência."
          render :new
        end
      else
        @contacts = contacts
        message = validate_receiver ? "Foram inseridos destinatários distintos" : "Destinatário inválido."
        flash.now[:alert] = message
        render :new
      end
    else
      receiver = find_receiver
      @contacts = contacts
      @transfer = Transfer.new(transfer_params)
      @transfer.sender = current_user
      @transfer.receiver = receiver
      @transfer.status = :pending
      Transfer.transaction do
        @transfer.save!
      end
      TransfersMailer.token_notification(@transfer).deliver_now
      redirect_to transfer_path(@transfer)
    end
  end

  def confirmation

    @transfer = Transfer.find_by(token: params[:token])

    if @transfer.present? && (1..5).include?(@transfer.created_at.wday)
      if @transfer.token_expired?
        flash.now[:alert] = "Token expirado!"
        redirect_to new_transfer_path and return
      else
        @transfer.execute_transfer
        @transfer.status = :confirmed
        @transfer.save!
        TransfersMailer.transfer_notification(@transfer).deliver_now
        flash.now[:notice] = "Transferência confirmada com sucesso!"
      end
    elsif @transfer.present? && !(1..5).include?(@transfer.created_at.wday)
      if @transfer.token_expired?
        flash.now[:alert] = "Token expirado!"
        redirect_to new_transfer_path and return
      else
        @transfer.status = :pending
        @transfer.save
        flash.now[:alert] = "Transferencia fora do horario comercial ela sera concluida no dia #{next_transfer_hour}."
      end
    end

    render :confirmation
  end


  def within_transfer_hours?
    current_time = Time.now
    current_time.strftime("%H:%M") >= "08:00" && current_time.strftime("%H:%M") <= "18:00" && (1..5).include?(current_time.wday)
  end

  def next_transfer_hour
    current_time = Time.current
    next_transfer_time = Time.new(current_time.year, current_time.month, current_time.day, 8, 0, 0) + next_transfer_day.days
    next_transfer_time.strftime("%d/%m/%Y às %H:%M")
  end

  def next_transfer_day
    day = Time.current.wday
    if day == 5
      3
    elsif day == 6
      2
    else
      1
    end
  end

  def show
    @transfer = Transfer.find(params[:id])
  end

  private

  def sufficient_balance?(amount)
    current_user.balance.current_balance >= amount
  end

  def transfer_params
    params.require(:transfer).permit(:amount, :status)
  end

  def find_receiver
    if my_contact.present?
      User.find_by(cpf: my_contact)
    else new_contact.present?
      User.find_by(cpf: new_contact)
    end
  end

  def validate_receiver
   my_contact.present? && new_contact.present? && (my_contact != new_contact)
  end

  def my_contact
    params[:transfer][:my_contact_cpf]
  end

  def new_contact
    params[:transfer][:new_contact_cpf]
  end

  def contacts
    current_user.transferable_contacts
  end

  private

  def set_transfer
    @transfer = Transfer.find(params[:id])
    unless @transfer.sender == current_user || @transfer.receiver == current_user
      flash[:alert] = "Acesso não autorizado."
      redirect_to root_path
    end
  end
end

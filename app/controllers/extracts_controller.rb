class ExtractsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])

    if @user == current_user
      @sent_transfers = @user.sent_transfers.includes(:receiver)
      @received_transfers = @user.received_transfers.includes(:sender)
      @investments = @user.investments.includes(:product)
    else
      flash[:alert] = "Você não tem permissão para visualizar o extrato desse usuário."
      redirect_to root_path
    end
  end
end

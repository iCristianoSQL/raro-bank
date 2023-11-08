class InvestmentsController < ApplicationController
  def index
    @investments = Investment.all
  end

  def show
    @investment = Investment.find(params[:id])
  end

  def new
    @investment = Investment.new
  end

  def create
    @investment = Investment.new(investment_params)
    @investment.user = current_user
    @investment.investment_date = Date.today
    user_balance = current_user.balance.current_balance
    current_user.balance.update!(current_balance: user_balance - @investment.invested_amount)
    
    if @investment.save
      current_user.investments << @investment
      redirect_to products_path, notice: 'Investimento criado com sucesso.'
    else
      render :new, alert: 'Erro ao criar o investimento.'
    end
  end    

  def edit
    @investment = Investment.find(params[:id])
  end

  def update
    @investment = Investment.find(params[:id])
    if @investment.update(investment_params)
      redirect_to @investment, notice: 'Investimento atualizado com sucesso.'
    else
      render :edit, alert: 'Erro ao atualizar o investimento.'
    end
  end

  def destroy
    investment = Investment.find(params[:id])
    user_balance = current_user.balance.current_balance
    value_to_redeem = investment.invested_amount
    current_user.balance.update!(current_balance: user_balance + value_to_redeem)
    investment.update!(redeemed: true)
    redirect_to products_path, notice: 'Saque efetuado com sucesso!!'
  end

  private

  def investment_params
    params.require(:investment).permit(:invested_amount, :investment_date, :redeemed, :redemption_date, :user_id, :product_id)
  end
end

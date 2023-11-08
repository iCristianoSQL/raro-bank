class BalancesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_administrator, only: [:deposit]

  def show
    @balance = Balance.find(params[:id])
    if @balance.user == current_user
      @current_balance = @balance.current_balance
      @balance_deposited = @balance.balance_deposited
      @withdrawn = @balance.withdrawn
    else
      flash[:alert] = 'Você não tem permissão para visualizar esse saldo.'
      redirect_to root_path
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Saldo não encontrado.'
    redirect_to root_path
  end

  def deposit
    @balance = Balance.find(params[:id])
    amount = params[:amount].to_f

    if @balance.user == current_user && amount.positive?
      @balance.deposit(amount)

      @current_balance = @balance.current_balance
      @balance_deposited = @balance.balance_deposited
      @withdrawn = @balance.withdrawn

      flash[:notice] = "Saldo atualizado com sucesso. Saldo atual: #{'%.2f' % @current_balance}"
      redirect_to @balance
    else
      flash[:alert] = 'Falha ao adicionar saldo. Certifique-se de fornecer um valor positivo.'
      redirect_to @balance
    end
  end

  def withdraw
    @balance = Balance.find(params[:id])
    amount = params[:amount].to_f

    if @balance.user == current_user && amount.positive? && amount <= @balance.current_balance
      @balance.withdraw(amount)

      @current_balance = @balance.current_balance
      @balance_deposited = @balance.balance_deposited
      @withdrawn = @balance.withdrawn

      flash[:notice] = "Saque realizado com sucesso. Saldo atual: #{'%.2f' % @current_balance}"
      redirect_to @balance
    elsif @balance.user == current_user && amount > @balance.current_balance
      flash[:alert] = 'Valor do saque excede o saldo atual.'
      redirect_to @balance
    else
      flash[:alert] = 'Falha ao efetuar o saque. Certifique-se de fornecer um valor positivo e menor ou igual ao saldo atual.'
      redirect_to @balance
    end
  end

  def current_balance
    @balance = current_user.balance
  end

  private

  def authenticate_administrator!
    unless current_user.administrator?
      flash[:alert] = "Acesso negado. Você não é um administrador."
      redirect_to root_path
    end
  end
end

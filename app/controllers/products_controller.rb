class ProductsController < ApplicationController
  before_action :authenticate_administrator!, only: %i[new show create edit update destroy]

    def index
      @products = Product.all
    end
  
    def new
        @product = Product.new
    end
  
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to @product, notice: "Product created successfully."
      else
        render :new
      end
    end
  
    def show
      @product = Product.find(params[:id])
    end
  
    def edit
      @product = Product.find(params[:id])
    end
  
    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to product_path(@product), notice: 'Produto atualizado com sucesso.'
      else
        render :edit, alert: 'Erro ao atualizar o produto.'
      end
    end
  
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to products_path, notice: 'Produto excluído com sucesso.'
    end
  
    private
  
    def product_params
      params.require(:product).permit(:name, :punctuation, :start_date, :end_of_term, :minimum_investment_amount, :image_url, :premium, :additional_fee, :fee_id)
    end

    def authenticate_administrator!
      unless current_user.administrator?
        flash[:alert] = "Acesso negado. Você não é um administrador."
        redirect_to root_path
      end
    end
  end
  
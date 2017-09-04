class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js
  load_and_authorize_resource :except => [:index, :show]

  def index
    @merchandises = Merchandise.all
    respond_with(@merchandises)
  end

  def show
    respond_with(@merchandise)
  end

  def new
    @merchandise = Merchandise.new
    @contract = Contract.find(params[:contract_id])
    respond_with(@merchandise)
  end

  def edit
    @contract = Contract.find(params[:contract_id])
  end

  def create
    @contract = Contract.find(params[:contract_id])
    @merchandise = @contract.merchandises.create(merchandise_params)
    if @merchandise.errors.size != 0
      errors = @payment.errors.full_messages
      respond_to do |format|
        format.json { render json: { errors: errors }, status: :bad_request }
      end
    else
      respond_to do |format|
        format.json { render json: { merchandise: @merchandise }, status: "ok"  }
        format.html { redirect_to contract_path(@contract), notice: 'Item was successfully created.' }
      end
    end
  end

  def update
    @contract = Contract.find(params[:contract_id])
    if @merchandise.update(merchandise_params)
      redirect_to contract_path(@contract)
    else
      render 'edit'
    end
  end

  def destroy
    @contract = Contract.find(params[:contract_id])
    balance = @contract.contract_balance
    if balance < @merchandise.price
      respond_to do |format|
        format.json { render json: { error: "can't delete item greater than the balance: #{balance}" }, status: :bad_request }
      end
    else
      @merchandise.destroy
      respond_to do |format|
        format.json { render json: { merchandise: @merchandise }, status: "ok"  }
      end
    end
  end

  private
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end

    def merchandise_params
      params.require(:merchandise).permit(:name, :price, :contract_id)
    end
  
end

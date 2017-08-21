class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: [:show, :edit, :update, :destroy]

  respond_to :html
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
    if @merchandise.id
      redirect_to contract_path(@contract)
    else
      render 'new'
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
    @merchandise.destroy
    @contract = Contract.find(params[:contract_id])
    redirect_to contract_path(@contract)
  end

  private
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end

    def merchandise_params
      params.require(:merchandise).permit(:name, :price, :contract_id)
    end
  
end

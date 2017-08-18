class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  respond_to :html
  load_and_authorize_resource :except => [:index, :show]

  def index
    @contracts = Contract.all
    respond_with(@contracts)
  end

  def show
    respond_with(@contract)
  end

  def new
    @contract = Contract.new
    respond_with(@contract)
  end

  def edit
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to contracts_path
    end
  end

  def update
    if @contract.update(contract_params)
      redirect_to contracts_path
    end
  end

  def destroy
    @contract.destroy
    respond_with(@contract)
  end

  private
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:name)
    end
end

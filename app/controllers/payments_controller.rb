class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js
  load_and_authorize_resource :except => [:index, :show]
  
  def index
    @payments = Payment.where(:contract_id => params[:contract_id])
    @contract = Contract.find(params[:contract_id])
    @errors = params[:errors]
    respond_with(@payments)
  end

  def show
    respond_with(@payment)
  end

  def new
    @payment = Payment.new
    @contract = Contract.find(params[:contract_id])
    respond_with(@payment)
  end

  def edit
    @contract = Contract.find(params[:contract_id])
  end

  def create
    @contract = Contract.find(params[:contract_id])
    @payment = @contract.payments.create(payment_params)
    if @payment.errors.size != 0
      errors = @payment.errors.full_messages
    else
      errors = nil
      check_balance(@contract)
    end
    redirect_to contract_payments_path(@contract, :errors => errors)
  end

  def update
    @contract = Contract.find(params[:contract_id])
    if @payment.update(payment_params)
      redirect_to contract_payments_path(@contract)
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    @contract = Contract.find(params[:contract_id])
    redirect_to contract_payments_path(@contract)
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:payment_date, :description, :amount, :contract_id)
    end
    
    def check_balance(contract)
      if contract.contract_balance == 0
        SystemMailer.contract_payed_email(contract).deliver
      end
    end
end

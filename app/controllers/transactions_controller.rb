class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions or /transactions.json
  def index
    @category_selected = nil
    @transactions = Transaction.all.order('created_at DESC')
    @amount = Transaction.all.sum(:amount)
    @title = 'TRANSACTIONS'
    @categories = Category.all.order('name ASC')

    return unless params[:category].present? && params[:category] != ''

    @category_selected = params[:category]

    @transactions = Transaction
      .joins(:categories_transactions)
      .where(categories_transactions: { category_id: @category_selected })
      .order('created_at DESC')

    @amount = Transaction
      .joins(:categories_transactions)
      .where(categories_transactions: { category_id: @category_selected })
      .sum(:amount)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    @title = 'TRANSACTIONS'
  end

  # GET /transactions/new
  def new
    @categories_selected = []
    @title = 'TRANSACTIONS'
    @categories = Category.all.order('name ASC')
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
    @categories_selected = []
    @title = 'TRANSACTIONS'
    @selected = @transaction.categories
    @selected.each { |element| @categories_selected << element.id }
    @categories = Category.all
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = User.first

    respond_to do |format|
      if @transaction.save
        set_relation(params[:categories], @transaction.id)

        format.html { redirect_to transactions_path, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        @transaction.categories.destroy_all
        set_relation(params[:categories], @transaction.id)
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_id)
  end

  def set_relation(categories, transaction)
    categories.each do |category|
      CategoriesTransaction.create(category_id: category, transaction_id: transaction)
    end
  end
end

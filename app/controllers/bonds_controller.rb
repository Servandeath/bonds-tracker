class BondsController < ApplicationController
  before_action :set_bond, only: %i[ show edit update destroy ]

  # GET /bonds or /bonds.json
  def index
    @q = Bond.ransack(params[:q])
    @bonds = @q.result.order(:maturity_date)
              .page(params[:page])
              .per(params[:per_page] || 50)
end

  # GET /bonds/1 or /bonds/1.json
  def show
  end

  # GET /bonds/new
  def new
    @bond = Bond.new
  end

  # GET /bonds/1/edit
  def edit
  end

  # POST /bonds or /bonds.json
  def create
    @bond = Bond.new(bond_params)

    respond_to do |format|
      if @bond.save
        format.html { redirect_to @bond, notice: "Bond was successfully created." }
        format.json { render :show, status: :created, location: @bond }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @bond.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /bonds/1 or /bonds/1.json
  def update
    respond_to do |format|
      if @bond.update(bond_params)
        format.html { redirect_to @bond, notice: "Bond was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @bond }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @bond.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /bonds/1 or /bonds/1.json
  def destroy
    @bond.destroy!

    respond_to do |format|
      format.html { redirect_to bonds_path, notice: "Bond was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bond
      @bond = Bond.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def bond_params
      params.expect(bond: [ :isin, :name, :issuer, :coupon_rate, :face_value, :maturity_date, :currency ])
    end
end

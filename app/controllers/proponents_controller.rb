class ProponentsController < ApplicationController
  include InssRateHelper

  before_action :authenticate_user!
  before_action :set_proponent, only: %i[show edit update destroy]
  before_action :set_inss_rate_types, only: %i[index show edit]

  def index
    @chart_data = Proponent.group(:inss_rate_type).count
    @chart_labels = @chart_data.keys.map { |k| inss_rate_labels[k.to_sym] }

    salary_ranges = Proponent.inss_rate_types.keys.map(&:to_sym)

    @paginated_groups = salary_ranges.index_with do |range|
      Proponent
        .where(inss_rate_type: Proponent.inss_rate_types[range])
        .page(params["#{range}_page"])
        .per(5)
    end
  end

  def show
  end

  def new
    @proponent = Proponent.new
    @proponent.addresses.build
    @proponent.contacts.build
  end

  def edit
    @proponent.addresses.build if @proponent.addresses.empty?
    @proponent.contacts.build if @proponent.contacts.empty?
  end

  def create
    @proponent = Proponent.new(proponent_params)
    if @proponent.save
      redirect_to @proponent, notice: "Proponent was successfully created."
    else
      render :new
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to @proponent, notice: "Proponent was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def calculate_inss
    salary = params[:salary].to_f
    token = params[:token].presence || SecureRandom.uuid

    InssRateCalculatorJob.perform_later(token, salary)

    head :ok
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_url, notice: "Proponent was successfully destroyed."
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def set_inss_rate_types
    @inss_labels = inss_rate_labels
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :document, :salary, :inss_rate_type, :inss_rate,
      addresses_attributes: [ :id, :street, :number, :zip_code, :city, :state, :_destroy ],
      contacts_attributes: [ :id, :contact_type, :value, :_destroy ]
    )
  end
end

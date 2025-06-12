class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update destroy]

  def index
    @proponents = Proponent.all
  end

  def show
  end

  def new
    @proponent = Proponent.new
  end

  def edit
  end

  def create
    @proponent = Proponent.new(proponent_params)
    if @proponent.save
      redirect_to @proponent, notice: 'Proponent was successfully created.'
    else
      render :new
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to @proponent, notice: 'Proponent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_url, notice: 'Proponent was successfully destroyed.'
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :document, :salary, :inss_rate_type, :inss_rate)
  end
end

class DomainsController < ApplicationController
  
  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(domain_params)

    if @domain.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @domain = Domain.find(params[:id])

    if @domain.update_attribute(:monitoring, params[:domain][:monitor])
      MonitorJob.perform_later(@domain)
      
      if params[:domain][:monitor] == "true"
        flash.now[:notice] = "Monitoring #{@domain.name}"
      else
        flash.now[:alert] = "Stopped monitoring #{(@domain.name)}"
      end
    else
      flash.now[:alert] = "Monitoring failed!"
    end
  end

  def show
    @domain = Domain.find(params[:id])
    @domain_pings = @domain.pings.order_last_out_first
  end

  private

    def domain_params
      params.require(:domain).permit(:name)
    end
end

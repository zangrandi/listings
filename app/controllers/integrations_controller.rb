class IntegrationsController < ApplicationController
  def index
    @integrations = current_user.integrations
  end

  def new
    @integration = current_user.integrations.build
  end

  def edit
    @integration = Integration.find(params[:id])
  end

  def create
    @integration = current_user.integrations.build(integration_params)

    if @integration.save
      redirect_to integrations_path
    else
      render :new
    end
  end

  def update
    @integration = current_user.integrations.find(params[:id])

    if @integration.update_attributes(integration_params)
      redirect_to integrations_path
    else
      render :edit
    end
  end

  def destroy
    @integration = current_user.integrations.find(params[:id])
    @integration.destroy
    redirect_to integrations_path, notice: "Integração removida com sucesso."
  end

  private

    def integration_params
      params.require(:integration).permit!
    end
end

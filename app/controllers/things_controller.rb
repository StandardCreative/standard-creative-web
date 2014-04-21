class ThingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project

  # POST /things
  # POST /things.json
  def create
    @thing = @project.things.new(thing_params)

    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'thing was successfully created.' }
        format.json { render json: @thing, status: :created }
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @project.things.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to things_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:thing][:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:project_id, :filekey, :filename)
    end
end

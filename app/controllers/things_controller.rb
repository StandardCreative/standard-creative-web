class ThingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_thing, only: [:show, :edit, :update, :destroy]

  def index
    @things = Thing.all
  end

  def show
    if @thing.to_param != params[:id]
      return redirect_to @thing, :status => :moved_permanently
    end
  end

  def new
    redirect_to things_path
  end

  def edit
  end

  def create
    @thing = current_user.things.new(thing_params.merge(body: params[:thing][:filename].rpartition(".")[0]))

    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'CREATED' }
        format.json { render :show, status: :created, location: @thing }
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @thing.update(thing_params)
        format.html { redirect_to @thing, notice: 'UPDATED' }
        format.json { render :show, status: :ok, location: @thing }
      else
        format.html { render :edit }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to things_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      begin
        @thing = if ["show"].include?(action_name)
          Thing.from_param(params[:id])
        else
          current_user.things.from_param(params[:id])
        end
      rescue ActiveRecord::RecordNotFound
        redirect_to things_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:body, :filekey, :filename, :content_type, :featured)
    end
end

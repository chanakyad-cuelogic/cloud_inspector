class SecurityGroupsController < ApplicationController
  before_action :set_security_group, only: [:show, :edit, :update, :destroy]
  before_action :create_compute_object

  # GET /security_groups
  # GET /security_groups.json
  def index
    @security_groups = SecurityGroup.all
    security_groups = SecurityGroup.fetch_all_sgs(@compute)
    inbound_rules = SecurityGroup.fetch_all_inbound_rule(security_groups)
  end

  # GET /security_groups/1
  # GET /security_groups/1.json
  def show
  end

  # GET /security_groups/new
  def new
    @security_group = SecurityGroup.new
  end

  # GET /security_groups/1/edit
  def edit
  end

  # POST /security_groups
  # POST /security_groups.json
  def create
    @security_group = SecurityGroup.new(security_group_params)

    respond_to do |format|
      if @security_group.save
        format.html { redirect_to @security_group, notice: 'Security group was successfully created.' }
        format.json { render :show, status: :created, location: @security_group }
      else
        format.html { render :new }
        format.json { render json: @security_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /security_groups/1
  # PATCH/PUT /security_groups/1.json
  def update
    respond_to do |format|
      if @security_group.update(security_group_params)
        format.html { redirect_to @security_group, notice: 'Security group was successfully updated.' }
        format.json { render :show, status: :ok, location: @security_group }
      else
        format.html { render :edit }
        format.json { render json: @security_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_groups/1
  # DELETE /security_groups/1.json
  def destroy
    @security_group.destroy
    respond_to do |format|
      format.html { redirect_to security_groups_url, notice: 'Security group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_group
      @security_group = SecurityGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_group_params
      params.require(:security_group).permit(:data)
    end

    def create_compute_object
      @compute = Fog::Compute.new :provider => 'AWS', :region => 'us-west-2', :aws_access_key_id => "AKIAIIKBNVJEP4F2KT6Q", :aws_secret_access_key => "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"
    end
end

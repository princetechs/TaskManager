class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]
before_action :check_session
  def index
    @teams = Team.all
  end

  def add_member
    @team = Team.find_by(id: params[:id])
    user = User.new(email: params[:email])
    
    if user.save(validate: false) # Skip other validations if needed
      member_role_name = 'Member' # Assuming this is a predefined role
      member_role = Role.find_by(name: member_role_name)
      
      if member_role.present?
        TeamUser.find_or_create_by(user: user, team: @team, role: member_role)
        redirect_to @team, notice: "#{user.email} added to the team."
      else
        # Handle the case where the role 'Member' does not exist
        redirect_to root_path, alert: "Role 'Member' does not exist."
      end
    else
      # Handle the case where the user couldn't be saved due to other reasons
      redirect_to root_path, alert: "User could not be added to the team."
    end
  end
  
  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :description)
    end
end

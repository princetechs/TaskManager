class TeamsController < ApplicationController
include ApplicationHelper
  before_action :set_team, only: %i[ show edit update destroy add_member]
before_action :check_session
  def index
    @teams = current_user.teams
  end

  def add_member
    exuser = User.find_by_email(params[:email])
  
    if exuser.nil?
      rand_password = @team.name + "@1234"
      user = User.new(email: params[:email])
      user.password = rand_password
      user.save(validate: false) # Skip other validations if needed
    end
  
    if exuser || user
      user_to_add = exuser || user
  
      TeamUser.find_or_create_by(user: user_to_add, team: @team, role_id: params[:role_id])
      redirect_to @team, notice: "#{user_to_add.email} added to the team."
      # Handle the case where the role 'Member' does not exist
    else
      # Handle the case where the user couldn't be saved due to other reasons
      redirect_to root_path, alert: "User could not be added to the team."
    end
  end
  
  
  
  def show
    @role = Role.all
    team_user = TeamUser.find_by(user_id: current_user.id, team_id: @team.id)
  
    if team_user.present?
      @tasks = team_user.task_assignments.includes(:task).map(&:task)
    else
      @tasks = []
    end
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
        member_role = Role.find_by(name: "Admin")
        if member_role.nil?
          member_role = Role.create(name: "Admin")
        end
        TeamUser.create(user: current_user, team: @team, role: member_role)
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

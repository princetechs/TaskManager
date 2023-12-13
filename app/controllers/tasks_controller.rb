class TasksController < ApplicationController
  before_action :set_team

   def index
    user_id = current_user.id
    team_id = @team.id
    team_user= TeamUser.where(user_id: user_id,team_id: team_id)
    @tasks = team_user.first.task_assignment.map { |task_assignment| task_assignment.task }
    # @tasks = Task.joins(:task_assignments).where(task_assignments: { team_user_id: TeamUser.where(user_id: user_id, team_id: team_id) })

   end

  def new
    @task = @team.tasks.build
    @team_members = @team.members
  end

  def create
    @task = @team.tasks.build(task_params)

    if @task.save
      assign_task_to_members(params[:task][:assigned_member_ids])
      redirect_to team_path(@team), notice: 'Task was successfully created.'
    else
      @team_members = @team.members
      render :new
    end
  end

  private

  def set_team
    @team = Team.includes(:members, :team_users).find(params[:team_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Team not found'
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def assign_task_to_members(member_ids)
    return if member_ids.blank?

    member_ids.each do |member_id|
      team_user = @team.team_users.find_by(user_id: member_id)
      TaskAssignment.create(task: @task, team_user: team_user) if team_user
    end
  end
end

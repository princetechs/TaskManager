class TasksController < ApplicationController
  before_action :set_team
  before_action :set_task, only: [:edit, :update, :show]

  def index
    @tasks = @team.tasks
  end

  def delete_task_assignment
    task_assignment = find_task_assignment(params[:id], params[:team_id], current_user.id)
    flash[:notice] = task_assignment&.destroy ? 'Task assignment deleted successfully.' : 'Task assignment not found.'
    redirect_to team_tasks_path(params[:team_id])
  end

  def show; end

  def edit
    @team_members = @team.team_users
    @assigned_user_emails = @task.assigned_users.pluck(:email)
  end

  def update
    if @task.update(task_params)
      update_assigned_members(params[:task][:assigned_member_ids])
      redirect_to team_path(@task.team), notice: 'Task was successfully updated.'
    else
      @team_members = @team.team_users
      render :edit
    end
  end

  def new
    @task = @team.tasks.build
    @team_members = @team.team_users
  end

  def create
    @task = @team.tasks.build(task_params)

    if @task.save
      assign_task_to_members(params[:task][:assigned_member_ids])
      redirect_to team_path(@team), notice: 'Task was successfully created.'
    else
      @team_members = @team.team_users
      render :new
    end
  end

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
    redirect_to root_path, alert: 'Team not found' unless @team
  end

  def set_task
    @task = @team.tasks.find_by(id: params[:id])
    redirect_to root_path, alert: 'Task not found' unless @task
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def find_task_assignment(task_id, team_id, user_id)
    team_user = TeamUser.find_by(user_id: user_id, team_id: team_id)
    team_user&.task_assignments&.find_by(task_id: task_id)
  end

  def assign_task_to_members(member_ids)
    return if member_ids.blank?

    team_users = @team.team_users.where(id: member_ids)
    @task.task_assignments.create(team_users.map { |team_user| { team_user: team_user } })
  end

  def update_assigned_members(team_member_ids)
    return if team_member_ids.blank?

    current_assigned_team_user_ids = @task.task_assignments.pluck(:team_user_id)
    team_member_ids.map!(&:to_i)

    removed_team_user_ids = current_assigned_team_user_ids - team_member_ids
    @task.task_assignments.where(team_user_id: removed_team_user_ids).destroy_all

    new_team_user_ids = team_member_ids - current_assigned_team_user_ids
    new_team_users = @team.team_users.where(id: new_team_user_ids)
    @task.task_assignments.create(new_team_users.map { |team_user| { team_user: team_user } })
  end
end

class TasksController < ApplicationController
  before_action :set_team
  before_action :set_task, only: [:edit, :update, :show]

  def index
    user_id = current_user.id
    team_user = find_team_user(user_id, @team.id)
    @tasks = team_user&.task_assignment&.map(&:task)
  end

  def delete_task_assignment
    task_assignment = find_task_assignment(params[:id], params[:team_id], current_user.id)
    puts "............."
    puts "#{params[:id]}, #{params[:team_id]}, #{current_user.id}"
    puts task_assignment.inspect
    
    if task_assignment&.destroy
      flash[:success] = 'Task assignment deleted successfully.'
    else
      flash[:error] = 'Task assignment not found.'
    end

    redirect_to team_tasks_path(params[:team_id])
  end

  def show
  end

  def edit
    @team_members = @team.members
  end

  def update
    if @task.update(task_params)
      assign_task_to_members(params[:task][:assigned_member_ids])
      redirect_to team_path(@task.team), notice: 'Task was successfully updated.'
    else
      @team_members = @team.members
      render :edit
    end
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
    @team = Team.find(params[:team_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Team not found'
  end

  def set_task
    @task = @team.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def find_team_user(user_id, team_id)
    TeamUser.find_by(user_id: user_id, team_id: team_id)
  end
  def find_task_assignment(task_id, team_id, user_id)
    team_user = find_team_user(user_id, team_id)
    return unless team_user

    team_user.task_assignment.find_by(task_id: task_id)
  end

  def assign_task_to_members(member_ids)
    return if member_ids.blank?

    team_users = @team.team_users.where(user_id: member_ids)
    team_users.each do |team_user|
      TaskAssignment.create(task: @task, team_user: team_user)
    end
  end
end

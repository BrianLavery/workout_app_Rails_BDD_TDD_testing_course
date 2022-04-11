class ExercisesController < ApplicationController
  def index
    @exercises = current_user.exercises.last_7_days
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:notice] = "Exercise has been created"
      # redirect_to user_exercise_path(current_user, @exercise)
      redirect_to [current_user, @exercise] # Short version of line above
    else
      flash.now[:alert] = "Exercise has not been created"
      render :new
    end
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update(exercise_params)
      flash[:notice] = 'Exercise has been updated'
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = 'Exercise has not been updated'
      render :edit
    end
  end

  def destroy
  end

  private

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date)
  end
end

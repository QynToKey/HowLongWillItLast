class LearningRecordsController < ApplicationController
  skip_before_action :require_login, only: %i[index new]

  def index
  end

  def new
    # デフォルトで今日の日付をセットする
    @learning_record = LearningRecord.new(study_date: Date.today)
  end

  def create
    @learning_record = current_user.learning_records.build(learning_record_params)

    if @learning_record.save
      redirect_to @learning_record, notice: "学習記録を保存しました"
    else
      flash.now[:alert] = "学習記録の保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @learning_record = current_user.learning_records.find(params[:id])
  end

  private

  def learning_record_params
    params.require(:learning_record).permit(:study_date, :content, :duration_minutes, :started_at, :ended_at, tag_ids: [])
  end
end

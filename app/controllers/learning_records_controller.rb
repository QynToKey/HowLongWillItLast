class LearningRecordsController < ApplicationController
  skip_before_action :require_login, only: %i[index new]

  def index
    @learning_records = current_user.learning_records.order(study_date: :desc)
  end

  def new
    # デフォルトで今日の日付をセットする
    @learning_record = LearningRecord.new(study_date: Date.today)
  end

  def create
    # ユーザーが所有する学習記録を作成する
    @learning_record = current_user.learning_records.build(learning_record_params)

    if @learning_record.save
      redirect_to @learning_record, notice: "学習記録を保存しました"
    else
      flash.now[:alert] = "学習記録の保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # ユーザーが所有する学習記録のみを表示できるようにする
    @learning_record = current_user.learning_records.find(params[:id])
  end

  def edit
    # ユーザーが所有する学習記録のみを編集できるようにする
    @learning_record = current_user.learning_records.find(params[:id])
  end

  def update
    @learning_record = current_user.learning_records.find(params[:id])

    if @learning_record.update(learning_record_params)
      redirect_to @learning_record, notice: "学習記録を更新しました"
    else
      flash.now[:alert] = "学習記録の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @learning_record = current_user.learning_records.find(params[:id])
    @learning_record.destroy
    redirect_to learning_records_path, notice: "学習記録を削除しました"
  end

  private

  def learning_record_params
    params.require(:learning_record).permit(:study_date, :content, :duration_minutes, :started_at, :ended_at, tag_ids: [])
  end
end

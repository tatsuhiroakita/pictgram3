class TopicsController < ApplicationController

  ##before_action :user_logged_in?

  ##before_action :login_required

  def index
    ##@topics = Topic.all
    @topics = Topic.all.includes(:favorite_users)
  end

  def new
    if !logged_in?
      redirect_to login_path
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @topic = Topic.find_by(id: params[:id])
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end

end

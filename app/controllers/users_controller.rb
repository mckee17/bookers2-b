class UsersController < ApplicationController

  def index
    @users = User.all
    @userinfo = current_user
    @booknew = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @userinfo = User.find(params[:id])
    @booknew = Book.new
    gon.data = []
    gon.data << @books.where(created_at: Time.zone.now.all_day).count
    for i in 1..6 do
      gon.data << @books.where(created_at: i.days.ago.all_day).count
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice:'You have updated user successfully.'
    else
      render :edit
    end
  end

 private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
module Admin
  class Users < Base
    # provides :xml, :yaml, :js
  
    def index
      @users = User.all(:order => [:email])
      display @users
    end
  
    def show(id)
      @user = User.get(id)
      raise NotFound unless @user
      display @user
    end
  
    def new
      only_provides :html
      @user = User.new
      display User
    end
  
    def edit(id)
      only_provides :html
      @user = User.get(id)
      raise NotFound unless @user
      display @user
    end
  
    def create(user)
      @user = User.new(user)
      if @user.save
        redirect url(:admin_users), :message => {:notice => "User was successfully created"}
      else
        render :new
      end
    end
  
    def update(user)
      @user = User.get(params[:id])
      raise NotFound unless @user
      if @user.update_attributes(user)
        redirect url(:admin_users), :message => {:notice => "User was successfully updated"}
      else
        display @user, :edit
      end
    end
  
    def destroy(id)
      @user = User.get(id)
      raise NotFound unless @user
      if @user.destroy
        redirect url(:admin_users), :message => {:notice => "User was successfully deleted"}
      else
        raise InternalServerError
      end
    end
  
  end # Users
end # Admin

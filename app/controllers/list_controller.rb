class ListController < ApplicationController
    before_action :set_list, only: %i(edit update destroy)
    before_action :user_list, only: %i(edit_user_name)

    def new
        @list = List.new
      end
    
      def create
        @list = List.new(list_params)
        if @list.save
          redirect_to :root
        else
          render action: :new
        end
      end

      def edit
        @list = List.find_by(id: params[:id])
      end

      def update
        if params[:id] == "update_user_name"
          update_user_name()
        else
            if @list.update(list_params)
              redirect_to :root
            else
              render action: :edit
            end
        end
      end

      def edit_user_name
# binding.pry
      end

      def update_user_name
        # binding.pry
        @user = User.find_by(id: current_user.id)
        if @user.update(name:params[:user][:name])
          redirect_to :root
        else
          render action: :edit_user_name
        end
      end

      def destroy
        @list.destroy
        redirect_to :root
      end
    
      
      private
        def list_params
          params.require(:list).permit(:title).merge(user: current_user)
        end

        def set_list
            @list = List.find_by(id: params[:id])
        end

        def user_list
            @user = User.find_by(id: current_user.id)
        end
end

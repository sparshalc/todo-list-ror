class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]
    def index
        if user_signed_in?
        @items = Item.where(:user_id => current_user.id).order("created_at DESC")
        end
    end

    def new
        @item = current_user.items.build
    end

    def show 
    end

    def create
        @item = current_user.items.build(items_params)
        if @item.save
            redirect_to root_path, notice: 'Item added to todolist!'
        else
            render :new,status: :unprocessable_entity 
        end
    end


    def edit
    end

    def update
        if @item.update(items_params)
            redirect_to root_path, notice: 'Item updated!'
        end
    end

    def complete
        @item = Item.find(params[:id])
        @item.update_attribute(:completed_at, Time.now)
        redirect_to root_path
    end



    def destroy
         @item.destroy
         redirect_to root_path, alert: 'Item removed from todolist!'
    end
    private
    def items_params
        params.require(:item).permit(:title, :description)
    end

    def find_item
        @item = Item.find(params[:id])
    end
end

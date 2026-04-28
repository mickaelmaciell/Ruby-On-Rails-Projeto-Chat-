class BlogPostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog_post, except: [:index, :new, :create] # only : [:show, :edit, :update, :destroy]

    def index
        @blog_posts = BlogPost.where(user: current_user).or(BlogPost.where(receiver: current_user))
        @user = User.all
    end

    def show
        #@blog_post = BlogPost.find(params[:id])
        #rescue ActiveRecord::RecordNotFound
        #redirect_to root_path 
    end

    def new
        @blog_post = BlogPost.new
    end
    
    def create
        @blog_post = BlogPost.new(blog_post_params)
        @blog_post.user = current_user
        if @blog_post.save
            redirect_to root_path, notice: "Message sent successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        #@blog_post = BlogPost.find(params[:id]) - before_action já possui essa funcionalidade, não é necessário repetir o código aqui
    end

    def update
        #@blog_post = BlogPost.find(params[:id]) - before_action já possui essa funcionalidade, não é necessário repetir o código aqui
        if @blog_post.update(blog_post_params)
            redirect_to root_path, notice: "Message updated successfully."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy 
        #@blog_post = BlogPost.find(params[:id]) - before_action já possui essa funcionalidade, não é necessário repetir o código aqui
        @blog_post.destroy
        redirect_to root_path
    end

    private

    def blog_post_params
        params.require(:blog_post).permit(:title, :body, :receiver_id)
    end

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
end
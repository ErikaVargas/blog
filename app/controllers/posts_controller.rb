class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like_post, :dislike_post]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("created_at ").all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    #Post.order("updated_at DESC , nombre ASC")
    # @posts = Post.order("updated_at DESC , nombre ASC")
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
        #Post.order("updated_at DESC , nombre ASC")
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
        
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to administrative_post_path }
      format.json { head :no_content }
    end
  end


  def administrative
    
    if params[:search]
      @posts = Post.search(params[:search]).reverse
    else
      @posts = Post.order("created_at ").all  
    end
  end

  def like_post
    @post.like+=1
    if @post.save
      redirect_to administrative_post_path, notice: 'te gusta'
    else
      render 'administrative'
    end
  end

  def dislike_post
    if @post.like>1
      @post.like-=1      
    else
      @post.like=0
    end


        if @post.save
          redirect_to administrative_post_path, notice: 'no te ha gustado'
        else
          render 'administrative'
        end
    

  end

  def report
     @posts = Post.all 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :category)
    end
end

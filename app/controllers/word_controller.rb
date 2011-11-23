class WordController < ApplicationController

  def index
    @allword = Words.find(:all, :limit => 10, :order => "created_at desc")
  end

  def show
    @allword = Words.find(:all, :limit => 10, :order => "created_at desc")
    if params[:id]
      @word = Words.find(:first, :conditions => ["word = ?", params[:id] ])
    else
      @word = Words.find(:first, :conditions => ["word = ?", params[:words]["word"] ])
    end
    if @word
      @allwd = @word.assoword.split(',')
    end
  end

  def new
    @allword = Words.all
    @word = Words.new
  end 

  def create
    @allword = Words.find(:all, :limit => 10, :order => "created_at desc")
   params[:words][:assoword] = params[:hidewd]
   @word = Words.new(params[:words])
   if @word.save
     flash[:notice] = "Successfully created."
     redirect_to "/"
   else
     render :action => 'new'
   end
  end

  def edit
    @allword = Words.all
    @word = Words.find(:first, :conditions => ["word = ?", params[:id].to_s ])
    @allwd = @word.assoword.split(',')
  end

  def update
   params[:words][:assoword] = params[:hidewd]
   @word = Words.find(:first, :conditions => ["word = ?", params[:words][:word].to_s ])
   @word.update_attributes(params[:words])
   if @word.save
     flash[:notice] = "Successfully created."
     redirect_to "/"
   else
     render :action => 'edit'
   end
  end

  def delete
    @word = Words.find(:first, :conditions => ["word = ?", params[:id].to_s ])
    @word.destroy
    flash[:notice] = "Successfully created."
    redirect_to "/"
  end

end

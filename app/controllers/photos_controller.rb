class PhotosController < ApplicationController
  
  # Comment this out for CSRF protection. 
  # There's a metal middleware class in app/middleware that's supposed to allow CSRF with Rails,
  # but it doesn't seem to work reliably.
  skip_before_filter :verify_authenticity_token

  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
      format.js         
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = TempPhoto.new(params[:photo])
    @photo.photo_content_type = MIME::Types.type_for(@photo.photo_file_name).to_s
    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
        format.json { render :json => { :result => 'success', :photo => photo_path(@photo) } }        
        format.js   
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error', :error => @asset.errors.full_messages.to_sentence } }        
        format.js   
      end
    end
  end


  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])
    @photo.photo_content_type = MIME::Types.type_for(@photo.photo_file_name).to_s
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
        format.json { render :json => { :result => 'success', :photo => photo_path(@photo) } }        
        format.js         
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error', :error => @asset.errors.full_messages.to_sentence } }
        format.js        
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
  
  #Check for file that already exists.   
  def check
    
  end
  
end

class AdminController < ApplicationController
  before_filter :require_admin, :set_current_tab, :get_lists

  def index
  end

  def add_group
    @group = Group.new(params[:group])
    redirect_to admin_index_path and return if @group.name.blank?

    respond_to do |format|
      if @group.save
        flash[:success] = "Group #{@group.name} was successfully created!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 0
        format.html { render :action => 'index' }
      end
    end
  end

  def add_status
    @status = Status.new(params[:status])
    redirect_to admin_index_path and return if @status.name.blank?

    respond_to do |format|
      if @status.save
        flash[:success] = "Status #{@status.name} was successfully created!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 1
        format.html { render :action => 'index' }
      end
    end
  end

  def add_priority
    @priority = Priority.new(params[:priority])
    redirect_to admin_index_path and return if @priority.name.blank?

    respond_to do |format|
      if @priority.save
        flash[:success] = "Priority #{@priority.name} was successfully created!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 2
        format.html { render :action => 'index' }
      end
    end
  end
  
  def add_time_type
    @time_type = TimeType.new(params[:priority])
    redirect_to admin_index_path and return if @time_type.name.blank?

    respond_to do |format|
      if @time_type.save
        flash[:success] = "Time Type #{@time_type.name} was successfully created!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 3
        format.html { render :action => 'index' }
      end
    end
  end

  def add_user
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = "User #{@user.username} was successfully created!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        @initial_tab_index = 4
        format.html { render :action => 'index' }
      end
    end
  end

  def toggle_group
    @group = Group.find(params[:id])

    if @group.enabled?
      @group.disabled_at = DateTime.now
      flash_msg = "Group #{@group.name} was successfully disabled!"
    else
      @group.disabled_at = nil
      flash_msg = "Group #{@group.name} was successfully enabled!"
    end

    respond_to do |format|
      if @group.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end


  def reports
    @start_date = Date.civil(params[:start_date][:"year"].to_i,params[:start_date][:"month"].to_i,params[:start_date][:"day"].to_i)
    @end_date = Date.civil(params[:report][:"end_date(1i)"].to_i,params[:report][:"end_date(2i)"].to_i,params[:report][:"end_date(3i)"].to_i)
    @group_hash = {}
    group_names = Group.find(:all)
    
    group_names.each {|group|
      group_number = Ticket.find(:all, :conditions => ["created_at >= ? AND group_id=? AND created_at <= ?", @start_date, group.id, @end_date+1]).count
      @group_hash[group.name] = group_number
    }
    
    @time_type_hash = {}
    time_type_names = TimeType.find(:all)
    time_type_names.each {|time_type|    
      time_type_number = Ticket.find(:all, :conditions => ["created_at >= ? AND time_type_id=? AND created_at <= ?", @start_date, time_type.id, @end_date+1]).count
      @time_type_hash[time_type.name] = time_type_number 
    }
    
    @user_hash = {}
    users = User.find(:all)
    users.each {|user|    
      user_number = Ticket.find(:all, :conditions => ["created_at >= ? AND created_by=? AND created_by <= ?", @start_date, user.id, @end_date+1]).count
      @user_hash[user.first_name + " " + user.last_name] = user_number
      
    }
    
    respond_to do |format|
      @initial_tab_index = 5
         #format.html { redirect_to admin_index_path }
       format.html { render :action => 'index' }
        
      end
  end
  
  def toggle_status
    @status = Status.find(params[:id])

    if @status.enabled?
      @status.disabled_at = DateTime.now
      flash_msg = "Status #{@status.name} was successfully disabled!"
    else
      @status.disabled_at = nil
      flash_msg = "Status #{@status.name} was successfully enabled!"
    end

    respond_to do |format|
      if @status.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  def toggle_priority
    @priority = Priority.find(params[:id])

    if @priority.enabled?
      @priority.disabled_at = DateTime.now
      flash_msg = "Priority #{@priority.name} was successfully disabled!"
    else
      @priority.disabled_at = nil
      flash_msg = "Priority #{@priority.name} was successfully enabled!"
    end

    respond_to do |format|
      if @priority.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @priority, :status => :created, :location => @priority }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def toggle_time_type
    @time_type = TimeType.find(params[:id])

    if @time_type.enabled?
      @time_type.disabled_at = DateTime.now
      flash_msg = "Time Type #{@time_type.name} was successfully disabled!"
    else
      @time_type.disabled_at = nil
      flash_msg = "Time Type #{@time_type.name} was successfully enabled!"
    end

    respond_to do |format|
      if @time_type.save
        flash[:success] = flash_msg
        format.html { redirect_to admin_index_path }
        format.xml  { render :xml => @time_type, :status => :created, :location => @time_type }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @time_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def set_current_tab
    @current_tab = :admin
  end

  def get_lists
    @groups_enabled = Group.enabled
    @groups_disabled = Group.disabled
    @statuses_enabled = Status.enabled
    @statuses_disabled = Status.disabled
    @priorities_enabled = Priority.enabled
    @priorities_disabled = Priority.disabled
    @time_types_enabled = TimeType.enabled
    @time_types_disabled = TimeType.disabled
  end

end

class AdminSessionsController < ApplicationController

  # GET /admin_sessions/new
  # GET /admin_sessions/new.xml
  def new
    @admin_session = AdminSession.new

    @page_title = "Login"
    @site_section = "hub"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_session }
    end
  end

  # POST /admin_sessions
  # POST /admin_sessions.xml
  def create
    @admin_session = AdminSession.new(params[:admin_session])

    respond_to do |format|
      if @admin_session.save
        flash[:notice] = 'Logged in.'
        format.html { redirect_to(current_admin.super_admin ? admins_path : (current_admin.club_id.blank?)? new_club_path: club_admin_index_path(current_admin.club_id)) }
        format.xml  { render :xml => @admin_session, :status => :created, :location => @admin_session }
      else
        @page_title = "Login"
        @site_section = "hub"
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_sessions/1
  # DELETE /admin_sessions/1.xml
  def destroy
    @admin_session = AdminSession.find(params[:id])
    @admin_session.destroy
    flash[:notice] = 'Logged out.'

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end

class AgentsController < ApplicationController
  def walk_mib
    
  end

  # GET /agents
  # GET /agents.xml
  def index
    @agents = Agent.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agents }
    end
  end

  # GET /agents/1
  # GET /agents/1.xml
  def show
    @agent = Agent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agent }
    end
  end

  # GET /agents/new
  # GET /agents/new.xml
  def new
    @agent = Agent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agent }
    end
  end

  # GET /agents/1/edit
  def edit
    @agent = Agent.find(params[:id])
  end

  # POST /agents
  # POST /agents.xml
  def create
    @agent = Agent.new(params[:agent])

    respond_to do |format|
      if @agent.save
        flash[:notice] = 'Agent was successfully created.'
        format.html { redirect_to(@agent) }
        format.xml  { render :xml => @agent, :status => :created, :location => @agent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agents/1
  # PUT /agents/1.xml
  def update
    @agent = Agent.find(params[:id])

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        flash[:notice] = 'Agent was successfully updated.'
        format.html { redirect_to(@agent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.xml
  def destroy
    @agent = Agent.find(params[:id])
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to(agents_url) }
      format.xml  { head :ok }
    end
  end
end

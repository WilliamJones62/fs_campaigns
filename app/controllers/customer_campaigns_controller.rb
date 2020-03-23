class CustomerCampaignsController < ApplicationController
  before_action :set_customer_campaign, only: [:show, :edit, :update, :destroy]

  # GET /customer_campaigns
  def index
    if user_signed_in? && current_user.campaigns
      if current_user.campaign_role == 'Marketing'
        # route to the Campaign index
        redirect_to campaigns_path and return
      end
      @campaigns = Campaign.where("start_date <= ?", Date.current).where("end_date >= ?", Date.current)
      current_campaign_ids = []
      @campaigns.each do |c|
        # create a list of current campaign ids
        current_campaign_ids.push(c.id)
      end
      # only display active customer campaigns for current campaigns
      if current_user.campaigns_admin
        @customer_campaigns = CustomerCampaign.where(active_campaign: true).where(campaign_id: current_campaign_ids)
      else
        @customer_campaigns = CustomerCampaign.where(user_name: current_user.email).where(active_campaign: true).where(campaign_id: current_campaign_ids)
      end
      @last_activity = []
      @customer_campaigns.each do |c|
        # need to find the last activity date, if it exists, for each customer_campaign by looking at the activities
        # collect all the activity_date fields, then sort them
        if c.campaign_activities.length == 0
          # no call data so set everything to spaces
          @last_activity.push(' ')
        else
          tempcalls = []
          if c.campaign_activities.length == 1
            # only one activity
            @last_activity.push(c.campaign_activities.first.activity_date.strftime("%Y %m %d"))
          else
            c.campaign_activities.each do |a|
              tempcalls.push(a.activity_date)
            end
            tempcalls.sort!
            @last_activity.push(tempcalls.last.strftime("%Y %m %d"))
          end
        end
      end
    else
      redirect_to signout_path and return
    end
  end

  # GET /customer_campaigns/1
  def show
    c = Campaign.find(@customer_campaign.campaign_id)
    @campaign_title = c.title
  end

  # GET /customer_campaigns/new
  def new
    campaigns = Campaign.where("start_date <= ?", Date.current).where("end_date >= ?", Date.current)
    @titles = []
    campaigns.each do |c|
      @titles.push(c.title)
    end
    @titles.sort!
  end

  # GET /customer_campaigns/1/edit
  def edit
    @activities = [' ', 'ASKED FOR THE ORDER', 'DISCUSSED PRODUCT', 'IN-PERSON MEETING', 'PRODUCT TASTING', 'QUALITY PROSPECT', 'RECEIVED ORDER', 'RIDE WITH']
    @outcomes = [' ', 'COMMITTED TO AS SPECIAL', 'COMMITTED TO FUTURE MENU', 'COMMITTED TO OTHER PRODUCT', 'COMMITTED TO PUT ON CURRENT MENU', 'FOLLOW UP REQUIRED',
      'NOT INTERESTED', 'NOT QUALIFIED', 'PLACED ORDER', 'PRICING CONCERN', 'QUALITY CONCERN', 'SCHEDULED MEETING', 'SCHEDULED TASTING']
    @required_date = Time.current.strftime('%Y-%m-%d')
    @customer_campaign.campaign_activities.build activity_date: @required_date
    @new = false
  end

  # PATCH/PUT /customer_campaigns/1
  def update
    respond_to do |format|
      if @customer_campaign.update(customer_campaign_params)
        format.html { redirect_to @customer_campaign, notice: 'Customer campaign was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customer_campaigns/1
  def destroy
    @customer_campaign.destroy
    respond_to do |format|
      format.html { redirect_to customer_campaigns_url, notice: 'Customer campaign was successfully deleted.' }
    end
  end

  def list
    if current_user.campaign_rep1
      shiptos = CustomerShipto.where(acct_manager: current_user.campaign_rep1)
      if current_user.campaign_rep2
        shiptos2 = CustomerShipto.where(acct_manager: current_user.campaign_rep2)
        shiptos += shiptos2
      end
    end
    $cust_names = []
    shiptos.each do |s|
      c = Orderfrom.find_by ship_to: s.shipto_code
      if c && c.cust_status = 'A'
        $cust_names.push(c.bus_name)
      end
    end
    $cust_names.sort!
    @customer_campaigns = CustomerCampaign.where(user_name: current_user.email).where(campaign_title: params["campaign_title"])
    @title = params["campaign_title"]

    if @customer_campaigns.length != 0
      # see if the customer campaign is still needed
      @customer_campaigns.each do |cc|
        if !$cust_names.include?(cc.custname) && cc.active_campaign
        # this active campaign is not needed. Set to inactive.
          cc.active_campaign = false
          cc.save
        end
      end
    end
    # for each customer name see if a customer campaign exists. If not then create one
    $cust_names.each do |name|
      cc = CustomerCampaign.find_by user_name: current_user.email, campaign_title: params["campaign_title"], custname: name
      if cc.blank?
        # can't find a customer campaign so create one
        campaign = Campaign.find_by title: params["campaign_title"]
        o = Orderfrom.find_by bus_name: name
        customer_campaign = CustomerCampaign.new(campaign_id: campaign.id, campaign_title: campaign.title, user_name: current_user.email,
          active_campaign: false, custcode: o.cust_code, custname: name)
        customer_campaign.save
      end
    end
    @customer_campaigns = CustomerCampaign.where(user_name: current_user.email).where(campaign_title: params["campaign_title"])
  end

  def selected
    i = 0
    cc_count = CustomerCampaign.where(user_name: current_user.email).where(campaign_title: params["title"]).length
    logger.info 'cc_count = '+cc_count.to_s
    while i < cc_count
      i += 1
      activei = 'active'+i.to_s
      custnamei = 'custname'+i.to_s
      customer_campaign = CustomerCampaign.find_by user_name: current_user.email, campaign_title: params["title"], custname: params[custnamei]

      if !customer_campaign.blank?
        if customer_campaign.active_campaign != params[activei]
        # the involvement of the customer in the campaign has changed. Update the customer campaign record.
          customer_campaign.active_campaign = params[activei]
          customer_campaign.save
        end
      end
    end
    redirect_to customer_campaigns_path, notice: 'Campaigns were successfully updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_campaign
      @customer_campaign = CustomerCampaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_campaign_params
      params.require(:customer_campaign).permit(
        :custcode, :custname, :campaign_id, :user_name, :campaign_title, :ship_to,
        campaign_activities_attributes: [
          :id,
          :activity_date,
          :activity,
          :outcome
        ]
      )
    end
end

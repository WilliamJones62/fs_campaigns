class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_descriptions, only: [:new, :edit, :update, :create]

  # GET /campaigns
def index
    @campaigns = Campaign.all
  end

  # GET /campaigns/1
def show
  end

  # GET /campaigns/new
def new
  @campaign = Campaign.new
  10.times { @campaign.campaign_products.build }
end

  # GET /campaigns/1/edit
def edit
  if @campaign.campaign_products.count > 9
    @campaign.campaign_products.build
  else
    i = 10 - @campaign.campaign_products.count
    i.times { @campaign.campaign_products.build }
  end
end

  # POST /campaigns
def create
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        @campaign.campaign_products.each do |c|
          if !c.part_desc.blank?
            p = Partmstr.find_by part_desc: c.part_desc
            c.part_code = p.part_code
            c.save
          end
        end
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
    else
        format.html { render :new }
    end
    end
  end

  # PATCH/PUT /campaigns/1
def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        @campaign.campaign_products.each do |c|
          if !c.part_desc.blank?
            p = Partmstr.find_by part_desc: c.part_desc
            if p
              c.part_code = p.part_code
              c.save
            end
          end
        end
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def set_descriptions
      if !$alldescs
        # need to set up global list of part descriptions
        parts = Partmstr.all
        # parts = Partmstr.where(part_status: 'A')
        sort_array = []
        $descs = []
        $alldescs = []
        $alluoms = []
        food_parts = ["DRY", "FRE", "FRZ", "MUS"]
        unwanted_uom = ["ST", "LB"]
        $alluoms.push(' ')
        $alldescs.push(' ')
        $descs.push(' ')
        parts.each do |p|
          if !p.part_code.blank? && !p.part_desc.start_with?("INACTIVE") && food_parts.include?(p.storage_type) && p.part_status == "A" && !unwanted_uom.include?(p.uom)
            desc = p.part_desc
            if p.part_code[0,1] == 'Z'
              # frozen codes should sort to the bottom of the list
              desc.insert(0,'Z')
            end
            combined = desc + p.uom
            sort_array.push(combined)
          end
        end
        sorted_array = sort_array.sort
        sorted_array.each do |p|
          uom = p[p.length-2,2]
          des = p[0,p.length-2]
          if des[0,1] == 'Z'
            desc = des[1..-1]
          else
            desc = des
          end
          $alluoms.push(uom)
          $descs.push(desc)
          $alldescs.push(desc.gsub(' ', '~'))
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(
        :title, :description, :start_date, :end_date,
        campaign_products_attributes: [
          :id,
          :part_code,
          :part_desc,
          :part_uom
        ]
      )
    end
end

class DatabasesController < ResourcesController
  before_filter :select_view_mode

  respond_to :html, :js
  respond_to :json, only: [:index, :show]

  has_scope :by_name
  has_scope :by_type

  def distribution
    respond_to do |format|
      format.json { render json: Database.d3_distribution }
      format.html
    end
  end

  def create
    create! { databases_url }
  end

  def update
    update! { databases_url }
  end

  protected
  def collection
    @databases ||= decorate_resource_or_collection(end_of_association_chain.order_by(:name.asc))
  end

  private
  def select_view_mode
    current_user.update_setting(:databases_view_mode, params[:view_mode]) if params[:view_mode]
  end

  def databases_view_mode
    if action_name == "show" || request_from_pdfkit?
      "detailed"
    else
      current_user.settings["databases_view_mode"] || "normal"
    end
  end
  helper_method :databases_view_mode
end

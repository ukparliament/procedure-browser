class SearchesController < ApplicationController
  #include PagyConcern

  def index
    if params[:search]
      @search_term = params[:search]

      redirect_to organisation_accountable_to_parliament_current_list_path
      # basic_search = PgSearch.multisearch(@search_term).includes(:searchable)
      # @member_results = basic_search.where(searchable_type: 'Member')
      # @non_member_results = basic_search.where.not(searchable_type: %w[AlternativeName NameChange Member])
      # @name_change_results = basic_search.where(searchable_type: %w[AlternativeName NameChange])

      # @total = @member_results.count + @non_member_results.count + @name_change_results.count
    end
  end
end
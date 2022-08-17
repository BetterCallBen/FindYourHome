module PaginationHelper
  def paginate(page_number)
    if page_number == params[:page].to_i
      "<div class='pagination-number active'>
        #{page_number}
      </div>"
    else
      link_to page_number, request.params.merge(page: page_number), class: 'pagination-number'
    end.html_safe
  end
end

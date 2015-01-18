module WikiHelper
  def page_rows page
    rows = page.content.split.length + 5
    rows > 30 ? 30 : rows
  end
end

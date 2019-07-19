defmodule LiveViewTestWeb.PageView do
  use LiveViewTestWeb, :view

  def get_category(categories, category_id) do
    Enum.find(categories, fn cat -> cat.id == category_id end)
  end

  def get_items(items, category_id) do
    Enum.filter(items, fn item -> item.category_id == category_id end)
  end
end

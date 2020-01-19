defmodule TrustworthyWeb.ValidationView do
  use TrustworthyWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end

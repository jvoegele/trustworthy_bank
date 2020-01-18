defmodule Trustworthy.Factory do
  @moduledoc false
  use ExMachina

  def user_factory do
    %{
      username: "user",
      password: "p@ssw0rd123",
      hashed_password: "1fb9c14e934b825a62d15230cc0c2bd1",
    }
  end
end

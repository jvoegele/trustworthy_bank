defmodule Trustworthy.EventStore do
  @moduledoc false

  use EventStore, otp_app: :trustworthy
end

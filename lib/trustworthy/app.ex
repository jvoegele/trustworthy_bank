defmodule Trustworthy.App do
  @moduledoc false
  use Commanded.Application, otp_app: :trustworthy

  router Trustworthy.CommandRouter
end

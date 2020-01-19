defmodule Trustworthy.Auth.Guardian do
  @moduledoc """
  Used by Guardian to serialize a JWT token
  """

  use Guardian, otp_app: :trustworthy

  alias Trustworthy.Customers
  alias Trustworthy.Customers.Projections.User

  def subject_for_token(%User{} = user, _claims), do: {:ok, "User:#{user.uuid}"}
  def subject_for_token(_resource, _claims), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => "User:" <> uuid}) do
    {:ok, Customers.user_by_uuid(uuid)}
  end

  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}
end

defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(%Recipient{} = recipient, _attrs) do
    Pento.Accounts.UserNotifier.deliver_promotion(recipient, "special.offer.com")
    {:ok, %Recipient{}}
  end
end

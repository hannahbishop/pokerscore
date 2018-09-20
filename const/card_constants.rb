$valid_suits = [:heart, :diamond, :spade, :club].freeze
$valid_values =* (2..14).freeze
$face_cards = {
  $valid_values[-1] => "A",
  $valid_values[-2] => "K",
  $valid_values[-3] => "Q",
  $valid_values[-4] => "J"
}

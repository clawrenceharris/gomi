enum Powerup {
  none("", "", 0, ""),
  grabber(
      "The Litter Grabber",
      "Grab Litter Critters from a distance.\nPress space to activate",
      10,
      "assets/images/powerups/grabber.png"),
  spike(
      "The Spike Surge",
      "Fend off Litter Critters by tossing\nspikes in the air.\nPress space to activate",
      30,
      "assets/images/powerups/spike.png");

  final String name;
  final String description;
  final int coins;
  final String image;
  const Powerup(this.name, this.description, this.coins, this.image);
}

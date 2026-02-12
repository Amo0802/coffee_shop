/// Model for the pizza loyalty program.
/// Replace the dummy data with your API response later.
class LoyaltyData {
  final String userName;
  final int pizzasBought;
  final int totalRequired;
  final int points;
  final DateTime resetDate;

  const LoyaltyData({
    required this.userName,
    required this.pizzasBought,
    this.totalRequired = 10,
    required this.points,
    required this.resetDate,
  });

  bool get canCollect => pizzasBought >= totalRequired;
  int get remaining => (totalRequired - pizzasBought).clamp(0, totalRequired);

  /// Dummy data — swap this with an API call later.
  static LoyaltyData dummy() {
    return LoyaltyData(
      userName: 'Marco',
      pizzasBought: 4,
      points: 730,
      resetDate: DateTime.now().add(const Duration(days: 5)),
    );
  }
}
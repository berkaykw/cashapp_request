import 'package:shared_preferences/shared_preferences.dart';

class BalanceService {
  static const String _balanceKey = "balance";

  Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_balanceKey) ?? 0.0;
  }

  Future<void> setBalance(double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_balanceKey, balance);
  }

  Future<void> addCash(double amount) async {
    final currentBalance = await getBalance();
    await setBalance(currentBalance + amount);
  }

  Future<void> cashOut(double amount) async {
    final currentBalance = await getBalance();
    await setBalance(currentBalance - amount);
  }
}
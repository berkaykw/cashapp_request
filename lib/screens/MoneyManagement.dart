import 'package:cashapp_request/models/balance_model.dart';
import 'package:cashapp_request/screens/AddCash.dart';
import 'package:cashapp_request/screens/CashOut.dart';
import 'package:cashapp_request/utils/colors.dart';
import 'package:flutter/material.dart';

class MoneyManagementPage extends StatefulWidget {
  const MoneyManagementPage({super.key});

  @override
  State<MoneyManagementPage> createState() => _MoneyManagementPageState();
}

class _MoneyManagementPageState extends State<MoneyManagementPage> {
  final String headerText = "Money";

  final Map<String, String> cardTexts = {
    'header': 'Card balance',
    'suffixText': 'Account & routing',
    'button_addCash': 'Add Cash',
    'button_outCash': 'Cash Out',
  };

  int _selectedIndex = 0;

 void _navigateToAddCash() async {
  double? updatedBalance = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddCashPage()),
  );

  // updatedBalance null dönerse, mevcut bakiyeyi koru
  if (updatedBalance != null) {
    setState(() {
      _currentBalance = updatedBalance; // Bakiyeyi güncelle
    });
  }
}

void _navigateToCashOut() async {
  double? updatedBalance = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CashOutPage()),
  );

  // updatedBalance null dönerse, mevcut bakiyeyi koru
  if (updatedBalance != null) {
    setState(() {
      _currentBalance = updatedBalance; // Bakiyeyi güncelle
    });
  }
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() async {
    double balance = await _balanceService.getBalance();
    setState(() {
      _currentBalance = balance;
    });
  }

  final BalanceService _balanceService = BalanceService();
  double _currentBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.moneyManagement_backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Text(
                    headerText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      color: ProjectColors.headerText_Color,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://pfpmaker.com/content/img/profile-pictures/cute/4.png',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Card(
              elevation: 3,
              color: ProjectColors.card_Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15.0,
                        top: 15.0,
                        right: 15.0,
                        bottom: 5.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            cardTexts['header']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ProjectColors.headerText_Color,
                            ),
                          ),
                          Spacer(),
                          Text(
                            cardTexts['suffixText']! + " >",
                            style: TextStyle(color: ProjectColors.card_Color2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 20),
                      child: Text(
                        "\$${_currentBalance.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                          color: ProjectColors.headerText_Color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                ProjectColors.card_buttonColor,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 12,
                                  vertical:
                                      MediaQuery.of(context).size.height / 90,
                                ),
                              ),
                            ),
                            onPressed: _navigateToAddCash,
                            child: Text(
                              cardTexts['button_addCash']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ProjectColors.headerText_Color,
                              ),
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                ProjectColors.card_buttonColor,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 12,
                                  vertical:
                                      MediaQuery.of(context).size.height / 90,
                                ),
                              ),
                            ),
                            onPressed: _navigateToCashOut,
                            child: Text(
                              cardTexts['button_outCash']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ProjectColors.headerText_Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildCard(
                  "Barrow",
                  Icons.subdirectory_arrow_right_rounded,
                  Colors.green,
                  Text(
                    "\$0.00",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                buildCard(
                  "Cards",
                  Icons.credit_card,
                  Colors.blue,
                  Text("2 active cards"),
                ),
                buildCard(
                  "Account",
                  Icons.account_balance,
                  Colors.orange,
                  Text("Balance: \$1200"),
                ),
                buildCard(
                  "Transfer",
                  Icons.swap_horiz,
                  Colors.purple,
                  Text("Recent transfer"),
                ),
                buildCard(
                  "Settings",
                  Icons.settings,
                  Colors.grey,
                  Text("Profile updated"),
                ),
                buildCard(
                  "Help",
                  Icons.help_outline,
                  Colors.red,
                  Text("Contact support"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        selectedFontSize: 14,
        unselectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_outlined),
            label: '\$${_currentBalance.toStringAsFixed(2)}',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue[900],
        unselectedItemColor: ProjectColors.card_Color2,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget buildCard(String title, IconData icon, Color iconColor, Text text) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    color: ProjectColors.card_Color,
    child: Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 45),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 75),
          text,
        ],
      ),
    ),
  );
}

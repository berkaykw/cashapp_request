import 'package:cashapp_request/screens/MoneyManagement.dart';
import 'package:flutter/material.dart';
import 'package:cashapp_request/models/balance_model.dart';
import 'package:cashapp_request/utils/colors.dart';

class CashOutPage extends StatefulWidget {
  const CashOutPage({super.key});

  @override
  State<CashOutPage> createState() => _CashOutPageState();
}

class _CashOutPageState extends State<CashOutPage> {
  String amount = "0";

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _loadBalance();
  }

  void _cashOut() async {
    double amountToAdd = double.tryParse(amount) ?? 0.0;
    await _balanceService.cashOut(amountToAdd);
    _loadBalance();
  }

  final BalanceService _balanceService = BalanceService();
  double _currentBalance = 0.0;

  void _loadBalance() async {
    double balance = await _balanceService.getBalance();
    setState(() {
      _currentBalance = balance;
    });
  }

  void _addNumber(String number) {
    setState(() {
      if (amount == "0") {
        amount = number;
      } else {
        amount += number;
      }
    });
  }

  void _deleteNumber() {
    setState(() {
      if (amount.length > 1) {
        amount = amount.substring(0, amount.length - 1);
      } else {
        amount = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 350),
              child: Align(
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoneyManagementPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://pfpmaker.com/content/img/profile-pictures/cute/4.png',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // Miktar
            Text(
              "\$$amount",
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Para birimi seçici
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: StadiumBorder(),
              ),
              child: Text("USD ▼", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            // Sayı tuşları
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.5,
                  children: [
                    ...List.generate(9, (index) {
                      return _buildNumberButton("${index + 1}");
                    }),
                    _buildNumberButton("."),
                    _buildNumberButton("0"),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  _cashOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                child: Text(
                  "Withdraw Money",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
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

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _addNumber(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(10),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontSize: 27,
            color: Colors.greenAccent[400],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: _deleteNumber,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(10),
      ),
      child: Icon(Icons.backspace, color: Colors.redAccent),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'walletClass.dart';
import 'wallets.dart';
import 'categories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spreadsheet App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 31, 31),
                Color.fromARGB(255, 48, 55, 58),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // TODO: This is the logo...might make it clickable
        leadingWidth: 80, // Increase the width of the leading widget
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 4.0,
            shape: const CircleBorder(),
            child: Container(
              width: 70, // Set the width of the logo
              height: 70, // Set the height of the logo
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logoCircle.png',
                fit: BoxFit.contain, // Ensure the image scales properly
              ),
            ),
          ),
        ),
        title: Text(
          'Bitcoin\nWallet Comparison',
          style: GoogleFonts.lato(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Ensure the title stays centered
        actions: [
          IconButton(
            iconSize: 40,
            icon: const Icon(Icons.menu),
            color: const Color.fromARGB(255, 105, 105, 105),
            onPressed: () {
              // Add menu button functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 155, 40),
              Color.fromARGB(255, 143, 72, 195),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SfDataGrid(
          source: CustomDataGridSource(),
          columnWidthMode: ColumnWidthMode.auto,
          frozenColumnsCount: 1,
          columns: [
            // Loop through each category to create a GridColumn
            for (String category in categories)
              GridColumn(
                columnName: category,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 31, 31, 31),
              Color.fromARGB(255, 48, 55, 58),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Text(
          'This project is a work in progress. If you enjoy it, please consider donating.',
          style: TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CustomDataGridSource extends DataGridSource {
  final List<DataGridRow> _dataGridRows = [];

  CustomDataGridSource() {
    for (var wallet in wallets) {
      _dataGridRows.add(
        DataGridRow(
          cells: [
            DataGridCell(columnName: 'Wallet', value: wallet.getName()),
            // This is the icon path
            DataGridCell(columnName: 'Icon', value: wallet.getIcon()),
            DataGridCell(columnName: 'Score', value: wallet.getScore()),
            DataGridCell(columnName: 'Android', value: wallet.getAndroid()),
            DataGridCell(columnName: 'IOS', value: wallet.getIos()),
            DataGridCell(columnName: 'Windows', value: wallet.getWindows()),
            DataGridCell(columnName: 'MacOS', value: wallet.getMacos()),
            DataGridCell(columnName: 'Linux', value: wallet.getLinux()),
            DataGridCell(
                columnName: 'Available in USA', value: wallet.getUsa()),
            DataGridCell(columnName: 'Dark Mode', value: wallet.getDarkMode()),
            DataGridCell(
                columnName: 'Multiple Languages',
                value: wallet.getMultiLanguage()),
            DataGridCell(columnName: 'BTC Only', value: wallet.getBtcOnly()),
            DataGridCell(
                columnName: 'Self-Custody', value: wallet.getSelfCustody()),
            DataGridCell(
                columnName: 'Open-Source', value: wallet.getOpenSource()),
            DataGridCell(columnName: 'No KYC', value: wallet.getNoKyc()),
            DataGridCell(columnName: 'Own Node', value: wallet.getOwnNode()),
            DataGridCell(columnName: 'Tor', value: wallet.getTor()),
            DataGridCell(columnName: 'MFA', value: wallet.getMfa()),
            DataGridCell(
                columnName: 'Encrypted Backup',
                value: wallet.getEncryptedBackup()),
            DataGridCell(
                columnName: 'Plausible Deniability',
                value: wallet.getPlausibleDeniability()),
            DataGridCell(
                columnName: 'Inheritance', value: wallet.getInheritance()),
            DataGridCell(columnName: 'On-Chain', value: wallet.getOnChain()),
            DataGridCell(
                columnName: 'BIP-39 Passphrase',
                value: wallet.getPassphrase()),
            DataGridCell(columnName: 'Paynym', value: wallet.getPaynym()),
            DataGridCell(
                columnName: 'Multiple Wallets',
                value: wallet.getMultipleWallets()),
            DataGridCell(
                columnName: 'Watch Only', value: wallet.getWatchOnly()),
            DataGridCell(columnName: 'Multisig', value: wallet.getMultisig()),
            DataGridCell(
                columnName: 'Hardware Wallet Support',
                value: wallet.getHardwareWalletSupport()),
            DataGridCell(
                columnName: 'Coin Control', value: wallet.getCoinControl()),
            DataGridCell(columnName: 'UTXO Labels', value: wallet.getLabels()),
            DataGridCell(columnName: 'NFC', value: wallet.getNfc()),
            DataGridCell(
                columnName: 'Silent Payments',
                value: wallet.getSilentPayments()),
            DataGridCell(
                columnName: 'Stonewall', value: wallet.getStonewall()),
            DataGridCell(columnName: 'Payjoin', value: wallet.getPayjoin()),
            DataGridCell(columnName: 'PSBT', value: wallet.getPsbt()),
            DataGridCell(columnName: 'RBF', value: wallet.getRbf()),
            DataGridCell(columnName: 'CPFP', value: wallet.getCpfp()),
            DataGridCell(columnName: 'Taproot', value: wallet.getTaproot()),
            DataGridCell(columnName: 'Batch TXs', value: wallet.getBatchTxs()),
            DataGridCell(
                columnName: 'Show X(Z)pub', value: wallet.getShowXpub()),
            DataGridCell(
                columnName: 'Lightning Network',
                value: wallet.getLightningNetwork()),
            DataGridCell(columnName: 'Zaps', value: wallet.getZaps()),
            DataGridCell(columnName: 'LNURL', value: wallet.getLnurl()),
            DataGridCell(columnName: 'Bolt 12', value: wallet.getBolt12()),
            DataGridCell(
                columnName: 'Multiple Mints', value: wallet.getMultiMint()),
            DataGridCell(
                columnName: 'Multiple LSPs', value: wallet.getMultiLsp()),
            DataGridCell(columnName: 'Fedimint', value: wallet.getFedimint()),
            DataGridCell(columnName: 'Cashu', value: wallet.getCashu()),
            DataGridCell(columnName: 'Liquid', value: wallet.getLiquid()),
            DataGridCell(columnName: 'USDT', value: wallet.getUsdt()),
            DataGridCell(
                columnName: 'Trampoline Routing',
                value: wallet.getTrampolineRouting()),
            DataGridCell(columnName: 'Nostr', value: wallet.getNostr()),
            DataGridCell(
                columnName: 'Contact Book', value: wallet.getContacts()),
            DataGridCell(
                columnName: 'BTC Over Email', value: wallet.getBtcOverEmail()),
            DataGridCell(columnName: 'Point of Sale', value: wallet.getPos()),
            DataGridCell(
                columnName: 'Unified QR', value: wallet.getUnifiedQr()),
            DataGridCell(
                columnName: 'Sign Message', value: wallet.getSignMessage()),
            DataGridCell(columnName: 'Testnet', value: wallet.getTestnet()),
            DataGridCell(columnName: 'Signet', value: wallet.getSignet()),
            DataGridCell(columnName: 'Buy', value: wallet.getBuy()),
            DataGridCell(columnName: 'Sell', value: wallet.getSell()),
            DataGridCell(columnName: 'Swaps', value: wallet.getSwaps()),
            DataGridCell(
                columnName: 'Atomic Swaps', value: wallet.getAtomicSwaps()),
          ],
        ),
      );
    }
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'Wallet') {
          return Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                dataCell.value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          );
        }
        if (dataCell.columnName == 'Icon') {
          // Assuming getIcon returns an asset path
          return Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Image.asset(
                dataCell.value.toString(), // Load the image from assets
                width: 50, // Adjust width as needed
                height: 50, // Adjust height as needed
                fit: BoxFit.contain, // Adjust the fit
                errorBuilder: (context, error, stackTrace) {
                  // Show a placeholder in case of error
                  return const Icon(Icons.error, size: 50);
                },
              ),
            ),
          );
        }
        if (dataCell.columnName == 'Score') {
          return Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                dataCell.value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          );
        } else {
          if (dataCell.value.toString() == "Y") {
            return Flexible(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Icon(Icons.check,
                    color: Color.fromARGB(255, 0, 232, 8)),
              ),
            );
          } else if (dataCell.value.toString() == "N") {
            return Flexible(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Icon(Icons.close,
                    color: Color.fromARGB(255, 255, 17, 0)),
              ),
            );
          }
          // For other columns, display the text
          return Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Tooltip(
                message: dataCell.value.toString(),
                child: const Icon(Icons.info,
                    color: Color.fromARGB(255, 255, 247, 0)),
                //color: Color.fromARGB(255, 255, 140, 0)),
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}

// This is a list to hold the currently displayed wallets
List<Wallet> results = [];

// This is a list that holds all of the wallets
List<Wallet> wallets = [
  alby,
  aqua,
  blink,
  blitz,
  blixt,
  blue,
  breez,
  cake,
  electrum,
  enuts,
  envoy,
  fedi,
  fullyNoded,
  green,
  harbor,
  keeper,
  muun,
  nunchuk,
  phoenix,
  primal,
  proton,
  sparrow,
  specter,
  speed,
  stack,
  strike,
  wos,
  wasabi,
  zbd,
  zeus
];

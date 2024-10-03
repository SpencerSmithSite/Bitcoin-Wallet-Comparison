import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'walletClass.dart';
import 'wallets.dart';
import 'categories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For displaying SVG images
import 'package:url_launcher/url_launcher.dart'; //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    final screenWidth = MediaQuery.of(context).size.width;

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
          screenWidth > 529
              ? 'Bitcoin Wallet Comparison'
              : screenWidth > 384
                  ? 'Bitcoin\nWallet Comparison'
                  : 'Bitcoin\nWallet\nComparison', // Dynamic title
          overflow: TextOverflow.fade,
          style: GoogleFonts.lato(
            fontSize: screenWidth > 529
                ? 30
                : screenWidth > 384
                    ? 25
                    : 20, // Dynamic font size
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Ensure the title stays centered
        actions: [
          Tooltip(
            message: 'More Features Coming Soon (tm)',
            child: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.menu),
              color: const Color.fromARGB(255, 105, 105, 105),
              onPressed: () {
                // Add menu button functionality here
              },
            ),
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
          columnWidthMode: ColumnWidthMode.none,
          frozenColumnsCount: 1,
          columns: [
            // Loop through each category to create a GridColumn
            for (String category in categories)
              GridColumn(
                columnName: category,
                width:
                    category == 'Hardware Wallet Support' ? 120 : double.nan,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align text on opposite sides
            children: [
              const Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'This project is a work in progress.\nPlease report issues/suggestions on Nostr.',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    //align the text to the center
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Optionally add ellipsis
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click, // Change cursor on hover
                  child: GestureDetector(
                    onTap: () {
                      _launchURL(
                        'https://primal.net/p/npub1fsndf82plzymhaptnjzzzpj8cwymqfu2j6hy62hrnv8nn6dxk85qvtuxeq',
                      ); // Launch the URL on tap
                    },
                    // Add the nostr.png image here
                    child: Image.asset(
                      'assets/nostr.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          )),
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
            DataGridCell(columnName: 'APK', value: wallet.getApk()),
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
            DataGridCell(columnName: 'Shop', value: wallet.getShop()),
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
          return Row(
            children: [
              Flexible(
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
              ),
            ],
          );
        } else if (dataCell.columnName == 'Icon') {
          // Assuming getIcon returns an asset path
          return Row(
            children: [
              Flexible(
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
              ),
            ],
          );
        } else if (dataCell.columnName == 'Score') {
          return Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    dataCell.value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      //color: Colors.white,
                      // color: getColorFromScore(
                      //     double.parse(dataCell.value.toString()), 11, 34),
                      // backgroundColor: const Color.fromARGB(255, 48, 55, 58),
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          );
        } else if (dataCell.columnName == 'Android') {
          String cellValue = dataCell.value.toString();

          // Check if the value is not 'N'
          if (cellValue != 'N') {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: MouseRegion(
                      cursor:
                          SystemMouseCursors.click, // Change cursor on hover
                      child: GestureDetector(
                        onTap: () {
                          _launchURL(cellValue); // Launch the URL on tap
                        },
                        child: Image.asset(
                            'assets/GooglePlay.png', // Load the AppStore SVG image from assets
                            width: 100, // Adjust width as needed
                            height: 100, // Adjust height as needed
                            fit: BoxFit.contain // Adjust the fit
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close,
                        color: Color.fromARGB(255, 255, 17, 0)),
                  ),
                ),
              ],
            );
          }
        } else if (dataCell.columnName == 'IOS') {
          String cellValue = dataCell.value.toString();

          // Check if the value is not 'N'
          if (cellValue != 'N') {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: MouseRegion(
                      cursor:
                          SystemMouseCursors.click, // Change cursor on hover
                      child: GestureDetector(
                        onTap: () {
                          _launchURL(cellValue); // Launch the URL on tap
                        },
                        child: SvgPicture.asset(
                          'assets/AppStore.svg', // Load the AppStore SVG image from assets
                          width: 50, // Adjust width as needed
                          height: 50, // Adjust height as needed
                          fit: BoxFit.contain, // Adjust the fit
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close,
                        color: Color.fromARGB(255, 255, 17, 0)),
                  ),
                ),
              ],
            );
          }
        } else if (dataCell.columnName == 'APK' ||
            dataCell.columnName == 'Windows' ||
            dataCell.columnName == 'MacOS' ||
            dataCell.columnName == 'Linux') {
          String cellValue = dataCell.value.toString();

          // Check if the value is not 'N'
          if (cellValue != 'N') {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: MouseRegion(
                      cursor:
                          SystemMouseCursors.click, // Change cursor on hover
                      child: GestureDetector(
                        onTap: () {
                          _launchURL(cellValue); // Launch the URL on tap
                        },
                        child: const Icon(Icons.download_rounded,
                            color: Color.fromARGB(255, 0, 232, 8)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Handle case where value is 'N'
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close,
                        color: Color.fromARGB(255, 255, 17, 0)),
                  ),
                ),
              ],
            );
          }
        } else {
          if (dataCell.value.toString() == "Y") {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Icon(Icons.check,
                        color: Color.fromARGB(255, 0, 232, 8)),
                  ),
                ),
              ],
            );
          } else if (dataCell.value.toString() == "N") {
            return Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close,
                        color: Color.fromARGB(255, 255, 17, 0)),
                  ),
                ),
              ],
            );
          } // For other columns, display the text
          return Row(
            children: [
              Flexible(
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
              ),
            ],
          );
        }
      }).toList(),
    );
  }
}

// Updated function to launch the URL
void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri,
        mode: LaunchMode.externalApplication); // External browser mode
  } else {
    throw 'Could not launch $url';
  }
}

// function to get the color based on a score
Color getColorFromScore(double score, double minScore, double maxScore) {
  // Normalize the score to a value between 0 and 1
  double normalizedScore = (score - minScore) / (maxScore - minScore);

  // Calculate the color on the green-to-red spectrum
  return Color.lerp(const Color.fromARGB(255, 27, 27, 27),
      const Color.fromARGB(255, 47, 255, 0), normalizedScore)!;
}

// Function to rank wallets and assign colors based on scores
Map<Wallet, Color> assignColorsToWallets(List<Wallet> wallets) {
  // Get the scores of all wallets
  List<double> scores =
      wallets.map((wallet) => wallet.getScore()).cast<double>().toList();

  // Find the minimum and maximum scores for normalization
  double minScore = scores.reduce((a, b) => a < b ? a : b);
  double maxScore = scores.reduce((a, b) => a > b ? a : b);

  // Create a map to hold wallet and its assigned color
  Map<Wallet, Color> walletColors = {};

  // Assign colors to wallets based on their scores
  for (var wallet in wallets) {
    double score = wallet.getScore() as double;
    Color color = getColorFromScore(score, minScore, maxScore);
    walletColors[wallet] = color;
  }

  return walletColors;
}

// This is a list to hold the currently displayed wallets
List<Wallet> results = [];

// This is a list that holds all of the wallets
List<Wallet> wallets = [
  alby,
  aqua,
  blink,
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
  //harbor,
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

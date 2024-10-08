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
      title: "Bitcoin Wallet Comparison",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;

  // Maintain the state of checkboxes
  List<bool> selectedOptions = List.generate(62, (index) => false);

  // Add a ScrollController to control the scrollbar
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Dispose the ScrollController to prevent memory leaks
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        toolbarHeight: 100.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 31, 31),
                Color.fromARGB(255, 44, 49, 51)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 4.0,
            shape: const CircleBorder(),
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logoCircle.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: Text(
          screenWidth > 529
              ? 'Bitcoin Wallet Comparison'
              : screenWidth > 384
                  ? 'Bitcoin\nWallet Comparison'
                  : 'Bitcoin\nWallet\nComparison',
          overflow: TextOverflow.fade,
          style: GoogleFonts.lato(
            fontSize: screenWidth > 529
                ? 30
                : screenWidth > 384
                    ? 25
                    : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          Tooltip(
            message: 'More Features Coming Soon (tm)',
            child: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.menu),
              color: const Color.fromARGB(255, 105, 105, 105),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Add a faint grey divider
          const Divider(
            color: Color.fromARGB(255, 105, 105, 105), // Faint grey line
            thickness: 0.5, // Adjust thickness as needed
            height: 0.5, // Remove default padding
          ),
          // Expandable Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 44, 49, 51),
                    Color.fromARGB(255, 48, 55, 58),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                //this rounds the edges of the container
                //borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: const Text(
                  'Filter and Sort',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        resetWallets();

                        // Map of filter indices to wallet methods
                        final filterMethods = {
                          0: (wallet) => wallet.getAndroid(),
                          1: (wallet) => wallet.getApk(),
                          2: (wallet) => wallet.getIos(),
                          3: (wallet) => wallet.getWindows(),
                          4: (wallet) => wallet.getMacos(),
                          5: (wallet) => wallet.getLinux(),
                          6: (wallet) => wallet.getUsa(),
                          7: (wallet) => wallet.getDarkMode(),
                          8: (wallet) => wallet.getMultiLanguage(),
                          9: (wallet) => wallet.getBtcOnly(),
                          10: (wallet) => wallet.getSelfCustody(),
                          11: (wallet) => wallet.getOpenSource(),
                          12: (wallet) => wallet.getNoKyc(),
                          13: (wallet) => wallet.getOwnNode(),
                          14: (wallet) => wallet.getTor(),
                          15: (wallet) => wallet.getMfa(),
                          16: (wallet) => wallet.getEncryptedBackup(),
                          17: (wallet) => wallet.getPlausibleDeniability(),
                          18: (wallet) => wallet.getInheritance(),
                          19: (wallet) => wallet.getOnChain(),
                          20: (wallet) => wallet.getPassphrase(),
                          21: (wallet) => wallet.getPaynym(),
                          22: (wallet) => wallet.getMultipleWallets(),
                          23: (wallet) => wallet.getWatchOnly(),
                          24: (wallet) => wallet.getMultisig(),
                          25: (wallet) => wallet.getHardwareWalletSupport(),
                          26: (wallet) => wallet.getCoinControl(),
                          27: (wallet) => wallet.getLabels(),
                          28: (wallet) => wallet.getNfc(),
                          29: (wallet) => wallet.getSilentPayments(),
                          30: (wallet) => wallet.getStonewall(),
                          31: (wallet) => wallet.getPayjoin(),
                          32: (wallet) => wallet.getPsbt(),
                          33: (wallet) => wallet.getRbf(),
                          34: (wallet) => wallet.getCpfp(),
                          35: (wallet) => wallet.getTaproot(),
                          36: (wallet) => wallet.getBatchTxs(),
                          37: (wallet) => wallet.getShowXpub(),
                          38: (wallet) => wallet.getLightningNetwork(),
                          39: (wallet) => wallet.getZaps(),
                          40: (wallet) => wallet.getLnurl(),
                          41: (wallet) => wallet.getBolt12(),
                          42: (wallet) => wallet.getMultiMint(),
                          43: (wallet) => wallet.getMultiLsp(),
                          44: (wallet) => wallet.getFedimint(),
                          45: (wallet) => wallet.getCashu(),
                          46: (wallet) => wallet.getLiquid(),
                          47: (wallet) => wallet.getUsdt(),
                          48: (wallet) => wallet.getTrampolineRouting(),
                          49: (wallet) => wallet.getNostr(),
                          50: (wallet) => wallet.getContacts(),
                          51: (wallet) => wallet.getBtcOverEmail(),
                          52: (wallet) => wallet.getPos(),
                          53: (wallet) => wallet.getUnifiedQr(),
                          54: (wallet) => wallet.getSignMessage(),
                          55: (wallet) => wallet.getTestnet(),
                          56: (wallet) => wallet.getSignet(),
                          57: (wallet) => wallet.getBuy(),
                          58: (wallet) => wallet.getSell(),
                          59: (wallet) => wallet.getShop(),
                          60: (wallet) => wallet.getSwaps(),
                          61: (wallet) => wallet.getAtomicSwaps(),
                        };

                        // Loop through list of filters
                        for (int i = 0; i < selectedOptions.length; i++) {
                          if (selectedOptions[i]) {
                            wallets.removeWhere(
                                (wallet) => filterMethods[i]!(wallet) == 'N');
                          }
                        }
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 249, 155, 40),
                      ),
                      child: const Text(
                        'Apply Filters',
                        //Make the text grey and bold
                        style: TextStyle(
                          color: Color.fromARGB(255, 44, 49, 51),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color.fromARGB(255, 105, 105, 105),
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
          if (isExpanded)
            Expanded(
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 249, 155, 40),
                  ), // Set thumb color
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  //make the scrollbar always visible
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
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
                        child: Column(
                          children: [
                            const Text(
                              'Select the features you want to filter and sort by:',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            // Grid of checkboxes
                            GridView.builder(
                              controller: _scrollController,
                              shrinkWrap:
                                  true, // Ensures the GridView doesn't take up infinite height
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filters.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenWidth > 1204
                                    ? 6
                                    : screenWidth > 1005
                                        ? 5
                                        : screenWidth > 806
                                            ? 4
                                            : screenWidth > 607
                                                ? 3
                                                : 2,
                                mainAxisSpacing: 6.0,
                                crossAxisSpacing: 6.0,
                                childAspectRatio:
                                    4, // Adjust aspect ratio to fit labels and checkboxes
                              ),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          fillColor: WidgetStateProperty
                                              .resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                              if (states.contains(
                                                  WidgetState.selected)) {
                                                return const Color.fromARGB(
                                                    255,
                                                    143,
                                                    72,
                                                    195); // Color when checked
                                              }
                                              return //default to clear
                                                  const Color.fromARGB(
                                                      0, 0, 0, 0);
                                            },
                                          ),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value: selectedOptions[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedOptions[index] =
                                                value ?? false;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        filters[index],
                                        style: const TextStyle(
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // DataGrid Section with Gradient Background
          Expanded(
            child: Container(
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
                isScrollbarAlwaysShown: true,
                columnWidthMode: ColumnWidthMode.none,
                frozenColumnsCount: 1,
                columns: [
                  for (String category in categories)
                    GridColumn(
                      columnName: category,
                      width: category == 'Hardware Wallet Support'
                          ? 120
                          : double.nan,
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
          ),
        ],
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'These projects update often.\nPlease report any updates/inaccuracies.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                      'https://primal.net/p/npub1fsndf82plzymhaptnjzzzpj8cwymqfu2j6hy62hrnv8nn6dxk85qvtuxeq',
                    );
                  },
                  child: Image.asset(
                    'assets/nostr.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                      'https://x.com/spencersmthsite',
                    );
                  },
                  child: Image.asset(
                    'assets/logo-white.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDataGridSource extends DataGridSource {
  final List<DataGridRow> _dataGridRows = [];

  CustomDataGridSource() {
    for (var wallet in sortByScoreDesc(wallets)) {
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

// // This is a list that holds all of the wallets
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

void resetWallets() {
  wallets = [
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
}

List<Wallet> sortByScoreAsc(List<Wallet> wallets) {
  wallets.sort((a, b) => a.getScore().compareTo(b.getScore()));
  return wallets;
}

List<Wallet> sortByScoreDesc(List<Wallet> wallets) {
  wallets.sort((a, b) => b.getScore().compareTo(a.getScore()));
  return wallets;
}

List<Wallet> filterForAndroid(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getAndroid() != 'N').toList();
}

List<Wallet> filterForApk(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getApk() != 'N').toList();
}

List<Wallet> filterForIos(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getIos() != 'N').toList();
}

List<Wallet> filterForWindows(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getWindows() != 'N').toList();
}

List<Wallet> filterForMacos(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMacos() != 'N').toList();
}

List<Wallet> filterForLinux(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getLinux() != 'N').toList();
}

List<Wallet> filterForUsa(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getUsa() != 'N').toList();
}

List<Wallet> filterForDarkMode(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getDarkMode() != 'N').toList();
}

List<Wallet> filterForMultiLanguage(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMultiLanguage() != 'N').toList();
}

List<Wallet> filterForBtcOnly(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getBtcOnly() != 'N').toList();
}

List<Wallet> filterForSelfCustody(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSelfCustody() != 'N').toList();
}

List<Wallet> filterForOpenSource(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getOpenSource() != 'N').toList();
}

List<Wallet> filterForNoKyc(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getNoKyc() != 'N').toList();
}

List<Wallet> filterForOwnNode(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getOwnNode() != 'N').toList();
}

List<Wallet> filterForTor(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getTor() != 'N').toList();
}

List<Wallet> filterForMfa(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMfa() != 'N').toList();
}

List<Wallet> filterForEncryptedBackup(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getEncryptedBackup() != 'N')
      .toList();
}

List<Wallet> filterForPlausibleDeniability(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getPlausibleDeniability() != 'N')
      .toList();
}

List<Wallet> filterForInheritance(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getInheritance() != 'N').toList();
}

List<Wallet> filterForOnChain(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getOnChain() != 'N').toList();
}

List<Wallet> filterForPassphrase(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getPassphrase() != 'N').toList();
}

List<Wallet> filterForPaynym(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getPaynym() != 'N').toList();
}

List<Wallet> filterForMultipleWallets(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getMultipleWallets() != 'N')
      .toList();
}

List<Wallet> filterForWatchOnly(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getWatchOnly() != 'N').toList();
}

List<Wallet> filterForMultisig(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMultisig() != 'N').toList();
}

List<Wallet> filterForHardwareWalletSupport(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getHardwareWalletSupport() != 'N')
      .toList();
}

List<Wallet> filterForCoinControl(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getCoinControl() != 'N').toList();
}

List<Wallet> filterForLabels(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getLabels() != 'N').toList();
}

List<Wallet> filterForNfc(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getNfc() != 'N').toList();
}

List<Wallet> filterForSilentPayments(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSilentPayments() != 'N').toList();
}

List<Wallet> filterForStonewall(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getStonewall() != 'N').toList();
}

List<Wallet> filterForPayjoin(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getPayjoin() != 'N').toList();
}

List<Wallet> filterForPsbt(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getPsbt() != 'N').toList();
}

List<Wallet> filterForRbf(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getRbf() != 'N').toList();
}

List<Wallet> filterForCpfp(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getCpfp() != 'N').toList();
}

List<Wallet> filterForTaproot(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getTaproot() != 'N').toList();
}

List<Wallet> filterForBatchTxs(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getBatchTxs() != 'N').toList();
}

List<Wallet> filterForShowXpub(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getShowXpub() != 'N').toList();
}

List<Wallet> filterForLightningNetwork(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getLightningNetwork() != 'N')
      .toList();
}

List<Wallet> filterForZaps(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getZaps() != 'N').toList();
}

List<Wallet> filterForLnurl(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getLnurl() != 'N').toList();
}

List<Wallet> filterForBolt12(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getBolt12() != 'N').toList();
}

List<Wallet> filterForMultiMint(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMultiMint() != 'N').toList();
}

List<Wallet> filterForMultiLsp(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getMultiLsp() != 'N').toList();
}

List<Wallet> filterForFedimint(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getFedimint() != 'N').toList();
}

List<Wallet> filterForCashu(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getCashu() != 'N').toList();
}

List<Wallet> filterForLiquid(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getLiquid() != 'N').toList();
}

List filterForUsdt(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getUsdt() != 'N').toList();
}

List filterForTrampolineRouting(List<Wallet> wallets) {
  return wallets
      .where((wallet) => wallet.getTrampolineRouting() != 'N')
      .toList();
}

List<Wallet> filterForNostr(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getNostr() != 'N').toList();
}

List<Wallet> filterForContacts(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getContacts() != 'N').toList();
}

List<Wallet> filterForBtcOverEmail(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getBtcOverEmail() != 'N').toList();
}

List<Wallet> filterForPos(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getPos() != 'N').toList();
}

List<Wallet> filterForUnifiedQr(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getUnifiedQr() != 'N').toList();
}

List<Wallet> filterForSignMessage(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSignMessage() != 'N').toList();
}

List<Wallet> filterForTestnet(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getTestnet() != 'N').toList();
}

List<Wallet> filterForSignet(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSignet() != 'N').toList();
}

List<Wallet> filterForBuy(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getBuy() != 'N').toList();
}

List<Wallet> filterForSell(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSell() != 'N').toList();
}

List<Wallet> filterForShop(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getShop() != 'N').toList();
}

List<Wallet> filterForSwaps(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getSwaps() != 'N').toList();
}

List<Wallet> filterForAtomicSwaps(List<Wallet> wallets) {
  return wallets.where((wallet) => wallet.getAtomicSwaps() != 'N').toList();
}

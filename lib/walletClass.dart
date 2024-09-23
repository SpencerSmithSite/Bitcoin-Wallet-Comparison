// This class holds the wallet criteria structure
class Wallet {
  final String name;
  final String icon;
  final String score;
  final String android;
  final String ios;
  final String windows;
  final String macos;
  final String linux;
  final String usa;
  final String darkMode;
  final String multiLanguage;
  final String btcOnly;
  final String selfCustody;
  final String openSource;
  final String noKyc;
  final String ownNode;
  final String tor;
  final String mfa;
  final String encryptedBackup;
  final String plausibleDeniability;
  final String inheritance;
  final String onChain;
  final String passphrase;
  final String paynym;
  final String multipleWallets;
  final String watchOnly;
  final String multisig;
  final String hardwareWalletSupport;
  final String coinControl;
  final String labels;
  final String nfc;
  final String silentPaymets;
  final String stonewall;
  final String payjoin;
  final String psbt;
  final String rbf;
  final String cpfp;
  final String taproot;
  final String batchTXs;
  final String showXpub;
  final String lightningNetwork;
  final String zaps;
  final String lnurl;
  final String bolt12;
  final String multiMint;
  final String multiLsp;
  final String fedimint;
  final String cashu;
  final String liquid;
  final String usdt;
  final String trampolineRouting;
  final String nostr;
  final String contacts;
  final String btcOverEmail;
  final String pos;
  final String unifiedQr;
  final String signMessage;
  final String testnet;
  final String signet;
  final String buy;
  final String sell;
  final String swaps;
  final String atomicSwaps;

  // Class constructor
  const Wallet({
    required this.name,
    required this.icon,
    required this.score,
    required this.android,
    required this.ios,
    required this.windows,
    required this.macos,
    required this.linux,
    required this.usa,
    required this.darkMode,
    required this.multiLanguage,
    required this.btcOnly,
    required this.selfCustody,
    required this.openSource,
    required this.noKyc,
    required this.ownNode,
    required this.tor,
    required this.mfa,
    required this.encryptedBackup,
    required this.plausibleDeniability,
    required this.inheritance,
    required this.onChain,
    required this.passphrase,
    required this.paynym,
    required this.multipleWallets,
    required this.watchOnly,
    required this.multisig,
    required this.hardwareWalletSupport,
    required this.coinControl,
    required this.labels,
    required this.nfc,
    required this.silentPaymets,
    required this.stonewall,
    required this.payjoin,
    required this.psbt,
    required this.rbf,
    required this.cpfp,
    required this.taproot,
    required this.batchTXs,
    required this.showXpub,
    required this.lightningNetwork,
    required this.zaps,
    required this.lnurl,
    required this.bolt12,
    required this.multiMint,
    required this.multiLsp,
    required this.fedimint,
    required this.cashu,
    required this.liquid,
    required this.usdt,
    required this.trampolineRouting,
    required this.nostr,
    required this.contacts,
    required this.btcOverEmail,
    required this.pos,
    required this.unifiedQr,
    required this.signMessage,
    required this.testnet,
    required this.signet,
    required this.buy,
    required this.sell,
    required this.swaps,
    required this.atomicSwaps,
  });

  // Getters:
  String getName() => name;
  String getIcon() => icon;
  String getScore() {
    int score = 0;
    if (getAndroid() != 'N') score++;
    if (getIos() != 'N') score++;
    if (getWindows() != 'N') score++;
    if (getMacos() != 'N') score++;
    if (getLinux() != 'N') score++;
    if (getUsa() != 'N') score++;
    if (getDarkMode() != 'N') score++;
    if (getMultiLanguage() != 'N') score++;
    if (getBtcOnly() != 'N') score++;
    if (getSelfCustody() != 'N') score++;
    if (getOpenSource() != 'N') score++;
    if (getNoKyc() != 'N') score++;
    if (getOwnNode() != 'N') score++;
    if (getTor() != 'N') score++;
    if (getMfa() != 'N') score++;
    if (getEncryptedBackup() != 'N') score++;
    if (getPlausibleDeniability() != 'N') score++;
    if (getInheritance() != 'N') score++;
    if (getOnChain() != 'N') score++;
    if (getPassphrase() != 'N') score++;
    if (getPaynym() != 'N') score++;
    if (getMultipleWallets() != 'N') score++;
    if (getWatchOnly() != 'N') score++;
    if (getMultisig() != 'N') score++;
    if (getHardwareWalletSupport() != 'N') score++;
    if (getCoinControl() != 'N') score++;
    if (getLabels() != 'N') score++;
    if (getNfc() != 'N') score++;
    if (getSilentPayments() != 'N') score++;
    if (getStonewall() != 'N') score++;
    if (getPayjoin() != 'N') score++;
    if (getPsbt() != 'N') score++;
    if (getRbf() != 'N') score++;
    if (getCpfp() != 'N') score++;
    if (getTaproot() != 'N') score++;
    if (getBatchTxs() != 'N') score++;
    if (getShowXpub() != 'N') score++;
    if (getLightningNetwork() != 'N') score++;
    if (getZaps() != 'N') score++;
    if (getLnurl() != 'N') score++;
    if (getBolt12() != 'N') score++;
    if (getMultiMint() != 'N') score++;
    if (getMultiLsp() != 'N') score++;
    if (getFedimint() != 'N') score++;
    if (getCashu() != 'N') score++;
    if (getLiquid() != 'N') score++;
    if (getUsdt() != 'N') score++;
    if (getTrampolineRouting() != 'N') score++;
    if (getNostr() != 'N') score++;
    if (getContacts() != 'N') score++;
    if (getBtcOverEmail() != 'N') score++;
    if (getPos() != 'N') score++;
    if (getUnifiedQr() != 'N') score++;
    if (getSignMessage() != 'N') score++;
    if (getTestnet() != 'N') score++;
    if (getSignet() != 'N') score++;
    if (getBuy() != 'N') score++;
    if (getSell() != 'N') score++;
    if (getSwaps() != 'N') score++;
    if (getAtomicSwaps() != 'N') score++;
    return score.toString();
  }

  String getAndroid() => android;
  String getIos() => ios;
  String getWindows() => windows;
  String getMacos() => macos;
  String getLinux() => linux;
  String getUsa() => usa;
  String getDarkMode() => darkMode;
  String getMultiLanguage() => multiLanguage;
  String getBtcOnly() => btcOnly;
  String getSelfCustody() => selfCustody;
  String getOpenSource() => openSource;
  String getNoKyc() => noKyc;
  String getOwnNode() => ownNode;
  String getTor() => tor;
  String getMfa() => mfa;
  String getEncryptedBackup() => encryptedBackup;
  String getPlausibleDeniability() => plausibleDeniability;
  String getInheritance() => inheritance;
  String getOnChain() => onChain;
  String getPassphrase() => passphrase;
  String getPaynym() => paynym;
  String getMultipleWallets() => multipleWallets;
  String getWatchOnly() => watchOnly;
  String getMultisig() => multisig;
  String getHardwareWalletSupport() => hardwareWalletSupport;
  String getCoinControl() => coinControl;
  String getLabels() => labels;
  String getNfc() => nfc;
  String getSilentPayments() => silentPaymets;
  String getStonewall() => stonewall;
  String getPayjoin() => payjoin;
  String getPsbt() => psbt;
  String getRbf() => rbf;
  String getCpfp() => cpfp;
  String getTaproot() => taproot;
  String getBatchTxs() => batchTXs;
  String getShowXpub() => showXpub;
  String getLightningNetwork() => lightningNetwork;
  String getZaps() => zaps;
  String getLnurl() => lnurl;
  String getBolt12() => bolt12;
  String getMultiMint() => multiMint;
  String getMultiLsp() => multiLsp;
  String getFedimint() => fedimint;
  String getCashu() => cashu;
  String getLiquid() => liquid;
  String getUsdt() => usdt;
  String getTrampolineRouting() => trampolineRouting;
  String getNostr() => nostr;
  String getContacts() => contacts;
  String getBtcOverEmail() => btcOverEmail;
  String getPos() => pos;
  String getUnifiedQr() => unifiedQr;
  String getSignMessage() => signMessage;
  String getTestnet() => testnet;
  String getSignet() => signet;
  String getBuy() => buy;
  String getSell() => sell;
  String getSwaps() => swaps;
  String getAtomicSwaps() => atomicSwaps;
}

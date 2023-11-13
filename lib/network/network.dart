class NetworkURL {
  static String server = "http://192.168.1.6/portal_berita";

  static String login() {
    return "$server/API/login.php";
  }

  static String registrasi() {
    return "$server/API/registrasi.php";
  }

  static String getProfil(String userid) {
    return "$server/API/profil.php?userid=$userid";
  }

  static String profilEdit() {
    return "$server/API/profilEdit.php";
  }

  static String profilEditGambar() {
    return "$server/API/profilEditGambar.php";
  }

  static String informasi() {
    return "$server/API/informasi.php";
  }

  static String informasiTambah() {
    return "$server/API/informasiTambah.php";
  }

  static String informasiEdit() {
    return "$server/API/informasiEdit.php";
  }

  static String informasiHapus() {
    return "$server/API/informasiHapus.php";
  }
}

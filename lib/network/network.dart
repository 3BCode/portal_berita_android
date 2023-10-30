class NetworkURL {
  static String server = "http://192.168.1.5/portal_berita";

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
}

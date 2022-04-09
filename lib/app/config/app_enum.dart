enum AppCurrencies { MAD, USD, EUR }
enum AppLanguages { en, fr }

class AppEnum {
  static Map<String, String> currencies = {
    AppCurrencies.MAD.name: r"DH",
    AppCurrencies.USD.name: r"$",
    AppCurrencies.EUR.name: r"€",
  };

  static Map<String, String> languages = {
    AppLanguages.en.name: "English",
    AppLanguages.fr.name: "Francais",
  };
}

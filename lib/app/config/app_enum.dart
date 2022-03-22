enum Currencies { MAD, USD, EUR }
enum Languages { English, Arabic, French }

class AppEnum {
  static Map<Currencies, String> currencies = {
    Currencies.MAD: "DH",
    Currencies.USD: r"$",
    Currencies.EUR: "€",
  };

  static Map<Languages, String> languages = {
    Languages.English: "English",
    Languages.Arabic: "Arabic",
    Languages.French: "French",
  };
}

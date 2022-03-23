enum Currencies { MAD, USD, EUR }
enum Languages { English, Arabic, French }

class AppEnum {
  static Map<String, String> currencies = {
    Currencies.MAD.name: "DH",
    Currencies.USD.name: r"$",
    Currencies.EUR.name: "€",
  };

  static Map<Languages, String> languages = {
    Languages.English: "English",
    Languages.Arabic: "Arabic",
    Languages.French: "French",
  };
}

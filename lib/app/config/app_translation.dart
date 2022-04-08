import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      AppLanguage.en_US.name: {
        AppKey.labelHome.name: "Home",
        AppKey.labelCategories.name: "Categories",
        AppKey.labelStatistic.name: "Statistic",
        AppKey.labelSettings.name: "Settings",
        AppKey.balance.name: "Balance",
        AppKey.incomes.name: "Incomes",
        AppKey.expenses.name: "Expenses",
        AppKey.newIncome.name: "New Income",
        AppKey.newExpenses.name: "New Expenses",
        AppKey.typeNewIncome.name: "Type New Income...",
        AppKey.typeNewExpenses.name: "Type New Expenses...",
        AppKey.labelCategory.name: "Category",
        AppKey.labelSave.name: "Save",
        AppKey.labelAdd.name: "Add",
        AppKey.labelUpdate.name: "Update",
        AppKey.messageUpdate.name: "Updated Successfully",
        AppKey.typeMessage.name: "Type Something...",
        AppKey.labelYesterday.name: "Yesterday",
        AppKey.labelToday.name: "Today",
        AppKey.labelTomorrow.name: "Tomorrow",
        AppKey.noDataFound.name: "No Data Found",
        AppKey.currencyLabel.name: "Currency",
      },
      AppLanguage.fr_FR.name: {
        AppKey.labelHome.name: "Home",
        AppKey.labelCategories.name: "Categories",
        AppKey.labelStatistic.name: "Statistic",
        AppKey.labelSettings.name: "Settings",
        AppKey.balance.name: "Balance",
        AppKey.incomes.name: "Incomes",
        AppKey.expenses.name: "Expenses",
        AppKey.newIncome.name: "New Income",
        AppKey.newExpenses.name: "New Expenses",
        AppKey.typeNewIncome.name: "Type New Income...",
        AppKey.typeNewExpenses.name: "Type New Expenses...",
        AppKey.labelCategory.name: "Category",
        AppKey.labelSave.name: "Save",
        AppKey.labelAdd.name: "Add",
        AppKey.labelUpdate.name: "Update",
        AppKey.messageUpdate.name: "Updated Successfully",
        AppKey.typeMessage.name: "Type Something...",
        AppKey.labelYesterday.name: "Yesterday",
        AppKey.labelToday.name: "Today",
        AppKey.labelTomorrow.name: "Tomorrow",
        AppKey.noDataFound.name: "No Data Found",
        AppKey.currencyLabel.name: "Currency",
      },
      /*AppLanguage.fr_FR.name: {

      },*/
    };
  }
}

enum AppLanguage {
  en,
  US,
  en_US,
  English,
  fr,
  FR,
  fr_FR,
  Francais,
}

enum AppKey {
  labelHome,
  labelCategories,
  labelStatistic,
  labelSettings,
  balance,
  incomes,
  expenses,
  newIncome,
  newExpenses,
  typeNewIncome,
  typeNewExpenses,
  labelCategory,
  labelSave,
  labelAdd,
  labelUpdate,
  messageUpdate,
  typeMessage,
  labelYesterday,
  labelToday,
  labelTomorrow,
  noDataFound,
  currencyLabel,
}

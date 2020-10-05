class Language {
  final int id;
  final String name;
  final String flag;
  final String langugeCode;
  Language(this.id, this.name, this.flag, this.langugeCode);
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇫🇷", "Français", "fr"),
      Language(2, "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "English", "en"),
      Language(3, "🇪🇸", "Espagnol", "es"),
      Language(4, "🇹🇳", "العربية", "ar"),
    ];
  }
}

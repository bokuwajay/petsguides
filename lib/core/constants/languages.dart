class Language {
  final String label;
  final String languageCode;

  Language(this.label, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language("English", 'en'),
      Language("中文", 'zh'),
    ];
  }
}

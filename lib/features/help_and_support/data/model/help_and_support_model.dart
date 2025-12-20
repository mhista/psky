class HelpCategory {
  final String id;
  final String title;
  final List<HelpArticle> articles;

  HelpCategory({
    required this.id,
    required this.title,
    required this.articles,
  });
}

class HelpArticle {
  final String id;
  final String title;
  final String content;

  HelpArticle({
    required this.id,
    required this.title,
    required this.content,
  });
}



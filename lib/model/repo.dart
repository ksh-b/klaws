abstract class Repo {
  Repo(this.url);

  late String url;

  void setup({String path = "."});

}

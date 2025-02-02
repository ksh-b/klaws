abstract class Repo {
  Repo(this.url);

  String repo="";
  String url="";
  String name="";
  String description="";
  String id="";
  String latestZip="";
  String zipFolder="";
  String defaultBranch="";
  int lastUpdate=-1;

  void fetch();

}

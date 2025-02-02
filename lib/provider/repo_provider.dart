import 'package:klaws/model/source/repo.dart';
import 'package:klaws/repository/git/github.dart';

class RepoProvider {
  static Future<Repo?> getRepo(String url) async {
    var host = Uri.parse(url).host;
    if (host == "github.com") {
      return await Github(url).fetch();
    }
    return null;
  }
}

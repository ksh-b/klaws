import 'package:dio/dio.dart';
import 'package:klaws/model/source/repo.dart';
import 'package:path/path.dart' as path;

class Github extends Repo {
  Github(super.url);

  @override
  Future<Repo> fetch() async {
      var response = await Dio().get("https://api.github.com/repos/$repo");
      var dateString = response.data["updated_at"];
      lastUpdate = (DateTime.parse(dateString).millisecondsSinceEpoch / 1000).toInt();
      name = response.data["name"];
      description = response.data["description"];
      id = "gh${response.data["id"]}";
      repo = response.data["full_name"];
      url = response.data["html_url"];
      defaultBranch = response.data["default_branch"];
      zipFolder = "$name-$defaultBranch";
      latestZip= "https://github.com/$repo/archive/refs/heads/$defaultBranch.zip";
      return this;
  }
}

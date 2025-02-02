import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:klaws/model/source/repo.dart';
import 'package:path/path.dart' as path;


class Github implements Repo {

  @override
  String repo="";

  @override
  String url;

  Github({required this.url}) {
    repo = url.replaceAll("https://github.com/", "").replaceAll(".git", "");
    url = url;
  }

  @override
  Future<int> lastCommit() async {
    try {
      var response = await Dio().get("https://api.github.com/repos/$repo/commits");
      var dateString = response.data[0]["commit"]["committer"]["date"];
      return (DateTime.parse(dateString).millisecondsSinceEpoch / 1000).toInt();
    } catch (e) {
      return -1;
    }
  }

  @override
  String get latestZip => "https://github.com/$repo/archive/refs/heads/$defaultBranch.zip";

  @override
  String get id => "github/$repo";

  @override
  String get zipFolder => path.basenameWithoutExtension(repo);

  @override
  String get defaultBranch => "main";

  @override
  String name = "";

  @override
  String description = "";
}

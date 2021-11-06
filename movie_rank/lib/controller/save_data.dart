import 'dart:io';
import 'package:path_provider/path_provider.dart';

//Save and recover data locally.
class SaveData{
  //Get the local path.
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  //Attach the file name to the path.
  Future<File> _localFile(String fileIdPath) async {
    final path = await _localPath;
    return File('$path/TokenlabTMDB-$fileIdPath.txt');
  }

  //Write the file.
  Future<File> writeData(String data, String idPath) async {
    final file = await _localFile(idPath);

    return file.writeAsString(data);
  }

  //Read the file.
  Future<String> readData(String idPath) async {
    try {
      final file = await _localFile(idPath);

      final contents = await file.readAsString();

      return contents;
    } 
    //If encountering an error, log details on console and display an error message.
    catch (e) {
      print('save_data: - General Error: $e');
    }throw Exception('Failed to load movie list cached data.');
  }
}
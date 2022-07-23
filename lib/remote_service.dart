import './profile.dart';

import 'package:http/http.dart' as http;

class RemoteService{
  Future<List<Profile>?> getProfiles() async{
     var client = http.Client();
     var uri =Uri.parse('https://6165722bcb73ea001764200d.mockapi.io/short_video_profile');
     var response = await client.get(uri);
     if(response.statusCode==200){
       var json =response.body;
      return profileFromJson(json);
     }
  }
}


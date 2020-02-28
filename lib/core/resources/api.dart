import 'package:http/http.dart';
import 'package:latihan_crud_api/core/models/profile_models.dart';

class ApiService {
  final String baseUrl = "http://api.bengkelrobot.net:8001";
  Client client = new Client();
  
  Future<List<Profile>> getProfiles() async {
    final response = await client.get("$baseUrl/api/profile");
    if (response.statusCode == 200) {
      return profileFromJSON(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile profile) async {
    final response = await client.post(
      "$baseUrl/api/profile",
      headers: {"content-type": "application/json"},
      body: profileToJSON(profile)
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile profile) async {
    final response = await client.put(
      "$baseUrl/api/profile/${profile.id}",
      headers: {"content-type": "application/json"},
      body: profileToJSON(profile)
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      "$baseUrl/api/profile/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
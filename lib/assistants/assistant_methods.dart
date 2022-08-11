import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:users_app/assistants/request_assistant.dart';

import '../global/map_key.dart';
import '../global/global.dart';
import '../models/user_model.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${mapKey}';

    String humanReadableAddress = '';

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != 'Error Occurred, Failed. No Response.') {
      humanReadableAddress = requestResponse['results'][0]['formatted_address'];
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}

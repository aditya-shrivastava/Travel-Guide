import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/pandal.dart';

class Pandals with ChangeNotifier {
  List<Pandal> _pandals = [
    Pandal(
      id: "KP1",
      category: "North",
      description:
          "The pandal is located along the shore of Kumartuli Park River, closer to Sovabazar Launch Ghat",
      lat: 22.602105,
      lon: 88.362783,
      metro: "Sovabazar Metro",
      title: "Kumartuli Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/KP.jpg?alt=media&token=85710734-0289-47a0-81de-7661023475a5",
    ),
    Pandal(
      id: "BZ2",
      category: "North",
      description:
          "The Pandal is located along the shore of Bagbazar river in North Kolkata. The pandal is closer to Bagbazar Kolkata Circular Railway Station and Bagbaar Launch Ghat.",
      lat: 22.604967,
      lon: 88.366041,
      metro: "Shyambazar Metro",
      title: "Bagbazar",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/bb.jpg?alt=media&token=9ef5de61-1229-461b-8316-874c2a84c626",
    ),
    Pandal(
      id: "NS3",
      category: "North",
      description:
          "It is located in Nalin Sarkar street of North Kolkata. It is located closer to Sikdar Bagan Sadharan pandal.",
      lat: 22.594599,
      lon: 88.374601,
      metro: "Shyambazar Metro",
      title: "Nalin Sarkar Street",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/nss.jpg?alt=media&token=e745ff8b-3394-4e15-b649-c3f33ac1b609",
    ),
    Pandal(
      id: "ML4",
      category: "North",
      description: "It is located in Maniktala region of Kolkata.",
      lat: 22.585288,
      lon: 88.372176,
      metro: "Girish Park Metro",
      title: "Maniktala Chaltabagan Lohapatty",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/CB.jpg?alt=media&token=24a418f4-6676-4d8f-ba6b-0f2bde72d7a9",
    ),
    Pandal(
      id: "SBS5",
      category: "North",
      description:
          "It is located in the Sikdar Bagan street of Hati Bagan region of Kolkata.",
      lat: 22.596758,
      lon: 88.372337,
      metro: "Shyambazar Metro",
      title: "Sikdar Bagan Sadharan",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/SBS.jpg?alt=media&token=3bbf65f9-916a-4720-8e1e-3bc65f4828ae",
    ),
    Pandal(
      id: "SSS6",
      category: "North",
      description: "This pandal is located in Lake View Road of South Kolkata.",
      lat: 22.515849,
      lon: 22.515849,
      metro: "Sovabazar Metro",
      title: "Samaj Sebi Sangha",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/SSS.jpg?alt=media&token=3454b7f5-1cfe-48ce-a2b2-e99bfd4e8c45",
    ),
    Pandal(
      id: "BAS7",
      category: "South",
      description: "Located in Nepal Bhattacharjee street of South Kolkata.",
      lat: 22.517984,
      lon: 88.343718,
      metro: "Kalighat Metro",
      title: "Badamtala Ashar Sangha",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/BAS.jpg?alt=media&token=05af291d-2d53-4838-ad2c-4e1b76077204",
    ),
    Pandal(
      id: "SS8",
      category: "South",
      description:
          "The pandal is located in New Alipore of South Kolkata. The pandal is closer to NH 117 intersection.",
      lat: 22.509083,
      lon: 88.333942,
      metro: "Kalighat Metro",
      title: "Suruchi Sangha",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/SS.jpg?alt=media&token=751dc422-9bea-47e4-b64b-9e35c73b75e9",
    ),
    Pandal(
      id: "EEC9",
      category: "South",
      description:
          "It is located in Gariahat of South Kolkata. You can find Mandevilla Gardens and South Point Junior School closer to it.",
      lat: 22.521258,
      lon: 88.366563,
      metro: "Kalighat Metro",
      title: "Ekdalia Evergreen Club",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/EEG.jpg?alt=media&token=af493403-b1db-496d-a78d-c960fa823daf",
    ),
    Pandal(
      id: "JP10",
      category: "South",
      description: "This pandal is located in Jadavpur Thana of South Kolkata.",
      lat: 22.504532,
      lon: 88.365525,
      metro: "NULL",
      title: "Jodhpur Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/Jp.jpg?alt=media&token=0e041570-314b-4fc4-8936-0bb20bc0bffe",
    ),
    Pandal(
      id: "BSM11",
      category: "South",
      description:
          "It is located in Bosepukar, Kasba of South Kolkata. The pandal is closer to Bosepukar petrol pump.",
      lat: 22.51924,
      lon: 88.384979,
      metro: "Ballygunge Metro",
      title: "Bosepukur Sitala Mandir",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/BSM.jpg?alt=media&token=8abf5afc-bb15-4da9-86d0-662ab6123f81",
    ),
    Pandal(
      id: "DP12",
      category: "South",
      description: "It is located in Ballygunge region of Kolkata.",
      lat: 22.518513,
      lon: 88.353526,
      metro: "Ballygunge Metro",
      title: "Deshapriya Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/DP.jpg?alt=media&token=9c3cbd21-cb76-40ea-89a7-007c8c8f3676",
    ),
    Pandal(
      id: "HP13",
      category: "South",
      description:
          "It is located inside the Hindustan Park of Gariahat region. It is located close to the South Indian club.",
      lat: 22.517799,
      lon: 88.362013,
      metro: "NULL",
      title: "Hindustan Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/HP.jpg?alt=media&token=49f095ae-c43d-427a-9e94-4182e7328cdd",
    ),
    Pandal(
      id: "CS14",
      category: "Central",
      description:
          "The pandal is located in College Street of Central Kolkata. It is very closer to Kolkata University on Mahatma Gandhi Road.",
      lat: 22.574594,
      lon: 88.364502,
      metro: "Central Metro",
      title: "College Square",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/CS.jpg?alt=media&token=a505a8f6-bdd8-4585-a12b-7909c4f68ada",
    ),
    Pandal(
      id: "MAP15",
      category: "Central",
      description: "Right opposite to College Square on MG road.",
      lat: 22.577184,
      lon: 88.36071,
      metro: "Central Metro",
      title: "Mohammad Ali Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/MAP.jpg?alt=media&token=ef5e2ffa-0a49-46ee-acb2-af6a6335806c",
    ),
    Pandal(
      id: "SMS16",
      category: "Central",
      description:
          "Located in Bow Bazar region of Central Kolkata, closer to BB Gangulystreet. ",
      lat: 22.565931,
      lon: 88.365771,
      metro: "Central Metro",
      title: "Santosh Mitra Square",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/SMS.jpg?alt=media&token=5ca355ad-3a01-43b2-a150-2411472aff28",
    ),
    Pandal(
      id: "LTAB17",
      category: "East",
      description:
          "This pandal is located on the Lake Town Like Road. The pandal is located very close to Jaya Cinemas.",
      lat: 22.60454,
      lon: 88.40397,
      metro: "Belgachia Metro",
      title: "Lake Town Adhibasi Brinda",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/LTAB.jpg?alt=media&token=d135cb27-8743-4c5c-b811-b8c1dadc7743",
    ),
    Pandal(
      id: "SBSC18",
      category: "East",
      description:
          "The pandal is located closer to P S Lake Town on the Canal street.",
      lat: 22.598898,
      lon: 88.402936,
      metro: "NULL",
      title: "Sree Bhumi Sporting Club",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/SSC.jpg?alt=media&token=c61cf0b3-d4e0-4320-93c6-e8967b95cd34",
    ),
    Pandal(
      id: "TSD19",
      category: "East",
      description:
          "This pandal is located inside Gurudas Dutta Garden, which is in Surir Bagan.",
      lat: 22.594952,
      lon: 88.38534,
      metro: "Belgachia Metro",
      title: "Telengabagan Sarbojanin Durgotsab",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/TDP.jpg?alt=media&token=488cbba7-b72c-4774-ae80-3e4f14a438c7",
    ),
    Pandal(
      id: "DDP20",
      category: "East",
      description: "This pandal is located in South Dum Dum region of Kolkata.",
      lat: 22.609441,
      lon: 88.41642,
      metro: "Belgachia Metro",
      title: "Dum Dum Park",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutter-travel-guide.appspot.com/o/DDP.jpg?alt=media&token=e23c060d-c927-49d4-969b-19bfe3a384a0",
    ),
  ];

  List<Pandal> get pandals {
    return [..._pandals];
  }

  Pandal findById(String id) {
    Pandal _pandal = _pandals.firstWhere((pandal) => pandal.id == id);
    return _pandal;
  }

  void toggleFavorite(String id) {
    Pandal _pandal = _pandals.firstWhere((pandal) => pandal.id == id);
    _pandal.isFavorite = !_pandal.isFavorite;
    notifyListeners();
    if (_pandal.isFavorite) {
      var data = {
        'id': _pandal.id,
        'title': _pandal.title,
        'category': _pandal.category,
        'description': _pandal.description,
        'metro': _pandal.metro,
        'imageUrl': _pandal.imageUrl,
      };
      DBHelper.insert('favorite_pandals', data);
    }
  }

  Future<List<Pandal>> fetchFavoritePandals() async {
    List<Pandal> _favoritePandals;
    List<Map<String, dynamic>> data =
        await DBHelper.getData('favorite_pandals');

    _favoritePandals = data
        .map((item) => Pandal(
              id: item['id'],
              title: item['title'],
              category: item['category'],
              description: item['description'],
              metro: item['metro'],
              imageUrl: item['imageUrl'],
              lat: null,
              lon: null,
            ))
        .toList();

    _favoritePandals.forEach((item) {
      Pandal _pandal = findById(item.id);
      _pandal.isFavorite = true;
      notifyListeners();
    });
    return _favoritePandals;
  }
}

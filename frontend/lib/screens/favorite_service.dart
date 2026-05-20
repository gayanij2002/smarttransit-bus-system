import '../models/bus_model.dart';

class FavoriteService {
  static final List<BusModel> _favorites = [];

  static List<BusModel> getFavorites() {
    return _favorites;
  }

  static bool isFavorite(BusModel bus) {
    return _favorites.any((item) => item.id == bus.id);
  }

  static void toggleFavorite(BusModel bus) {
    if (isFavorite(bus)) {
      _favorites.removeWhere((item) => item.id == bus.id);
    } else {
      _favorites.add(bus);
    }
  }
}

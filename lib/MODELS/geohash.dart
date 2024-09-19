class Geohash {
  static const _base32 = '0123456789bcdefghjkmnpqrstuvwxyz';

  static String encode(double latitude, double longitude,
      {int precision = 10}) {
    final lat = _encode(latitude, -90.0, 90.0, 5);
    final lon = _encode(longitude, -180.0, 180.0, 5);

    String geohash = '';
    for (int i = 0; i < 5; i++) {
      int bit = 0;
      int hash = 0;
      for (int j = 0; j < 5; j++) {
        bit = (bit << 1) | ((lat[j] << 1) | lon[j]);
        hash = (hash << 1) | (lat[j] ^ lon[j]);
      }
      geohash += _base32[hash];
    }

    return geohash.substring(0, precision);
  }

  static List<int> _encode(double value, double min, double max, int bits) {
    final List<int> bitArray = List.filled(bits, 0);
    int bit = 0;
    int hash = 0;

    for (int i = 0; i < bits; i++) {
      double mid = (min + max) / 2;
      if (value > mid) {
        bit = 1;
        min = mid;
      } else {
        bit = 0;
        max = mid;
      }

      hash = (hash << 1) | bit;
      bitArray[i] = hash;
    }

    return bitArray;
  }

  static Map<String, double> decode(String geohash) {
    double latMin = -90.0, latMax = 90.0;
    double lonMin = -180.0, lonMax = 180.0;

    bool isLon = true;
    for (int i = 0; i < geohash.length; i++) {
      int index = _base32.indexOf(geohash[i]);
      for (int bit = 4; bit >= 0; bit--) {
        int bitValue = (index >> bit) & 1;
        if (isLon) {
          double mid = (lonMin + lonMax) / 2;
          if (bitValue == 1) {
            lonMin = mid;
          } else {
            lonMax = mid;
          }
        } else {
          double mid = (latMin + latMax) / 2;
          if (bitValue == 1) {
            latMin = mid;
          } else {
            latMax = mid;
          }
        }
        isLon = !isLon;
      }
    }

    double latitude = (latMin + latMax) / 2;
    double longitude = (lonMin + lonMax) / 2;

    return {'latitude': latitude, 'longitude': longitude};
  }
}

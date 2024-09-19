import 'dart:math';

List<Map<String, dynamic>> filterArrByProperties(
    List<Map<String, dynamic>> array, List<Map<String, dynamic>> properties) {
  return array.where((map) {
    return properties.every((prop) {
      return prop.entries.every((entry) {
        return map[entry.key] == entry.value;
      });
    });
  }).toList();
}

List<dynamic> removeDupes(List<dynamic> array) {
  Set<dynamic> uniqueSet = Set<dynamic>.from(array);
  return uniqueSet.toList();
}

List<Map<String, dynamic>> removeDupesByProperty(
    List<Map<String, dynamic>> array, String property) {
  Set<dynamic> seenValues = {};
  List<Map<String, dynamic>> result = [];

  for (var map in array) {
    var propValue = map[property];
    if (!seenValues.contains(propValue)) {
      seenValues.add(propValue);
      result.add(map);
    }
  }

  return result;
}

dynamic reduceArray(List<Map<String, dynamic>> array, String property) {
  if (array.isEmpty) return null;

  // Initialize the result based on the first item's property type
  var firstValue = array.first[property];
  dynamic result;

  if (firstValue is int) {
    result = 0;
  } else if (firstValue is double) {
    result = 0.0;
  } else if (firstValue is String) {
    result = '';
  } else {
    throw Exception('Unsupported property type');
  }

  // Iterate through the array and reduce the property values
  for (var map in array) {
    var value = map[property];
    if (value is int || value is double) {
      result += value;
    } else if (value is String) {
      result += value;
    } else {
      throw Exception('Unsupported property type');
    }
  }

  return result;
}

List<dynamic> shuffleArray(List<dynamic> array) {
  final random = Random();
  for (int i = array.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    // Swap array[i] with array[j]
    var temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

List<dynamic> sortArray(List<dynamic> array, {bool desc = false}) {
  // Define the comparison function
  int compare(dynamic a, dynamic b) {
    if (a is num && b is num) {
      // If both are numbers, compare numerically
      return a.compareTo(b);
    } else if (a is String && b is String) {
      // If both are strings, compare lexicographically
      return a.compareTo(b);
    } else {
      // For other types, convert to string and compare lexicographically
      return a.toString().compareTo(b.toString());
    }
  }

  // Sort the array using the comparison function
  array.sort(compare);

  // Reverse the array if descending order is required
  if (desc) {
    array = array.reversed.toList();
  }

  return array;
}

List<Map<String, dynamic>> sortArrayByProperty(
    List<Map<String, dynamic>> array, String property,
    {bool desc = false}) {
  // Define the comparison function
  int compare(Map<String, dynamic> a, Map<String, dynamic> b) {
    var aValue = a[property];
    var bValue = b[property];

    if (aValue is num && bValue is num) {
      // If both are numbers, compare numerically
      return aValue.compareTo(bValue);
    } else if (aValue is String && bValue is String) {
      // If both are strings, compare lexicographically
      return aValue.compareTo(bValue);
    } else {
      // For other types, convert to string and compare lexicographically
      return aValue.toString().compareTo(bValue.toString());
    }
  }

  // Sort the array using the comparison function
  array.sort(compare);

  // Reverse the array if descending order is required
  if (desc) {
    array = array.reversed.toList();
  }

  return array;
}

dynamic getMin(List<dynamic> array) {
  if (array.isEmpty) return null;

  dynamic minValue = array[0];

  for (var element in array) {
    if (element is num && minValue is num) {
      if (element < minValue) {
        minValue = element;
      }
    } else if (element is String && minValue is String) {
      if (element.compareTo(minValue) < 0) {
        minValue = element;
      }
    } else {
      // For other types, convert to string and compare lexicographically
      if (element.toString().compareTo(minValue.toString()) < 0) {
        minValue = element;
      }
    }
  }

  return minValue;
}

Map<String, dynamic>? getMinObj(
    List<Map<String, dynamic>> array, String property) {
  if (array.isEmpty) return null;

  Map<String, dynamic> minObj = array[0];
  dynamic minValue = minObj[property];

  for (var element in array) {
    if (element[property] == null) continue;
    dynamic currentValue = element[property];

    if (currentValue is num && minValue is num) {
      if (currentValue < minValue) {
        minObj = element;
        minValue = currentValue;
      }
    } else if (currentValue is String && minValue is String) {
      if (currentValue.compareTo(minValue) < 0) {
        minObj = element;
        minValue = currentValue;
      }
    } else {
      // For other types, convert to string and compare lexicographically
      if (currentValue.toString().compareTo(minValue.toString()) < 0) {
        minObj = element;
        minValue = currentValue;
      }
    }
  }

  return minObj;
}

dynamic getMax(List<dynamic> array) {
  if (array.isEmpty) return null;

  dynamic maxValue = array[0];

  for (var element in array) {
    if (element is num && maxValue is num) {
      if (element > maxValue) {
        maxValue = element;
      }
    } else if (element is String && maxValue is String) {
      if (element.compareTo(maxValue) > 0) {
        maxValue = element;
      }
    } else {
      // For other types, convert to string and compare lexicographically
      if (element.toString().compareTo(maxValue.toString()) > 0) {
        maxValue = element;
      }
    }
  }

  return maxValue;
}

Map<String, dynamic>? getMaxObj(
    List<Map<String, dynamic>> array, String property) {
  if (array.isEmpty) return null;

  Map<String, dynamic> maxObj = array[0];
  dynamic maxValue = maxObj[property];

  for (var element in array) {
    if (element[property] == null) continue;
    dynamic currentValue = element[property];

    if (currentValue is num && maxValue is num) {
      if (currentValue > maxValue) {
        maxObj = element;
        maxValue = currentValue;
      }
    } else if (currentValue is String && maxValue is String) {
      if (currentValue.compareTo(maxValue) > 0) {
        maxObj = element;
        maxValue = currentValue;
      }
    } else {
      // For other types, convert to string and compare lexicographically
      if (currentValue.toString().compareTo(maxValue.toString()) > 0) {
        maxObj = element;
        maxValue = currentValue;
      }
    }
  }

  return maxObj;
}

List<Map<String, dynamic>> replaceObjById(
    List<Map<String, dynamic>> array, String id, Map<String, dynamic> newObj) {
  // Iterate over the list with an index
  for (int i = 0; i < array.length; i++) {
    // Check if the current object has the matching ID
    if (array[i]['id'] == id) {
      // Replace the object at the current index with the new object
      array[i] = newObj;
      // Since IDs are unique, we can return the modified list immediately
      return array;
    }
  }
  // If no object with the matching ID was found, return the original list
  return array;
}

List<Map<String, dynamic>> removeObjById(
    List<Map<String, dynamic>> array, String id) {
  array.removeWhere((item) => item['id'] == id);
  return array;
}

List<Map<String, dynamic>> mapArrayByProperties(
    List<Map<String, dynamic>> array, List<String> properties) {
  // Create a new list to hold the mapped objects
  List<Map<String, dynamic>> mappedArray = [];

  // Iterate through each item in the array
  for (var item in array) {
    // Create a new map to hold the selected properties
    Map<String, dynamic> mappedItem = {};

    // Iterate through each property
    for (var property in properties) {
      // If the item contains the property, add it to the mapped item
      if (item.containsKey(property)) {
        mappedItem[property] = item[property];
      }
    }

    // Add the mapped item to the mapped array
    mappedArray.add(mappedItem);
  }

  // Return the mapped array
  return mappedArray;
}

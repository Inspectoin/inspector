/// Compares two version strings.
///
/// This function takes two version strings in the format "major.minor.patch"
/// and compares them lexicographically by their numeric parts.
///
/// The comparison is performed by splitting the version strings into their
/// respective components (major, minor, and patch versions) and comparing
/// these components as integers.
///
/// Returns:
/// - `1` if [version1] is greater than [version2].
/// - `-1` if [version1] is less than [version2].
/// - `0` if both versions are equal.
///
/// Example:
/// ```dart
/// print(compareVersions("1.2.1", "1.2.0")); // Output: 1
/// print(compareVersions("1.2.0", "1.2.1")); // Output: -1
/// print(compareVersions("1.2.1", "1.2.1")); // Output: 0
/// ```
///
int compareVersions(String version1, String version2) {
  // Split the version strings into their integer parts.
  List<int> v1Parts = version1.split('.').map(int.parse).toList();
  List<int> v2Parts = version2.split('.').map(int.parse).toList();

  // Compare each part of the version.
  for (int i = 0; i < v1Parts.length; i++) {
    if (v1Parts[i] > v2Parts[i]) {
      return 1; // version1 is greater
    } else if (v1Parts[i] < v2Parts[i]) {
      return -1; // version1 is less
    }
  }

  // If all parts are equal, return 0.
  return 0; // versions are equal
}


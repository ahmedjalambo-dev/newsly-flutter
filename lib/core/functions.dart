bool isURL(String input) {
  if (input.startsWith('http://') || input.startsWith('https://')) {
    return true;
  } else {
    return false;
  }
}

String extractFirstWord(String input) {
  // Define a regex pattern to match the first word before a comma or a space followed by a lowercase letter
  final regex = RegExp(r'^[^, ]+');

  // Find the first match in the input string
  final match = regex.firstMatch(input);

  // Return the matched group or an empty string if no match is found
  return match?.group(0) ?? '';
}

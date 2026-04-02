import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments[0] == 'help') {
    printUsage();
  } else if (arguments[0] == 'version') {
    print('Dartpedia CLI version $version!');
  } else if (arguments[0] == 'wikipedia') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  // If no arguments provided, ask user for input
  if (arguments == null || arguments.isEmpty) {
    print('Please provide the title of the article you want to search for.');
    // Wait for user input
    final inputStdin = stdin.readLineSync();

    // Abort operation if no input
    if (inputStdin == null || inputStdin.isEmpty) {
      print('No article title provided. Exiting...');
      return;
    }

    articleTitle = inputStdin;
  } else {
    // Join all arguments into a single string
    articleTitle = arguments.join(' ');
  }

  print('Searching for $articleTitle...');

  // Request wikipedia content
  final articleContent = await getWikipediaArticle(articleTitle);

  print(articleContent);
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}

Future<String> getWikipediaArticle(String articleTitle) async {
  // Prepare the HTTP request
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  // Make HTTP GET request
  final response = await http.get(url);

  // If success, return the body
  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Failed to load article "$articleTitle". Status code: ${response.statusCode}';
}

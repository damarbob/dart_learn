import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments[0] == 'help') {
    printUsage();
  } else if (arguments[0] == 'version') {
    print('Dartpedia CLI version $version!');
  } else if (arguments[0] == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments) {
  final String articleTitle;

  // If no arguments provided, ask user for input
  if (arguments == null || arguments.isEmpty) {
    print('Please provide the title of the article you want to search for.');
    // Wait for user input
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    // Join all arguments into a single string
    articleTitle = arguments.join(' ');
  }

  print('Searching for $articleTitle...');
  print('Found article: $articleTitle');
  print('(Article content of $articleTitle)');
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

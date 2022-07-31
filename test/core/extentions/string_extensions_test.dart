import 'package:flutter_test/flutter_test.dart';
import 'package:topics/src/core/core_lib.dart';

void main() {
  group('String.isNullOrEmpty tests', () {
    test('when text is has 1 char should return false', () {
      String? text = "a";
      var output = text.isNullOrEmpty();
      expect(false, output);
    });

    test('when text more than a word should return false', () {
      String? text = "this is a test scentance";
      var output = text.isNullOrEmpty();
      expect(false, output);
    });

    test('when text is all spaces should return true', () {
      String? text = "   ";
      var output = text.isNullOrEmpty();
      expect(true, output);
    });

    test('when text is null should return true', () {
      String? text = null;
      var output = text.isNullOrEmpty();
      expect(true, output);
    });
    test('when text is empty should return true', () {
      String? text = '';
      var output = text.isNullOrEmpty();
      expect(true, output);
    });
  });


  group('String.capitalize tests', () {
    test('when empty should return it empty', () {
      String letter = "";
      var output = letter.capitalize();
      expect('', output);
    });

    test('when 2 characters should return it captalized first letter', () {
      String letter = "dr";
      var output = letter.capitalize();
      expect('Dr', output);
    });

    test('when more than 2 characters should return it captalized first letter', () {
      String letter = 'Test';
      var output = letter.capitalize();
      expect('Test', output);
    });
  });


  group(' String.isContainsChar tests ', () {
    test('when string contains chars should return true', () {
      String letters = 'test';
      var output = letters.isContainsChar();
      expect(true, output);
    });

    test('when string contains chars & numbers should return true', () {
      String letters = '123Test123456';
      var output = letters.isContainsChar();
      expect(true, output);
    });

    test('when string not contains chars should return false', () {
      String letters = '123456';
      var output = letters.isContainsChar();
      expect(false, output);
    });

    test('when string is empty contains chars should return false', () {
      String letters = '';
      var output = letters.isContainsChar();
      expect(false, output);
    });

    test('when string is contains only one char should return true', () {
      String letters = 'a';
      var output = letters.isContainsChar();
      expect(true, output);
    });
  });


  group(' String.isContainsDigit tests ', () {
    test('when string contains numbers should return true', () {
      String letters = '123456';
      var output = letters.isContainsDigit();
      expect(true, output);
    });

    test('when string contains numbers & chars should return true', () {
      String letters = 'Pwss0erds1212132';
      var output = letters.isContainsDigit();
      expect(true, output);
    });

    test('when string contains numbers & chars should return true', () {
      String letters = '123Test123456';
      var output = letters.isContainsDigit();
      expect(true, output);
    });

    test('when string not contains numbers should return false', () {
      String letters = 'test no Numbers';
      var output = letters.isContainsDigit();
      expect(false, output);
    });

    test('when string is empty contains chars should return false', () {
      String letters = '';
      var output = letters.isContainsDigit();
      expect(false, output);
    });
    test('when string? is null contains chars should return false', () {
      String? letters = null;
      var output = letters.isContainsDigit();
      expect(false, output);
    });

    test('when string? is one digit should return true', () {
      String? letters = '1';
      var output = letters.isContainsDigit();
      expect(true, output);
    });
  });


  group(' String.isContainsChar tests ', () {
    test('when string.isMatchLength is in bound return true', () {
      String letters = '123456';
      var output = letters.isMatchLength(3, 6);
      expect(true, output);
    });
    test('when string.isMatchLength is out of bound return true', () {
      String letters = '123456789';
      var output = letters.isMatchLength(3, 6);
      expect(false, output);
    });
    test('when string.isMatchLength is input = empty bound return true', () {
      String letters = '';
      var output = letters.isMatchLength(0, 6);
      expect(true, output);
    });
    test('when string.isMatchLength is input = null bound return false', () {
      String? letters = null;
      var output = letters.isMatchLength(0, 6);
      expect(false, output);
    });
  });

}

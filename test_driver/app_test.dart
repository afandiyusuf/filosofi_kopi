import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Test Onboarding', () {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('make sure back not shown at start', () async {
      var isExist = await isPresent(find.byValueKey('back-button'), driver);
      expect(isExist,false);
    });
    test('make all element is present', () async{
      var titleExist = await isPresent(find.byValueKey('title'),driver);
      var descriptionExist = await isPresent(find.byValueKey('description'),driver);
      var iconExist = await isPresent(find.byValueKey('icon'), driver);
      var nextButton  = await isPresent(find.byValueKey('next-button'),driver);

      expect(titleExist, true);
      expect(descriptionExist, true);
      expect(iconExist, true);
      expect(nextButton,true);
    });

    test('tap next button', () async{
      driver.tap(find.byValueKey('next-button'));
      var titleExist = await isPresent(find.byValueKey('title'),driver);
      var backExist = await isPresent(find.byValueKey('back-button'), driver);
      expect(titleExist,true);
      expect(backExist,true);
      driver.tap(find.byValueKey('next-button'));
      titleExist = await isPresent(find.byValueKey('title'),driver);
      backExist = await isPresent(find.byValueKey('back-button'), driver);
      expect(titleExist,true);
      expect(backExist,true);
      driver.tap(find.byValueKey('next-button'));
      titleExist = await isPresent(find.byValueKey('title'),driver);
      backExist = await isPresent(find.byValueKey('back-button'), driver);
      expect(titleExist,false);
      expect(backExist,false);
    });
  });
}

Future<bool> isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}
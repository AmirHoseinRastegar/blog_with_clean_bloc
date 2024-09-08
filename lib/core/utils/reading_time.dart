int readingTimeCalculator(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  final readingTime =  wordCount /250;
  //ceil is for rounding the possible double reading time that can be returned to an
  //upper integer
  return readingTime.ceil();
}

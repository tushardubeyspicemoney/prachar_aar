import 'dart:typed_data';

class AppDownloader {
  static downloadImageFromBytesUnknown(Uint8List bytes, String fileName) async {
    // try {
    //   final blob = html.Blob(
    //     [bytes, 'image/jpeg '],
    //   );
    //   final urls = html.Url.createObjectUrlFromBlob(blob);
    //   final anchor = html.document.createElement('a') as html.AnchorElement
    //     ..href = urls
    //     ..style.display = 'none'
    //     ..download = '$fileName.jpg';
    //   html.document.body!.children.add(anchor);
    //
    //   // download
    //   anchor.click();
    //
    //   // cleanup
    //   html.document.body!.children.remove(anchor);
    //   html.Url.revokeObjectUrl(urls);
    // } catch (e) {
    //   print("..error..");
    // }
  }
}

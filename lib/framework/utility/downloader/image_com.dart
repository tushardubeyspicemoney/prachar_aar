import 'dart:typed_data';

external dynamic fetchAndResizeImage(String url);

class ImageResult {
  external ByteBuffer get buffer;

  external String get mimeType;
}

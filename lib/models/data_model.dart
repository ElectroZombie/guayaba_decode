class DataModel {
  Map<String, String> mUniAscii = {};
  Map<String, String> mAsciiUni = {};
  int firstPivot = 0;
  int gap = 0;

  DataModel(
      Map<String, String> mua, Map<String, String> mau, int fP, this.gap) {
    mUniAscii = mua;
    mAsciiUni = mau;
    firstPivot = fP;
  }
}

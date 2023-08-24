String limitString(String string, int length) {
  if (string.length < length) return string;

  return "${string.substring(0, length - 3)}...";
}

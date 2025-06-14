String sanitizeAreaName(String areaName) {
  return areaName
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll(RegExp(r'[.#$\[\]]'), '');
}

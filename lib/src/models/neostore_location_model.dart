class NeoStoreLocationModel {
  final String title;
  final String subtitle;
  final double longitude;
  final double lattitude;

  NeoStoreLocationModel({
    required this.title,
    required this.subtitle,
    required this.longitude,
    required this.lattitude,
  });
}

final List<NeoStoreLocationModel> locations = [
  NeoStoreLocationModel(
    title: "SKYLAND STORE",
    subtitle: '6335 Edgewood Road Resister town, MD 2113',
    lattitude: 39.37109315301579,
    longitude: -76.79930410272654,
  ),
  NeoStoreLocationModel(
    title: "WOODMOUNT STORE",
    subtitle: '9437 Pin Oak Drive South Plain field, NJ 07080',
    lattitude: 40.58509752954749,
    longitude: -74.40723763152197,
  ),
  NeoStoreLocationModel(
      title: "NATUFUR STORE",
      subtitle: '3798 Pennsylvania Avenue Brandon, FL 33510',
      lattitude: 40.5858736826476,
      longitude: -74.40609928480153),
  NeoStoreLocationModel(
    title: "LAVANDER STORE",
    subtitle: '9311 Garfield Avenue Hamburg, NY 14075',
    lattitude: 42.74205848320397,
    longitude: -78.8342783602829,
  ),
  NeoStoreLocationModel(
    title: 'FURNIMATT STORE',
    subtitle: '7346 Hanover Court Arlington, MA 02474',
    lattitude: 42.404959269197164,
    longitude: -71.14676325561149,
  ),
];

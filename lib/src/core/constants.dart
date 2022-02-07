import 'models/common/location.dart';

// Location related constants

const String tes = 'tes';
const String dniprovka = 'Dniprovka';
const String nicopol = 'Nicopol';
const String rogachik = 'Rogachik';
const String vasilivka = 'vasilivka';
const String zaporizhya = 'zaporizhya';
const Location locationTes = Location(lat: 47.5066, lon: 34.6325);
const Location locationDniprovka = Location(lat: 47.4307, lon: 34.6111);
const Location locationNicopol = Location(lat: 47.5692, lon: 34.3919);
const Location locationRogachik = Location(lat: 47.2435, lon: 34.3354);
const Location locationVasilivka = Location(lat: 47.4397, lon: 35.2695);
const Location locationZaporizhya = Location(lat: 47.8180, lon: 35.1804);

const List<String> locationsNames = [
  tes,
  dniprovka,
  nicopol,
  rogachik,
  vasilivka,
  zaporizhya,
];

const List<Location> locationsList = [
  locationTes,
  locationDniprovka,
  locationNicopol,
  locationRogachik,
  locationVasilivka,
  locationZaporizhya,
];

// Hive related constants

const String hiveBox = 'hive_box';
const int currentKey = 0;
const int historyKey = 1;
const int forecastKey = 2;

// Shared prefs constants

const String lastCurrentUpdateKey = 'prefs_last_current_update';
const String lastHistoryUpdateKey = 'prefs_last_history_update';
const String lastForecastUpdateKey = 'prefs_last_forecast_update';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/general/region_model.dart';

final availableRegionsProvider = Provider((ref) => [
      RegionModel(
          iso31661: "AD", englishName: "Andorra", nativeName: "Andorra"),
      RegionModel(
          iso31661: "AE",
          englishName: "United Arab Emirates",
          nativeName: "United Arab Emirates"),
      RegionModel(
          iso31661: "AG",
          englishName: "Antigua and Barbuda",
          nativeName: "Antigua & Barbuda"),
      RegionModel(
          iso31661: "AL", englishName: "Albania", nativeName: "Albania"),
      RegionModel(iso31661: "AO", englishName: "Angola", nativeName: "Angola"),
      RegionModel(
          iso31661: "AR", englishName: "Argentina", nativeName: "Argentina"),
      RegionModel(
          iso31661: "AT", englishName: "Austria", nativeName: "Austria"),
      RegionModel(
          iso31661: "AU", englishName: "Australia", nativeName: "Australia"),
      RegionModel(
          iso31661: "AZ", englishName: "Azerbaijan", nativeName: "Azerbaijan"),
      RegionModel(
          iso31661: "BA",
          englishName: "Bosnia and Herzegovina",
          nativeName: "Bosnia & Herzegovina"),
      RegionModel(
          iso31661: "BB", englishName: "Barbados", nativeName: "Barbados"),
      RegionModel(
          iso31661: "BE", englishName: "Belgium", nativeName: "Belgium"),
      RegionModel(
          iso31661: "BF",
          englishName: "Burkina Faso",
          nativeName: "Burkina Faso"),
      RegionModel(
          iso31661: "BG", englishName: "Bulgaria", nativeName: "Bulgaria"),
      RegionModel(
          iso31661: "BH", englishName: "Bahrain", nativeName: "Bahrain"),
      RegionModel(
          iso31661: "BM", englishName: "Bermuda", nativeName: "Bermuda"),
      RegionModel(
          iso31661: "BO", englishName: "Bolivia", nativeName: "Bolivia"),
      RegionModel(iso31661: "BR", englishName: "Brazil", nativeName: "Brazil"),
      RegionModel(
          iso31661: "BS", englishName: "Bahamas", nativeName: "Bahamas"),
      RegionModel(
          iso31661: "BY", englishName: "Belarus", nativeName: "Belarus"),
      RegionModel(iso31661: "BZ", englishName: "Belize", nativeName: "Belize"),
      RegionModel(iso31661: "CA", englishName: "Canada", nativeName: "Canada"),
      RegionModel(
          iso31661: "CD",
          englishName: "Congo",
          nativeName: "Democratic Republic of the Congo (Kinshasa)"),
      RegionModel(
          iso31661: "CH",
          englishName: "Switzerland",
          nativeName: "Switzerland"),
      RegionModel(
          iso31661: "CI",
          englishName: "Cote D'Ivoire",
          nativeName: "Côte d’Ivoire"),
      RegionModel(iso31661: "CL", englishName: "Chile", nativeName: "Chile"),
      RegionModel(
          iso31661: "CM", englishName: "Cameroon", nativeName: "Cameroon"),
      RegionModel(
          iso31661: "CO", englishName: "Colombia", nativeName: "Colombia"),
      RegionModel(
          iso31661: "CR", englishName: "Costa Rica", nativeName: "Costa Rica"),
      RegionModel(iso31661: "CU", englishName: "Cuba", nativeName: "Cuba"),
      RegionModel(
          iso31661: "CV", englishName: "Cape Verde", nativeName: "Cape Verde"),
      RegionModel(iso31661: "CY", englishName: "Cyprus", nativeName: "Cyprus"),
      RegionModel(
          iso31661: "CZ",
          englishName: "Czech Republic",
          nativeName: "Czech Republic"),
      RegionModel(
          iso31661: "DE", englishName: "Germany", nativeName: "Germany"),
      RegionModel(
          iso31661: "DK", englishName: "Denmark", nativeName: "Denmark"),
      RegionModel(
          iso31661: "DO",
          englishName: "Dominican Republic",
          nativeName: "Dominican Republic"),
      RegionModel(
          iso31661: "DZ", englishName: "Algeria", nativeName: "Algeria"),
      RegionModel(
          iso31661: "EC", englishName: "Ecuador", nativeName: "Ecuador"),
      RegionModel(
          iso31661: "EE", englishName: "Estonia", nativeName: "Estonia"),
      RegionModel(iso31661: "EG", englishName: "Egypt", nativeName: "Egypt"),
      RegionModel(iso31661: "ES", englishName: "Spain", nativeName: "Spain"),
      RegionModel(
          iso31661: "FI", englishName: "Finland", nativeName: "Finland"),
      RegionModel(iso31661: "FJ", englishName: "Fiji", nativeName: "Fiji"),
      RegionModel(iso31661: "FR", englishName: "France", nativeName: "France"),
      RegionModel(
          iso31661: "GB",
          englishName: "United Kingdom",
          nativeName: "United Kingdom"),
      RegionModel(
          iso31661: "GF",
          englishName: "French Guiana",
          nativeName: "French Guiana"),
      RegionModel(iso31661: "GH", englishName: "Ghana", nativeName: "Ghana"),
      RegionModel(
          iso31661: "GI", englishName: "Gibraltar", nativeName: "Gibraltar"),
      RegionModel(
          iso31661: "GP", englishName: "Guadaloupe", nativeName: "Guadeloupe"),
      RegionModel(
          iso31661: "GQ",
          englishName: "Equatorial Guinea",
          nativeName: "Equatorial Guinea"),
      RegionModel(iso31661: "GR", englishName: "Greece", nativeName: "Greece"),
      RegionModel(
          iso31661: "GT", englishName: "Guatemala", nativeName: "Guatemala"),
      RegionModel(iso31661: "GY", englishName: "Guyana", nativeName: "Guyana"),
      RegionModel(
          iso31661: "HK",
          englishName: "Hong Kong",
          nativeName: "Hong Kong SAR China"),
      RegionModel(
          iso31661: "HN", englishName: "Honduras", nativeName: "Honduras"),
      RegionModel(
          iso31661: "HR", englishName: "Croatia", nativeName: "Croatia"),
      RegionModel(
          iso31661: "HU", englishName: "Hungary", nativeName: "Hungary"),
      RegionModel(
          iso31661: "ID", englishName: "Indonesia", nativeName: "Indonesia"),
      RegionModel(
          iso31661: "IE", englishName: "Ireland", nativeName: "Ireland"),
      RegionModel(iso31661: "IL", englishName: "Israel", nativeName: "Israel"),
      RegionModel(iso31661: "IN", englishName: "India", nativeName: "India"),
      RegionModel(iso31661: "IQ", englishName: "Iraq", nativeName: "Iraq"),
      RegionModel(
          iso31661: "IS", englishName: "Iceland", nativeName: "Iceland"),
      RegionModel(iso31661: "IT", englishName: "Italy", nativeName: "Italy"),
      RegionModel(
          iso31661: "JM", englishName: "Jamaica", nativeName: "Jamaica"),
      RegionModel(iso31661: "JO", englishName: "Jordan", nativeName: "Jordan"),
      RegionModel(iso31661: "JP", englishName: "Japan", nativeName: "Japan"),
      RegionModel(iso31661: "KE", englishName: "Kenya", nativeName: "Kenya"),
      RegionModel(
          iso31661: "KR",
          englishName: "South Korea",
          nativeName: "South Korea"),
      RegionModel(iso31661: "KW", englishName: "Kuwait", nativeName: "Kuwait"),
      RegionModel(
          iso31661: "LB", englishName: "Lebanon", nativeName: "Lebanon"),
      RegionModel(
          iso31661: "LC", englishName: "St. Lucia", nativeName: "St. Lucia"),
      RegionModel(
          iso31661: "LI",
          englishName: "Liechtenstein",
          nativeName: "Liechtenstein"),
      RegionModel(
          iso31661: "LT", englishName: "Lithuania", nativeName: "Lithuania"),
      RegionModel(
          iso31661: "LU", englishName: "Luxembourg", nativeName: "Luxembourg"),
      RegionModel(iso31661: "LV", englishName: "Latvia", nativeName: "Latvia"),
      RegionModel(
          iso31661: "LY",
          englishName: "Libyan Arab Jamahiriya",
          nativeName: "Libya"),
      RegionModel(
          iso31661: "MA", englishName: "Morocco", nativeName: "Morocco"),
      RegionModel(iso31661: "MC", englishName: "Monaco", nativeName: "Monaco"),
      RegionModel(
          iso31661: "MD", englishName: "Moldova", nativeName: "Moldova"),
      RegionModel(
          iso31661: "ME", englishName: "Montenegro", nativeName: "Montenegro"),
      RegionModel(
          iso31661: "MG", englishName: "Madagascar", nativeName: "Madagascar"),
      RegionModel(
          iso31661: "MK", englishName: "Macedonia", nativeName: "Macedonia"),
      RegionModel(iso31661: "ML", englishName: "Mali", nativeName: "Mali"),
      RegionModel(iso31661: "MT", englishName: "Malta", nativeName: "Malta"),
      RegionModel(
          iso31661: "MU", englishName: "Mauritius", nativeName: "Mauritius"),
      RegionModel(iso31661: "MW", englishName: "Malawi", nativeName: "Malawi"),
      RegionModel(iso31661: "MX", englishName: "Mexico", nativeName: "Mexico"),
      RegionModel(
          iso31661: "MY", englishName: "Malaysia", nativeName: "Malaysia"),
      RegionModel(
          iso31661: "MZ", englishName: "Mozambique", nativeName: "Mozambique"),
      RegionModel(iso31661: "NE", englishName: "Niger", nativeName: "Niger"),
      RegionModel(
          iso31661: "NG", englishName: "Nigeria", nativeName: "Nigeria"),
      RegionModel(
          iso31661: "NI", englishName: "Nicaragua", nativeName: "Nicaragua"),
      RegionModel(
          iso31661: "NL",
          englishName: "Netherlands",
          nativeName: "Netherlands"),
      RegionModel(iso31661: "NO", englishName: "Norway", nativeName: "Norway"),
      RegionModel(
          iso31661: "NZ",
          englishName: "New Zealand",
          nativeName: "New Zealand"),
      RegionModel(iso31661: "OM", englishName: "Oman", nativeName: "Oman"),
      RegionModel(iso31661: "PA", englishName: "Panama", nativeName: "Panama"),
      RegionModel(iso31661: "PE", englishName: "Peru", nativeName: "Peru"),
      RegionModel(
          iso31661: "PF",
          englishName: "French Polynesia",
          nativeName: "French Polynesia"),
      RegionModel(
          iso31661: "PG",
          englishName: "Papua New Guinea",
          nativeName: "Papua New Guinea"),
      RegionModel(
          iso31661: "PH",
          englishName: "Philippines",
          nativeName: "Philippines"),
      RegionModel(
          iso31661: "PK", englishName: "Pakistan", nativeName: "Pakistan"),
      RegionModel(iso31661: "PL", englishName: "Poland", nativeName: "Poland"),
      RegionModel(
          iso31661: "PS",
          englishName: "Palestinian Territory",
          nativeName: "Palestinian Territories"),
      RegionModel(
          iso31661: "PT", englishName: "Portugal", nativeName: "Portugal"),
      RegionModel(
          iso31661: "PY", englishName: "Paraguay", nativeName: "Paraguay"),
      RegionModel(iso31661: "QA", englishName: "Qatar", nativeName: "Qatar"),
      RegionModel(
          iso31661: "RO", englishName: "Romania", nativeName: "Romania"),
      RegionModel(iso31661: "RS", englishName: "Serbia", nativeName: "Serbia"),
      RegionModel(iso31661: "RU", englishName: "Russia", nativeName: "Russia"),
      RegionModel(
          iso31661: "SA",
          englishName: "Saudi Arabia",
          nativeName: "Saudi Arabia"),
      RegionModel(
          iso31661: "SC", englishName: "Seychelles", nativeName: "Seychelles"),
      RegionModel(iso31661: "SE", englishName: "Sweden", nativeName: "Sweden"),
      RegionModel(
          iso31661: "SG", englishName: "Singapore", nativeName: "Singapore"),
      RegionModel(
          iso31661: "SI", englishName: "Slovenia", nativeName: "Slovenia"),
      RegionModel(
          iso31661: "SK", englishName: "Slovakia", nativeName: "Slovakia"),
      RegionModel(
          iso31661: "SM", englishName: "San Marino", nativeName: "San Marino"),
      RegionModel(
          iso31661: "SN", englishName: "Senegal", nativeName: "Senegal"),
      RegionModel(
          iso31661: "SV",
          englishName: "El Salvador",
          nativeName: "El Salvador"),
      RegionModel(
          iso31661: "TC",
          englishName: "Turks and Caicos Islands",
          nativeName: "Turks & Caicos Islands"),
      RegionModel(iso31661: "TD", englishName: "Chad", nativeName: "Chad"),
      RegionModel(
          iso31661: "TH", englishName: "Thailand", nativeName: "Thailand"),
      RegionModel(
          iso31661: "TN", englishName: "Tunisia", nativeName: "Tunisia"),
      RegionModel(iso31661: "TR", englishName: "Turkey", nativeName: "Turkey"),
      RegionModel(
          iso31661: "TT",
          englishName: "Trinidad and Tobago",
          nativeName: "Trinidad & Tobago"),
      RegionModel(iso31661: "TW", englishName: "Taiwan", nativeName: "Taiwan"),
      RegionModel(
          iso31661: "TZ", englishName: "Tanzania", nativeName: "Tanzania"),
      RegionModel(
          iso31661: "UA", englishName: "Ukraine", nativeName: "Ukraine"),
      RegionModel(iso31661: "UG", englishName: "Uganda", nativeName: "Uganda"),
      RegionModel(
          iso31661: "US",
          englishName: "United States of America",
          nativeName: "United States"),
      RegionModel(
          iso31661: "UY", englishName: "Uruguay", nativeName: "Uruguay"),
      RegionModel(
          iso31661: "VA", englishName: "Holy See", nativeName: "Vatican City"),
      RegionModel(
          iso31661: "VE", englishName: "Venezuela", nativeName: "Venezuela"),
      RegionModel(iso31661: "XK", englishName: "Kosovo", nativeName: "Kosovo"),
      RegionModel(iso31661: "YE", englishName: "Yemen", nativeName: "Yemen"),
      RegionModel(
          iso31661: "ZA",
          englishName: "South Africa",
          nativeName: "South Africa"),
      RegionModel(iso31661: "ZM", englishName: "Zambia", nativeName: "Zambia"),
      RegionModel(
          iso31661: "ZW", englishName: "Zimbabwe", nativeName: "Zimbabwe"),
    ]);

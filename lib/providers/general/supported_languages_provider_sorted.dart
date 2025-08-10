import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/general/spoken_language_model.dart';

final supportedLanguagesProvider = Provider<List<SpokenLanguageModel>>((ref) =>
    [
      SpokenLanguageModel(englishName: 'Abkhazian', iso6391: 'ab', name: ''),
      SpokenLanguageModel(englishName: 'Afar', iso6391: 'aa', name: ''),
      SpokenLanguageModel(
          englishName: 'Afrikaans', iso6391: 'af', name: 'Afrikaans'),
      SpokenLanguageModel(englishName: 'Akan', iso6391: 'ak', name: ''),
      SpokenLanguageModel(
          englishName: 'Albanian', iso6391: 'sq', name: 'shqip'),
      SpokenLanguageModel(englishName: 'Amharic', iso6391: 'am', name: ''),
      SpokenLanguageModel(
          englishName: 'Arabic', iso6391: 'ar', name: 'العربية'),
      SpokenLanguageModel(englishName: 'Aragonese', iso6391: 'an', name: ''),
      SpokenLanguageModel(englishName: 'Armenian', iso6391: 'hy', name: ''),
      SpokenLanguageModel(englishName: 'Assamese', iso6391: 'as', name: ''),
      SpokenLanguageModel(englishName: 'Avaric', iso6391: 'av', name: ''),
      SpokenLanguageModel(englishName: 'Avestan', iso6391: 'ae', name: ''),
      SpokenLanguageModel(englishName: 'Aymara', iso6391: 'ay', name: ''),
      SpokenLanguageModel(
          englishName: 'Azerbaijani', iso6391: 'az', name: 'Azərbaycan'),
      SpokenLanguageModel(
          englishName: 'Bambara', iso6391: 'bm', name: 'Bamanankan'),
      SpokenLanguageModel(englishName: 'Bashkir', iso6391: 'ba', name: ''),
      SpokenLanguageModel(
          englishName: 'Basque', iso6391: 'eu', name: 'euskera'),
      SpokenLanguageModel(
          englishName: 'Belarusian', iso6391: 'be', name: 'беларуская мова'),
      SpokenLanguageModel(englishName: 'Bengali', iso6391: 'bn', name: 'বাংলা'),
      SpokenLanguageModel(englishName: 'Bislama', iso6391: 'bi', name: ''),
      SpokenLanguageModel(
          englishName: 'Bosnian', iso6391: 'bs', name: 'Bosanski'),
      SpokenLanguageModel(englishName: 'Breton', iso6391: 'br', name: ''),
      SpokenLanguageModel(
          englishName: 'Bulgarian', iso6391: 'bg', name: 'български език'),
      SpokenLanguageModel(englishName: 'Burmese', iso6391: 'my', name: ''),
      SpokenLanguageModel(
          englishName: 'Cantonese', iso6391: 'cn', name: '广州话 / 廣州話'),
      SpokenLanguageModel(
          englishName: 'Catalan', iso6391: 'ca', name: 'Català'),
      SpokenLanguageModel(
          englishName: 'Chamorro', iso6391: 'ch', name: 'Finu\' Chamorro'),
      SpokenLanguageModel(englishName: 'Chechen', iso6391: 'ce', name: ''),
      SpokenLanguageModel(
          englishName: 'Chichewa; Nyanja', iso6391: 'ny', name: ''),
      SpokenLanguageModel(englishName: 'Chuvash', iso6391: 'cv', name: ''),
      SpokenLanguageModel(englishName: 'Cornish', iso6391: 'kw', name: ''),
      SpokenLanguageModel(englishName: 'Corsican', iso6391: 'co', name: ''),
      SpokenLanguageModel(englishName: 'Cree', iso6391: 'cr', name: ''),
      SpokenLanguageModel(
          englishName: 'Croatian', iso6391: 'hr', name: 'Hrvatski'),
      SpokenLanguageModel(englishName: 'Czech', iso6391: 'cs', name: 'Český'),
      SpokenLanguageModel(englishName: 'Danish', iso6391: 'da', name: 'Dansk'),
      SpokenLanguageModel(englishName: 'Divehi', iso6391: 'dv', name: ''),
      SpokenLanguageModel(
          englishName: 'Dutch', iso6391: 'nl', name: 'Nederlands'),
      SpokenLanguageModel(englishName: 'Dzongkha', iso6391: 'dz', name: ''),
      SpokenLanguageModel(
          englishName: 'English', iso6391: 'en', name: 'English'),
      SpokenLanguageModel(
          englishName: 'Esperanto', iso6391: 'eo', name: 'Esperanto'),
      SpokenLanguageModel(
          englishName: 'Estonian', iso6391: 'et', name: 'Eesti'),
      SpokenLanguageModel(englishName: 'Ewe', iso6391: 'ee', name: 'Èʋegbe'),
      SpokenLanguageModel(englishName: 'Faroese', iso6391: 'fo', name: ''),
      SpokenLanguageModel(englishName: 'Fijian', iso6391: 'fj', name: ''),
      SpokenLanguageModel(englishName: 'Finnish', iso6391: 'fi', name: 'suomi'),
      SpokenLanguageModel(
          englishName: 'French', iso6391: 'fr', name: 'Français'),
      SpokenLanguageModel(englishName: 'Frisian', iso6391: 'fy', name: ''),
      SpokenLanguageModel(
          englishName: 'Fulah', iso6391: 'ff', name: 'Fulfulde'),
      SpokenLanguageModel(englishName: 'Gaelic', iso6391: 'gd', name: ''),
      SpokenLanguageModel(
          englishName: 'Galician', iso6391: 'gl', name: 'Galego'),
      SpokenLanguageModel(englishName: 'Ganda', iso6391: 'lg', name: ''),
      SpokenLanguageModel(
          englishName: 'Georgian', iso6391: 'ka', name: 'ქართული'),
      SpokenLanguageModel(
          englishName: 'German', iso6391: 'de', name: 'Deutsch'),
      SpokenLanguageModel(
          englishName: 'Greek', iso6391: 'el', name: 'ελληνικά'),
      SpokenLanguageModel(englishName: 'Guarani', iso6391: 'gn', name: ''),
      SpokenLanguageModel(englishName: 'Gujarati', iso6391: 'gu', name: ''),
      SpokenLanguageModel(
          englishName: 'Haitian; Haitian Creole', iso6391: 'ht', name: ''),
      SpokenLanguageModel(englishName: 'Hausa', iso6391: 'ha', name: 'Hausa'),
      SpokenLanguageModel(
          englishName: 'Hebrew', iso6391: 'he', name: 'עִבְרִית'),
      SpokenLanguageModel(englishName: 'Herero', iso6391: 'hz', name: ''),
      SpokenLanguageModel(englishName: 'Hindi', iso6391: 'hi', name: 'हिन्दी'),
      SpokenLanguageModel(englishName: 'Hiri Motu', iso6391: 'ho', name: ''),
      SpokenLanguageModel(
          englishName: 'Hungarian', iso6391: 'hu', name: 'Magyar'),
      SpokenLanguageModel(
          englishName: 'Icelandic', iso6391: 'is', name: 'Íslenska'),
      SpokenLanguageModel(englishName: 'Ido', iso6391: 'io', name: ''),
      SpokenLanguageModel(englishName: 'Igbo', iso6391: 'ig', name: ''),
      SpokenLanguageModel(
          englishName: 'Indonesian', iso6391: 'id', name: 'Bahasa indonesia'),
      SpokenLanguageModel(englishName: 'Interlingua', iso6391: 'ia', name: ''),
      SpokenLanguageModel(englishName: 'Interlingue', iso6391: 'ie', name: ''),
      SpokenLanguageModel(englishName: 'Inuktitut', iso6391: 'iu', name: ''),
      SpokenLanguageModel(englishName: 'Inupiaq', iso6391: 'ik', name: ''),
      SpokenLanguageModel(englishName: 'Irish', iso6391: 'ga', name: 'Gaeilge'),
      SpokenLanguageModel(
          englishName: 'Italian', iso6391: 'it', name: 'Italiano'),
      SpokenLanguageModel(englishName: 'Japanese', iso6391: 'ja', name: '日本語'),
      SpokenLanguageModel(englishName: 'Javanese', iso6391: 'jv', name: ''),
      SpokenLanguageModel(englishName: 'Kalaallisut', iso6391: 'kl', name: ''),
      SpokenLanguageModel(englishName: 'Kannada', iso6391: 'kn', name: '?????'),
      SpokenLanguageModel(englishName: 'Kanuri', iso6391: 'kr', name: ''),
      SpokenLanguageModel(englishName: 'Kashmiri', iso6391: 'ks', name: ''),
      SpokenLanguageModel(englishName: 'Kazakh', iso6391: 'kk', name: 'қазақ'),
      SpokenLanguageModel(englishName: 'Khmer', iso6391: 'km', name: ''),
      SpokenLanguageModel(englishName: 'Kikuyu', iso6391: 'ki', name: ''),
      SpokenLanguageModel(
          englishName: 'Kinyarwanda', iso6391: 'rw', name: 'Kinyarwanda'),
      SpokenLanguageModel(
          englishName: 'Kirghiz', iso6391: 'ky', name: '??????'),
      SpokenLanguageModel(englishName: 'Komi', iso6391: 'kv', name: ''),
      SpokenLanguageModel(englishName: 'Kongo', iso6391: 'kg', name: ''),
      SpokenLanguageModel(
          englishName: 'Korean', iso6391: 'ko', name: '한국어/조선말'),
      SpokenLanguageModel(englishName: 'Kuanyama', iso6391: 'kj', name: ''),
      SpokenLanguageModel(englishName: 'Kurdish', iso6391: 'ku', name: ''),
      SpokenLanguageModel(englishName: 'Lao', iso6391: 'lo', name: ''),
      SpokenLanguageModel(englishName: 'Latin', iso6391: 'la', name: 'Latin'),
      SpokenLanguageModel(
          englishName: 'Latvian', iso6391: 'lv', name: 'Latviešu'),
      SpokenLanguageModel(
          englishName: 'Letzeburgesch', iso6391: 'lb', name: ''),
      SpokenLanguageModel(englishName: 'Limburgish', iso6391: 'li', name: ''),
      SpokenLanguageModel(englishName: 'Lingala', iso6391: 'ln', name: ''),
      SpokenLanguageModel(
          englishName: 'Lithuanian', iso6391: 'lt', name: 'Lietuvių'),
      SpokenLanguageModel(englishName: 'Luba-Katanga', iso6391: 'lu', name: ''),
      SpokenLanguageModel(englishName: 'Macedonian', iso6391: 'mk', name: ''),
      SpokenLanguageModel(englishName: 'Malagasy', iso6391: 'mg', name: ''),
      SpokenLanguageModel(
          englishName: 'Malay', iso6391: 'ms', name: 'Bahasa melayu'),
      SpokenLanguageModel(englishName: 'Malayalam', iso6391: 'ml', name: ''),
      SpokenLanguageModel(englishName: 'Maltese', iso6391: 'mt', name: 'Malti'),
      SpokenLanguageModel(englishName: 'Mandarin', iso6391: 'zh', name: '普通话'),
      SpokenLanguageModel(englishName: 'Manx', iso6391: 'gv', name: ''),
      SpokenLanguageModel(englishName: 'Maori', iso6391: 'mi', name: ''),
      SpokenLanguageModel(englishName: 'Marathi', iso6391: 'mr', name: ''),
      SpokenLanguageModel(englishName: 'Marshall', iso6391: 'mh', name: ''),
      SpokenLanguageModel(englishName: 'Moldavian', iso6391: 'mo', name: ''),
      SpokenLanguageModel(englishName: 'Mongolian', iso6391: 'mn', name: ''),
      SpokenLanguageModel(englishName: 'Nauru', iso6391: 'na', name: ''),
      SpokenLanguageModel(englishName: 'Navajo', iso6391: 'nv', name: ''),
      SpokenLanguageModel(englishName: 'Ndebele', iso6391: 'nr', name: ''),
      SpokenLanguageModel(englishName: 'Ndebele', iso6391: 'nd', name: ''),
      SpokenLanguageModel(englishName: 'Ndonga', iso6391: 'ng', name: ''),
      SpokenLanguageModel(englishName: 'Nepali', iso6391: 'ne', name: ''),
      SpokenLanguageModel(
          englishName: 'No Language', iso6391: 'xx', name: 'No Language'),
      SpokenLanguageModel(
          englishName: 'Northern Sami', iso6391: 'se', name: ''),
      SpokenLanguageModel(
          englishName: 'Norwegian', iso6391: 'no', name: 'Norsk'),
      SpokenLanguageModel(
          englishName: 'Norwegian Bokmål', iso6391: 'nb', name: 'Bokmål'),
      SpokenLanguageModel(
          englishName: 'Norwegian Nynorsk', iso6391: 'nn', name: ''),
      SpokenLanguageModel(englishName: 'Occitan', iso6391: 'oc', name: ''),
      SpokenLanguageModel(englishName: 'Ojibwa', iso6391: 'oj', name: ''),
      SpokenLanguageModel(englishName: 'Oriya', iso6391: 'or', name: ''),
      SpokenLanguageModel(englishName: 'Oromo', iso6391: 'om', name: ''),
      SpokenLanguageModel(
          englishName: 'Ossetian; Ossetic', iso6391: 'os', name: ''),
      SpokenLanguageModel(englishName: 'Pali', iso6391: 'pi', name: ''),
      SpokenLanguageModel(englishName: 'Persian', iso6391: 'fa', name: 'فارسی'),
      SpokenLanguageModel(englishName: 'Polish', iso6391: 'pl', name: 'Polski'),
      SpokenLanguageModel(
          englishName: 'Portuguese', iso6391: 'pt', name: 'Português'),
      SpokenLanguageModel(
          englishName: 'Punjabi', iso6391: 'pa', name: 'ਪੰਜਾਬੀ'),
      SpokenLanguageModel(englishName: 'Pushto', iso6391: 'ps', name: 'پښتو'),
      SpokenLanguageModel(englishName: 'Quechua', iso6391: 'qu', name: ''),
      SpokenLanguageModel(
          englishName: 'Raeto-Romance', iso6391: 'rm', name: ''),
      SpokenLanguageModel(
          englishName: 'Romanian', iso6391: 'ro', name: 'Română'),
      SpokenLanguageModel(englishName: 'Rundi', iso6391: 'rn', name: 'Kirundi'),
      SpokenLanguageModel(
          englishName: 'Russian', iso6391: 'ru', name: 'Pусский'),
      SpokenLanguageModel(englishName: 'Samoan', iso6391: 'sm', name: ''),
      SpokenLanguageModel(englishName: 'Sango', iso6391: 'sg', name: ''),
      SpokenLanguageModel(englishName: 'Sanskrit', iso6391: 'sa', name: ''),
      SpokenLanguageModel(englishName: 'Sardinian', iso6391: 'sc', name: ''),
      SpokenLanguageModel(
          englishName: 'Serbian', iso6391: 'sr', name: 'Srpski'),
      SpokenLanguageModel(
          englishName: 'Serbo-Croatian', iso6391: 'sh', name: ''),
      SpokenLanguageModel(englishName: 'Shona', iso6391: 'sn', name: ''),
      SpokenLanguageModel(englishName: 'Sindhi', iso6391: 'sd', name: ''),
      SpokenLanguageModel(
          englishName: 'Sinhalese', iso6391: 'si', name: 'සිංහල'),
      SpokenLanguageModel(englishName: 'Slavic', iso6391: 'cu', name: ''),
      SpokenLanguageModel(
          englishName: 'Slovak', iso6391: 'sk', name: 'Slovenčina'),
      SpokenLanguageModel(
          englishName: 'Slovenian', iso6391: 'sl', name: 'Slovenščina'),
      SpokenLanguageModel(englishName: 'Somali', iso6391: 'so', name: 'Somali'),
      SpokenLanguageModel(englishName: 'Sotho', iso6391: 'st', name: ''),
      SpokenLanguageModel(
          englishName: 'Spanish', iso6391: 'es', name: 'Español'),
      SpokenLanguageModel(englishName: 'Sundanese', iso6391: 'su', name: ''),
      SpokenLanguageModel(
          englishName: 'Swahili', iso6391: 'sw', name: 'Kiswahili'),
      SpokenLanguageModel(englishName: 'Swati', iso6391: 'ss', name: ''),
      SpokenLanguageModel(
          englishName: 'Swedish', iso6391: 'sv', name: 'svenska'),
      SpokenLanguageModel(englishName: 'Tagalog', iso6391: 'tl', name: ''),
      SpokenLanguageModel(englishName: 'Tahitian', iso6391: 'ty', name: ''),
      SpokenLanguageModel(englishName: 'Tajik', iso6391: 'tg', name: ''),
      SpokenLanguageModel(englishName: 'Tamil', iso6391: 'ta', name: 'தமிழ்'),
      SpokenLanguageModel(englishName: 'Tatar', iso6391: 'tt', name: ''),
      SpokenLanguageModel(englishName: 'Telugu', iso6391: 'te', name: 'తెలుగు'),
      SpokenLanguageModel(englishName: 'Thai', iso6391: 'th', name: 'ภาษาไทย'),
      SpokenLanguageModel(englishName: 'Tibetan', iso6391: 'bo', name: ''),
      SpokenLanguageModel(englishName: 'Tigrinya', iso6391: 'ti', name: ''),
      SpokenLanguageModel(englishName: 'Tonga', iso6391: 'to', name: ''),
      SpokenLanguageModel(englishName: 'Tsonga', iso6391: 'ts', name: ''),
      SpokenLanguageModel(englishName: 'Tswana', iso6391: 'tn', name: ''),
      SpokenLanguageModel(
          englishName: 'Turkish', iso6391: 'tr', name: 'Türkçe'),
      SpokenLanguageModel(englishName: 'Turkmen', iso6391: 'tk', name: ''),
      SpokenLanguageModel(englishName: 'Twi', iso6391: 'tw', name: ''),
      SpokenLanguageModel(englishName: 'Uighur', iso6391: 'ug', name: ''),
      SpokenLanguageModel(
          englishName: 'Ukrainian', iso6391: 'uk', name: 'Український'),
      SpokenLanguageModel(englishName: 'Urdu', iso6391: 'ur', name: 'اردو'),
      SpokenLanguageModel(englishName: 'Uzbek', iso6391: 'uz', name: 'ozbek'),
      SpokenLanguageModel(englishName: 'Venda', iso6391: 've', name: ''),
      SpokenLanguageModel(
          englishName: 'Vietnamese', iso6391: 'vi', name: 'Tiếng Việt'),
      SpokenLanguageModel(englishName: 'Volapük', iso6391: 'vo', name: ''),
      SpokenLanguageModel(englishName: 'Walloon', iso6391: 'wa', name: ''),
      SpokenLanguageModel(englishName: 'Welsh', iso6391: 'cy', name: 'Cymraeg'),
      SpokenLanguageModel(englishName: 'Wolof', iso6391: 'wo', name: 'Wolof'),
      SpokenLanguageModel(englishName: 'Xhosa', iso6391: 'xh', name: ''),
      SpokenLanguageModel(englishName: 'Yi', iso6391: 'ii', name: ''),
      SpokenLanguageModel(englishName: 'Yiddish', iso6391: 'yi', name: ''),
      SpokenLanguageModel(
          englishName: 'Yoruba', iso6391: 'yo', name: 'Èdè Yorùbá'),
      SpokenLanguageModel(englishName: 'Zhuang', iso6391: 'za', name: ''),
      SpokenLanguageModel(englishName: 'Zulu', iso6391: 'zu', name: 'isiZulu')
    ]);

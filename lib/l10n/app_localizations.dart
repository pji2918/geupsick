import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @menu.
  ///
  /// In ko, this message translates to:
  /// **'메뉴'**
  String get menu;

  /// No description provided for @getAiApiKey.
  ///
  /// In ko, this message translates to:
  /// **'AI API 키를 얻으려면 '**
  String get getAiApiKey;

  /// No description provided for @clickHere.
  ///
  /// In ko, this message translates to:
  /// **'여기를 누르세요.'**
  String get clickHere;

  /// No description provided for @schoolNotSelectedTitle.
  ///
  /// In ko, this message translates to:
  /// **'학교가 선택되지 않았습니다'**
  String get schoolNotSelectedTitle;

  /// No description provided for @schoolNotSelectedDesc.
  ///
  /// In ko, this message translates to:
  /// **'학교를 선택하여 시작하세요.'**
  String get schoolNotSelectedDesc;

  /// OK.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get ok;

  /// Cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// 앱의 정보를 표시하는 버튼
  ///
  /// In ko, this message translates to:
  /// **'정보'**
  String get about;

  /// G-Score 설정 섹션 제목
  ///
  /// In ko, this message translates to:
  /// **'G-Score'**
  String get gscoreSection;

  /// No description provided for @generalSection.
  ///
  /// In ko, this message translates to:
  /// **'일반'**
  String get generalSection;

  /// No description provided for @aboutDesc.
  ///
  /// In ko, this message translates to:
  /// **'앱의 정보를 표시합니다.'**
  String get aboutDesc;

  /// No description provided for @goBack.
  ///
  /// In ko, this message translates to:
  /// **'뒤로 가기'**
  String get goBack;

  /// 설정 창에서 AI API 키를 설정하는 버튼의 제목
  ///
  /// In ko, this message translates to:
  /// **'AI API 키'**
  String get aiApiKeyTitle;

  /// 설정 창에서 AI API 키를 설정하는 버튼의 설명
  ///
  /// In ko, this message translates to:
  /// **'AI API 키를 설정합니다.'**
  String get aiApiKeyDesc;

  /// 설정 창에서 AI API 키를 설정하는 TextField의 Placeholder
  ///
  /// In ko, this message translates to:
  /// **'AI API 키를 여기에 입력하세요'**
  String get aiApiKeyPlaceHolder;

  /// OpenAI 호환 제공자 설정 항목입니다.
  ///
  /// In ko, this message translates to:
  /// **'OpenAI 호환'**
  String get openAICompatible;

  /// G-Score 사용 여부 제어 스위치 제목
  ///
  /// In ko, this message translates to:
  /// **'G-Score 사용'**
  String get useGScore;

  /// G-Score 사용 여부 제어 스위치 설명
  ///
  /// In ko, this message translates to:
  /// **'G-Score (급식 평가 시스템) 사용 여부를 설정합니다.'**
  String get useGScoreDesc;

  /// 설정 페이지에서 뜨는 헤더
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings;

  /// "급식"을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'급식'**
  String get geupsick;

  /// 학교를 선택하는 버튼입니다.
  ///
  /// In ko, this message translates to:
  /// **'학교 선택'**
  String get schoolSelect;

  /// 날짜를 선택하는 버튼입니다.
  ///
  /// In ko, this message translates to:
  /// **'날짜 선택'**
  String get dateSelect;

  /// 아침 식사를 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'아침'**
  String get breakfast;

  /// 점심 식사를 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'점심'**
  String get lunch;

  /// 저녁 식사를 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'저녁'**
  String get dinner;

  /// 시도교육청을 선택하는 드롭다운입니다.
  ///
  /// In ko, this message translates to:
  /// **'시도교육청 선택'**
  String get ministrySelection;

  /// 학교 검색 필드에 있는 Placeholder입니다.
  ///
  /// In ko, this message translates to:
  /// **'학교 이름을 입력하여 검색'**
  String get schoolSearchPlaceholder;

  /// 학교를 변경하는 페이지에 있는 제목입니다.
  ///
  /// In ko, this message translates to:
  /// **'학교 변경'**
  String get schoolChanger;

  /// 서울특별시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'서울특별시교육청'**
  String get ministry_Seoul;

  /// 부산광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'부산광역시교육청'**
  String get ministry_Busan;

  /// 대구광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'대구광역시교육청'**
  String get ministry_Daegu;

  /// 인천광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'인천광역시교육청'**
  String get ministry_Incheon;

  /// 광주광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'광주광역시교육청'**
  String get ministry_Gwangju;

  /// 대전광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'대전광역시교육청'**
  String get ministry_Daejeon;

  /// 울산광역시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'울산광역시교육청'**
  String get ministry_Ulsan;

  /// 세종특별자치시교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'세종특별자치시교육청'**
  String get ministry_Sejong;

  /// 경기도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'경기도교육청'**
  String get ministry_Gyeonggi;

  /// 강원특별자치도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'강원특별자치도교육청'**
  String get ministry_Gangwon;

  /// 충청북도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'충청북도교육청'**
  String get ministry_Chungbuk;

  /// 충청남도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'충청남도교육청'**
  String get ministry_Chungnam;

  /// 전북특별자치도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'전북특별자치도교육청'**
  String get ministry_Jeonbuk;

  /// 전라남도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'전라남도교육청'**
  String get ministry_Jeonnam;

  /// 경상북도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'경상북도교육청'**
  String get ministry_Gyeongbuk;

  /// 경상남도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'경상남도교육청'**
  String get ministry_Gyeongnam;

  /// 제주특별자치도교육청을 의미합니다.
  ///
  /// In ko, this message translates to:
  /// **'제주특별자치도교육청'**
  String get ministry_Jeju;

  /// 급식 정보를 불러오는데 실패했을 때 나타나는 에러 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'급식 정보를 불러올 수 없습니다'**
  String get errorMessage;

  /// 급식 점수를 불러오는데 실패했을 때 나타나는 에러 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'급식 점수를 불러올 수 없습니다'**
  String get errorMessage_GScore;

  /// 급식 정보가 없을 때 나타나는 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'급식이 없습니다.'**
  String get foodNotAvailable;

  /// 검색 결과가 없을 때 나타나는 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'검색 결과가 없습니다.'**
  String get noSearchResults;

  /// 학교가 변경되었을 때 나타나는 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'학교가 변경되었습니다.'**
  String get schoolChanged;

  /// 검색 결과가 없을 때 나타나는 메시지입니다.
  ///
  /// In ko, this message translates to:
  /// **'결과가 없습니다.\n더 자세히 입력해 보시는 건 어떨까요?'**
  String get searchNotAccurate;

  /// No description provided for @openAICompatibleSettings.
  ///
  /// In ko, this message translates to:
  /// **'OpenAI 호환 API 설정'**
  String get openAICompatibleSettings;

  /// No description provided for @openAICompatibleSettingsDescription.
  ///
  /// In ko, this message translates to:
  /// **'OpenAI 호환 API를 설정합니다.'**
  String get openAICompatibleSettingsDescription;

  /// No description provided for @baseUrl.
  ///
  /// In ko, this message translates to:
  /// **'API 기본 URL'**
  String get baseUrl;

  /// No description provided for @modelName.
  ///
  /// In ko, this message translates to:
  /// **'모델 이름'**
  String get modelName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

import 'revolut_enums.dart';

/// Customer data structure
class CustomerData {
  final String? name;
  final String? email;
  final String? phone;
  final DateOfBirthData? dateOfBirth;
  final String? country; // Now using string for country code

  const CustomerData({
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toMap(),
      'country': country,
    };
  }

  factory CustomerData.fromMap(Map<String, dynamic> map) {
    return CustomerData(
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateOfBirthData.fromMap(map['dateOfBirth'] as Map<String, dynamic>)
          : null,
      country: map['country'] as String?,
    );
  }
}

/// Date of birth data structure
class DateOfBirthData {
  final int day;
  final int month;
  final int year;

  const DateOfBirthData({
    required this.day,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {'day': day, 'month': month, 'year': year};
  }

  factory DateOfBirthData.fromMap(Map<String, dynamic> map) {
    return DateOfBirthData(
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
    );
  }
}

/// Button parameters data structure
class ButtonParamsData {
  final ButtonRadius radius;
  final ButtonSize size;
  final BoxText boxText;
  final String? boxTextCurrency;
  final VariantModesData? variantModes;

  const ButtonParamsData({
    this.radius = ButtonRadius.medium,
    this.size = ButtonSize.large,
    this.boxText = BoxText.none,
    this.boxTextCurrency,
    this.variantModes,
  });

  Map<String, dynamic> toMap() {
    return {
      'radius': radius.value,
      'size': size.value,
      'boxText': boxText.value,
      'boxTextCurrency': boxTextCurrency,
      'variantModes': variantModes?.toMap(),
    };
  }

  factory ButtonParamsData.fromMap(Map<String, dynamic> map) {
    return ButtonParamsData(
      radius: ButtonRadius.values.firstWhere(
        (e) => e.value == map['radius'],
        orElse: () => ButtonRadius.medium,
      ),
      size: ButtonSize.values.firstWhere(
        (e) => e.value == map['size'],
        orElse: () => ButtonSize.large,
      ),
      boxText: BoxText.values.firstWhere(
        (e) => e.value == map['boxText'],
        orElse: () => BoxText.none,
      ),
      boxTextCurrency: map['boxTextCurrency'] as String?,
      variantModes: map['variantModes'] != null
          ? VariantModesData.fromMap(
              map['variantModes'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Variant modes data structure
class VariantModesData {
  final ButtonVariant darkTheme;
  final ButtonVariant lightTheme;

  const VariantModesData({
    this.darkTheme = ButtonVariant.dark,
    this.lightTheme = ButtonVariant.light,
  });

  Map<String, dynamic> toMap() {
    return {'darkTheme': darkTheme.value, 'lightTheme': lightTheme.value};
  }

  factory VariantModesData.fromMap(Map<String, dynamic> map) {
    return VariantModesData(
      darkTheme: ButtonVariant.values.firstWhere(
        (e) => e.value == map['darkTheme'],
        orElse: () => ButtonVariant.dark,
      ),
      lightTheme: ButtonVariant.values.firstWhere(
        (e) => e.value == map['lightTheme'],
        orElse: () => ButtonVariant.light,
      ),
    );
  }
}

/// Promotional banner parameters data structure
class PromoBannerParamsData {
  final String transactionId;
  final int paymentAmount;
  final RevolutCurrency currency;
  final CustomerData? customer;

  const PromoBannerParamsData({
    required this.transactionId,
    required this.paymentAmount,
    required this.currency,
    this.customer,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'paymentAmount': paymentAmount,
      'currency': currency.value,
      'customer': customer?.toMap(),
    };
  }

  factory PromoBannerParamsData.fromMap(Map<String, dynamic> map) {
    return PromoBannerParamsData(
      transactionId: map['transactionId'] as String,
      paymentAmount: map['paymentAmount'] as int,
      currency: RevolutCurrency.values.firstWhere(
        (e) => e.value == map['currency'],
        orElse: () => RevolutCurrency.gbp,
      ),
      customer: map['customer'] != null
          ? CustomerData.fromMap(map['customer'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Order result callback data
class OrderResultData {
  final bool success;
  final String? orderId;
  final String? error;
  final String? cause;

  const OrderResultData({
    required this.success,
    this.orderId,
    this.error,
    this.cause,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'orderId': orderId,
      'error': error,
      'cause': cause,
    };
  }

  factory OrderResultData.fromMap(Map<String, dynamic> map) {
    return OrderResultData(
      success: map['success'] as bool,
      orderId: map['orderId'] as String?,
      error: map['error'] as String?,
      cause: map['cause'] as String?,
    );
  }
}

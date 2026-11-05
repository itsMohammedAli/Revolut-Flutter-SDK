import 'package:json_annotation/json_annotation.dart';

/// Box text options for button customization
@JsonEnum(valueField: 'value')
enum BoxText {
  none('NONE'),
  getCashbackValue('GET_CASHBACK_VALUE'),
  getCashbackPercentage('GET_CASHBACK_PERCENTAGE');

  final String value;
  const BoxText(this.value);
}

/// Button radius options
@JsonEnum(valueField: 'value')
enum ButtonRadius {
  none('NONE'),
  small('SMALL'),
  medium('MEDIUM'),
  large('LARGE');

  final String value;
  const ButtonRadius(this.value);
}

/// Button size options
@JsonEnum(valueField: 'value')
enum ButtonSize {
  extraSmall('EXTRA_SMALL'),
  small('SMALL'),
  medium('MEDIUM'),
  large('LARGE');

  final String value;
  const ButtonSize(this.value);
}

/// Button variant options
@JsonEnum(valueField: 'value')
enum ButtonVariant {
  light('LIGHT'),
  dark('DARK');

  final String value;
  const ButtonVariant(this.value);
}

/// Currency options for promotional banners
@JsonEnum(valueField: 'value')
enum RevolutCurrency {
  gbp('GBP'),
  eur('EUR'),
  usd('USD');

  final String value;
  const RevolutCurrency(this.value);
}

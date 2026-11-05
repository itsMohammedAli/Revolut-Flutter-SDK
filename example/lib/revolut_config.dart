/// Public client configuration. Create orders with your secret key on a server.
abstract final class RevolutConfig {
  static const environment = String.fromEnvironment('REVOLUT_ENVIRONMENT', defaultValue: 'sandbox');
  static const currentPublicKey = String.fromEnvironment('REVOLUT_PUBLIC_KEY');
  static const currentBaseUrl = String.fromEnvironment('REVOLUT_ORDER_ENDPOINT');
}

Map<String, double> exchangeRates = {
  "EUR": 1.0,
  "USD": 1.10,
  "JPY": 150.0,
  "GBP": 0.85,
  "AUD": 1.65,
  "CAD": 1.45,
  "CHF": 0.95,
  "CNY": 7.85,
  "SEK": 12.00,
  "NZD": 1.80,
  "KRW": 1.420,
  "SGD": 1.45,
  "HKD": 8.50,
  "NOK": 11.50,
  "MXN": 18.5,
  "INR": 90.0,
  "BRL": 5.40,
  "ZAR": 20.2,
  "RON": 5.0,
  "RUB": 105.0,
  "TRY": 29.0,
};

double convertToEuro(double amount, String currency) {
  double euroAmount = 0.0;

  if (exchangeRates.containsKey(currency)) {
    double rate = exchangeRates[currency]!;
    euroAmount += amount / rate;
  }

  return euroAmount;
}

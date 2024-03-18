import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  static FirebaseRemoteConfig? _firebaseRemoteConfig;

  static FirebaseRemoteConfig get firebaseRemoteConfig =>
      FirebaseRemoteConfigService._firebaseRemoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    firebaseRemoteConfig.setDefaults(<String, dynamic>{
      'certificate': _certificate,
    });

    await firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 30),
      ),
    );
    try {
      await firebaseRemoteConfig.fetchAndActivate();
    } catch (exception) {
      log('Unable to fetch remote config. Cached or default values will ' 'be');
    }
  }

  String getString(String key) => firebaseRemoteConfig.getString(key);

  bool getBool(String key) => firebaseRemoteConfig.getBool(key);

  int getInt(String key) => firebaseRemoteConfig.getInt(key);

  double getDouble(String key) => firebaseRemoteConfig.getDouble(key);
}

const _certificate = """
-----BEGIN CERTIFICATE-----
MIIFJTCCBA2gAwIBAgISBJmhNqL8RhahxHizHj9z3LujMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMzEwMTgwMzM0NDRaFw0yNDAxMTYwMzM0NDNaMCYxJDAiBgNVBAMT
G3Jlc3RhdXJhbnQtYXBpLmRpY29kaW5nLmRldjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAKi6t7n0yzswWuPGXudpSHcVjkHjBIaRBNTCUamVjwjsfC8m
kbJAmgQpd59LWUpt/ygZiMW6Sy3YIvFFoLaIoP/BHRf0MfyUMsJaH9bTTh6UZVo5
TVbVz77zfXxQU0pP2EvYgopGCtQaBfQTdo76DqOFZ6itZm4QnGqAWJpcVZRKRLYE
zrd00zUfgC5H+C0x8czIPpzFEW7MxD+J2xRCthajfpvNd8Vqx9zp1oOYpstWcS4S
Ft4MK1AeMVJvgGLF8u3CVG08TD+c1aB6zberOA07mYgf5NCM0WB6nuh3Qn2GPcTj
cEgQtLImJ0VMe2R8ZJCsPIxJXQhFiLXMjpWrbg8CAwEAAaOCAj8wggI7MA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0T
AQH/BAIwADAdBgNVHQ4EFgQUIHRBJpgxTVLy85Vt9ZY7ecZaR/YwHwYDVR0jBBgw
FoAUFC6zF7dYVsuuUAlA5h+vnYsUwsYwVQYIKwYBBQUHAQEESTBHMCEGCCsGAQUF
BzABhhVodHRwOi8vcjMuby5sZW5jci5vcmcwIgYIKwYBBQUHMAKGFmh0dHA6Ly9y
My5pLmxlbmNyLm9yZy8wRwYDVR0RBEAwPoIbcmVzdGF1cmFudC1hcGkuZGljb2Rp
bmcuZGV2gh93d3cucmVzdGF1cmFudC1hcGkuZGljb2RpbmcuZGV2MBMGA1UdIAQM
MAowCAYGZ4EMAQIBMIIBBQYKKwYBBAHWeQIEAgSB9gSB8wDxAHYAO1N3dT4tuYBO
izBbBv5AO2fYT8P0x70ADS1yb+H61BcAAAGLQRCKeQAABAMARzBFAiBQbvOmQDzF
jKrZ6yQVUfG5w6amjAQzboVvtTCC4orW0gIhAI3Pd28V43EWtXT5XHBnaW15xEmd
YcKobg0ILDgjd0ZDAHcA2ra/az+1tiKfm8K7XGvocJFxbLtRhIU0vaQ9MEjX+6sA
AAGLQRCKgAAABAMASDBGAiEApNjVgbcDToOBJIX0VS08wizjmssILdA7xVzrryJW
ZoMCIQDNkNMvqK0DysBJQqarA9/7ZQKG68BhxxXgIAv+pP3f2zANBgkqhkiG9w0B
AQsFAAOCAQEAiSAJ8JX4QuHZinuMHkUx6rv/iQ+3V8qeG0L8JRitsPk0Z5ms7BHY
9/ncOzs6lXqOy513YNP+g8rew3H3XCsH0sF4TsNak0EEAabv1mDyUOhsGdI/bs88
8HyoWyaB6L2Ss7/lyuQq3n3YjYrlMqKa2JCGOHa6SQmSQFZ3jN8abW4SoJAyFSKr
xt6vi9AyItO81RE4ecZYj69yIYqKAu+jl34V7sKn+QBhOZEutnWQy9bCcRwia6+b
iJf5OKnlQXZwvZAgs3QptFbndCeoBune5oVimvSITihgNJGGfMMSUVQ7maXKzbyb
gN7gxHz4yZF52hlpZfSsA+Jx1y6TU3n8lw==
-----END CERTIFICATE-----
""";

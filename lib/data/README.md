# Data Layer

This directory contains the data layer of the application, including models, repositories, and data sources.

## Structure

```
data/
├── json-files/          # JSON data files
├── models/              # Data models with JSON serialization
├── providers/           # Riverpod providers for repositories
├── repositories/        # Repository implementations
└── sources/            # Data sources (local, remote)
```

## Usage

### Using Repositories with Riverpod

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourlast_app/data/providers/repository_providers.dart';
import 'package:tourlast_app/data/repositories/repositories.dart';

// In a widget or provider
final flightsAsync = ref.watch(flightRepositoryProvider).getFlights();

// Handle loading/error states
flightsAsync.when(
  data: (flights) => FlightList(flights: flights),
  loading: () => LoadingIndicator(),
  error: (error, stack) => ErrorWidget(error: error),
);
```

### Direct Repository Usage

```dart
// Get flights
final flightRepo = FlightRepository.instance;
final flights = await flightRepo.getFlights();

// Get airlines
final airlineRepo = AirlineRepository.instance;
final airlines = await airlineRepo.getAirlines();
final specificAirline = await airlineRepo.getAirlineByCode('HV');

// Get extra services
final extraServiceRepo = ExtraServiceRepository.instance;
final services = await extraServiceRepo.getExtraServices();

// Get trip details
final tripDetailRepo = TripDetailRepository.instance;
final tripDetails = await tripDetailRepo.getTripDetails();
```

## Caching

All repositories implement in-memory caching:
- **Flights**: 1 hour cache validity
- **Airlines**: 24 hours cache validity
- **Extra Services**: 1 hour cache validity
- **Trip Details**: 1 hour cache validity

To force refresh:
```dart
final flights = await flightRepo.getFlights(forceRefresh: true);
```

To clear cache:
```dart
flightRepo.clearCache();
```

## Error Handling

All repositories throw `DataException` subclasses:
- `DataNotFoundException`: Data not found
- `DataParsingException`: JSON parsing failed
- `DataSourceException`: Data source error

Handle errors appropriately:
```dart
try {
  final flights = await flightRepo.getFlights();
} on DataParsingException catch (e) {
  // Handle parsing error
} on DataSourceException catch (e) {
  // Handle source error
} catch (e) {
  // Handle unexpected error
}
```


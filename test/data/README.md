# Data Layer Tests

This directory contains comprehensive tests for the data layer, including models, repositories, and data sources.

## Test Structure

```
test/data/
├── models/
│   ├── flight_model_test.dart          # Flight model parsing tests
│   ├── flight_models_edge_cases_test.dart  # Edge cases for flight models
│   ├── airline_model_test.dart         # Airline model tests
│   ├── extra_service_model_test.dart   # Extra service model tests
│   ├── trip_detail_model_test.dart     # Trip detail model tests
│   └── money_model_test.dart           # Money model edge cases
├── repositories/
│   ├── flight_repository_test.dart      # Flight repository tests
│   ├── airline_repository_test.dart     # Airline repository tests
│   ├── extra_service_repository_test.dart  # Extra service repository tests
│   └── trip_detail_repository_test.dart   # Trip detail repository tests
└── sources/
    └── json_data_source_test.dart      # JSON data source tests
```

## Test Coverage

### Model Tests

#### Flight Models
- ✅ Valid JSON parsing
- ✅ Null value handling
- ✅ Missing field handling
- ✅ Empty arrays/lists
- ✅ Edge cases (zero values, large values, special characters)

#### Money Model
- ✅ Null DecimalPlaces
- ✅ Missing DecimalPlaces
- ✅ Null Amount/CurrencyCode
- ✅ Empty strings
- ✅ Large amounts
- ✅ Negative amounts
- ✅ Invalid amount strings
- ✅ Various currency codes
- ✅ Zero amounts
- ✅ DecimalPlaces as number

#### Airline Model
- ✅ Valid parsing
- ✅ Empty strings
- ✅ Long strings
- ✅ Special characters
- ✅ Full JSON file parsing

#### Extra Service Models
- ✅ Valid parsing
- ✅ Null DecimalPlaces in ServiceCost
- ✅ Missing DecimalPlaces
- ✅ Zero quantities
- ✅ Large quantities
- ✅ Empty service lists
- ✅ Full JSON file parsing

#### Trip Detail Models
- ✅ Valid parsing
- ✅ Null gender
- ✅ Null optional fields
- ✅ Empty customer infos
- ✅ Various passenger types
- ✅ Full JSON file parsing

### Repository Tests

#### FlightRepository
- ✅ Load flights from JSON
- ✅ Caching behavior
- ✅ Force refresh
- ✅ Required fields validation

#### AirlineRepository
- ✅ Load airlines from JSON
- ✅ Caching behavior
- ✅ Get airline by code
- ✅ Non-existent codes
- ✅ Empty codes
- ✅ Search by name
- ✅ Search by code
- ✅ Case-insensitive search
- ✅ Non-matching searches
- ✅ Empty search queries
- ✅ Special characters in search
- ✅ Force refresh
- ✅ Clear cache

#### ExtraServiceRepository
- ✅ Load extra services
- ✅ Caching behavior
- ✅ Force refresh
- ✅ Baggage data handling
- ✅ Clear cache

#### TripDetailRepository
- ✅ Load trip details
- ✅ Caching behavior
- ✅ Force refresh
- ✅ Valid travel itinerary
- ✅ Customer infos
- ✅ Reservation items
- ✅ Clear cache

### Data Source Tests

#### JsonDataSource
- ✅ Load flights JSON
- ✅ Load airlines JSON
- ✅ Load extra services JSON
- ✅ Load trip details JSON
- ✅ Malformed JSON handling

## Running Tests

Run all data layer tests:
```bash
flutter test test/data/
```

Run specific test file:
```bash
flutter test test/data/models/money_model_test.dart
```

Run with coverage:
```bash
flutter test --coverage test/data/
```

## Edge Cases Covered

1. **Null Values**: All models handle null fields gracefully
2. **Missing Fields**: Models use default values or nullable types
3. **Empty Collections**: Arrays and lists can be empty
4. **Empty Strings**: String fields can be empty
5. **Large Values**: Handles large numbers and long strings
6. **Special Characters**: Handles special characters in strings
7. **Invalid Data**: Handles invalid data types gracefully
8. **Boundary Values**: Tests zero, negative, and maximum values
9. **Caching**: Verifies cache behavior and invalidation
10. **Search Edge Cases**: Empty queries, non-matching, case sensitivity

## Test Results

All 76+ tests pass, covering:
- ✅ Model parsing and validation
- ✅ Repository functionality
- ✅ Data source loading
- ✅ Edge cases and error handling
- ✅ Caching mechanisms
- ✅ Search functionality


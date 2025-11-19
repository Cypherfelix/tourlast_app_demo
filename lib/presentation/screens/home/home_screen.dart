import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/sample_trip.dart';
import '../../../core/constants/app_spacing.dart';
import '../../widgets/home/background/sky_backdrop.dart';
import '../../widgets/home/header/hero_text.dart';
import '../../widgets/home/header/top_bar.dart';
import '../../widgets/home/models/trip_type.dart';
import '../../widgets/home/search_card/search_button.dart';
import '../../widgets/home/search_card/search_card.dart';
import '../../widgets/home/trip_type/trip_type_selector.dart';
import '../../widgets/home/dialogs/help_dialog.dart';
import '../../widgets/home/bottom_sheets/airport_selector_sheet.dart';
import '../../widgets/home/bottom_sheets/cabin_selector_sheet.dart';
import '../../widgets/home/bottom_sheets/currency_selector_sheet.dart';
import '../../widgets/home/bottom_sheets/travelers_selector_sheet.dart';
import '../../widgets/home/models/search_params.dart';
import '../../widgets/home/search_card/search_loading_overlay.dart';
import '../results/results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TripType _tripType = TripType.oneWay;
  String _origin = SampleTrip.origin;
  String _destination = SampleTrip.destination;
  DateTime _selectedDate = SampleTrip.departureDate;
  DateTime? _returnDate;
  int _adults = SampleTrip.adults;
  int _children = SampleTrip.children;
  int _infants = SampleTrip.infants;
  String _cabinClass = SampleTrip.cabinClass;
  String _currency = SampleTrip.currency;
  bool _isSearching = false;

  // Available options for demo
  static const List<Map<String, String>> _airports = [
    {'code': 'AMS', 'city': 'Amsterdam', 'name': 'Amsterdam Schiphol'},
    {'code': 'LON', 'city': 'London', 'name': 'London (All Airports)'},
  ];

  static const List<String> _cabinClasses = [
    'Economy',
    'Premium Economy',
    'Business',
    'First',
  ];
  static const List<String> _currencies = ['USD', 'EUR', 'GBP'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SkyBackdrop(),
            if (_isSearching) const SearchLoadingOverlay(),
            if (!_isSearching)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(onHelpTap: _showHelpDialog),
                  const SizedBox(height: AppSpacing.xl),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: HeroText(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: TripTypeSelector(
                      selectedType: _tripType,
                      onTypeChanged: (type) => setState(() => _tripType = type),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SearchCard(
                    tripType: _tripType,
                    origin: _origin,
                    destination: _destination,
                    selectedDate: _selectedDate,
                    returnDate: _returnDate,
                    adults: _adults,
                    children: _children,
                    infants: _infants,
                    cabinClass: _cabinClass,
                    currency: _currency,
                    onOriginTap: () => _showAirportSelector(true),
                    onDestinationTap: () => _showAirportSelector(false),
                    onDateTap: _selectDate,
                    onReturnDateTap: _selectReturnDate,
                    onTravelersTap: _selectTravelers,
                    onCabinTap: _selectCabin,
                    onCurrencyTap: _selectCurrency,
                  ),
                  const Spacer(),
                  SearchButton(
                    textTheme: Theme.of(context).textTheme,
                    isLoading: _isSearching,
                    onPressed: _handleSearch,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showAirportSelector(bool isOrigin) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AirportSelectorSheet(
        airports: _airports,
        selectedCode: isOrigin ? _origin : _destination,
        onSelect: (code) {
          setState(() {
            if (isOrigin) {
              _origin = code;
            } else {
              _destination = code;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      selectableDayPredicate: (date) {
        // Only allow the specific demo date
        return date.year == 2025 && date.month == 12 && date.day == 21;
      },
      helpText: 'Select Departure Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectReturnDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _returnDate ?? _selectedDate.add(const Duration(days: 7)),
      firstDate: _selectedDate,
      lastDate: DateTime(2026, 12, 31),
      selectableDayPredicate: (date) {
        // Only allow the specific demo date
        return date.year == 2025 && date.month == 12 && date.day == 21;
      },
      helpText: 'Select Return Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _returnDate = picked);
    }
  }

  void _selectTravelers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TravelersSelectorSheet(
        adults: _adults,
        children: _children,
        infants: _infants,
        onConfirm: (adults, children, infants) {
          setState(() {
            _adults = adults;
            _children = children;
            _infants = infants;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _selectCabin() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CabinSelectorSheet(
        selectedCabin: _cabinClass,
        cabins: _cabinClasses,
        onSelect: (cabin) {
          setState(() => _cabinClass = cabin);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _selectCurrency() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CurrencySelectorSheet(
        selectedCurrency: _currency,
        currencies: _currencies,
        onSelect: (currency) {
          setState(() => _currency = currency);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(context: context, builder: (context) => const HelpDialog());
  }

  Future<void> _handleSearch() async {
    if (_isSearching) return;

    setState(() => _isSearching = true);

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 3000));

    if (!mounted) return;

    final searchParams = SearchParams(
      tripType: _tripType,
      origin: _origin,
      destination: _destination,
      departureDate: _selectedDate,
      returnDate: _returnDate,
      adults: _adults,
      children: _children,
      infants: _infants,
      cabinClass: _cabinClass,
      currency: _currency,
    );

    setState(() => _isSearching = false);

    // Navigate with custom transition
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ResultsScreen(searchParams: searchParams),
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.3);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );
  }
}

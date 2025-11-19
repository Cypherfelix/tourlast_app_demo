import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/sample_trip.dart';
import '../../../core/theme/app_typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _origin = SampleTrip.origin;
  String _destination = SampleTrip.destination;
  DateTime _selectedDate = SampleTrip.departureDate;
  int _adults = SampleTrip.adults;
  int _children = SampleTrip.children;
  int _infants = SampleTrip.infants;
  String _cabinClass = SampleTrip.cabinClass;
  String _currency = SampleTrip.currency;

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
            const _SkyBackdrop(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopBar(),
                const SizedBox(height: AppSpacing.xl),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: _HeroText(),
                ),
                const SizedBox(height: AppSpacing.xxl),
                _SearchCard(
                  origin: _origin,
                  destination: _destination,
                  selectedDate: _selectedDate,
                  adults: _adults,
                  children: _children,
                  infants: _infants,
                  cabinClass: _cabinClass,
                  currency: _currency,
                  onOriginTap: () => _showAirportSelector(true),
                  onDestinationTap: () => _showAirportSelector(false),
                  onDateTap: _selectDate,
                  onTravelersTap: _selectTravelers,
                  onCabinTap: _selectCabin,
                  onCurrencyTap: _selectCurrency,
                ),
                const Spacer(),
                _ContinueHint(textTheme: Theme.of(context).textTheme),
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
      builder: (context) => _AirportSelectorSheet(
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

  void _selectTravelers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _TravelersSelectorSheet(
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
      builder: (context) => _CabinSelectorSheet(
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
      builder: (context) => _CurrencySelectorSheet(
        selectedCurrency: _currency,
        currencies: _currencies,
        onSelect: (currency) {
          setState(() => _currency = currency);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _SkyBackdrop extends StatelessWidget {
  const _SkyBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.skyGradientStart, AppColors.surfaceMuted],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -30,
            child: _CircleBlur(size: 200, color: Colors.white.withOpacity(0.3)),
          ),
          Positioned(
            top: 120,
            left: -40,
            child: _CircleBlur(
              size: 160,
              color: AppColors.accentAqua.withOpacity(.2),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBlur extends StatelessWidget {
  const _CircleBlur({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: const [BoxShadow(blurRadius: 40, color: Colors.white)],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.15),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const Icon(
              Icons.flight_takeoff_rounded,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TourLast',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Premium Flights',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find Your Perfect Flight',
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Search and compare flights from hundreds of airlines',
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.origin,
    required this.destination,
    required this.selectedDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.cabinClass,
    required this.currency,
    required this.onOriginTap,
    required this.onDestinationTap,
    required this.onDateTap,
    required this.onTravelersTap,
    required this.onCabinTap,
    required this.onCurrencyTap,
  });

  final String origin;
  final String destination;
  final DateTime selectedDate;
  final int adults;
  final int children;
  final int infants;
  final String cabinClass;
  final String currency;
  final VoidCallback onOriginTap;
  final VoidCallback onDestinationTap;
  final VoidCallback onDateTap;
  final VoidCallback onTravelersTap;
  final VoidCallback onCabinTap;
  final VoidCallback onCurrencyTap;

  String get _formattedDate =>
      DateFormat('EEE, d MMM yyyy').format(selectedDate);

  String get _travelersText {
    final parts = <String>[];
    if (adults > 0) parts.add('$adults Adult${adults > 1 ? 's' : ''}');
    if (children > 0) parts.add('$children Child${children > 1 ? 'ren' : ''}');
    if (infants > 0) parts.add('$infants Infant${infants > 1 ? 's' : ''}');
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.08),
              blurRadius: 30,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AirportPill(
                  code: origin,
                  city: _getCityName(origin),
                  alignRight: false,
                  onTap: onOriginTap,
                ),
                const SizedBox(width: AppSpacing.sm),
                const _RouteDivider(),
                const SizedBox(width: AppSpacing.sm),
                _AirportPill(
                  code: destination,
                  city: _getCityName(destination),
                  alignRight: true,
                  onTap: onDestinationTap,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _InfoRow(
              icon: Icons.event_rounded,
              label: 'Departure',
              value: _formattedDate,
              onTap: onDateTap,
            ),
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              icon: Icons.people_rounded,
              label: 'Travelers',
              value: _travelersText,
              onTap: onTravelersTap,
            ),
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              icon: Icons.airline_seat_legroom_normal_rounded,
              label: 'Cabin',
              value: cabinClass,
              onTap: onCabinTap,
            ),
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              icon: Icons.attach_money_rounded,
              label: 'Currency',
              value: currency,
              onTap: onCurrencyTap,
            ),
          ],
        ),
      ),
    );
  }

  String _getCityName(String code) {
    switch (code) {
      case 'AMS':
        return 'Amsterdam';
      case 'LON':
        return 'London';
      default:
        return '';
    }
  }
}

class _RouteDivider extends StatelessWidget {
  const _RouteDivider();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryBlue.withOpacity(0.2),
                  AppColors.primaryBlue,
                  AppColors.primaryBlue.withOpacity(0.2),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.flight_takeoff,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AirportPill extends StatelessWidget {
  const _AirportPill({
    required this.code,
    required this.city,
    required this.alignRight,
    required this.onTap,
  });

  final String code;
  final String city;
  final bool alignRight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: alignRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  code,
                  style: AppTypography.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              city,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: AppTypography.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueHint extends StatelessWidget {
  const _ContinueHint({required this.textTheme});

  final TextTheme? textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: () {
            // Will be implemented in Story 3.2
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_rounded, size: 24),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Search Flights',
                style: textTheme?.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Airport Selector Bottom Sheet
class _AirportSelectorSheet extends StatefulWidget {
  const _AirportSelectorSheet({
    required this.airports,
    required this.selectedCode,
    required this.onSelect,
  });

  final List<Map<String, String>> airports;
  final String selectedCode;
  final ValueChanged<String> onSelect;

  @override
  State<_AirportSelectorSheet> createState() => _AirportSelectorSheetState();
}

class _AirportSelectorSheetState extends State<_AirportSelectorSheet> {
  String _searchQuery = '';

  List<Map<String, String>> get _filteredAirports {
    if (_searchQuery.isEmpty) return widget.airports;
    final query = _searchQuery.toLowerCase();
    return widget.airports.where((airport) {
      return airport['code']!.toLowerCase().contains(query) ||
          airport['city']!.toLowerCase().contains(query) ||
          airport['name']!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search airports...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredAirports.length,
              itemBuilder: (context, index) {
                final airport = _filteredAirports[index];
                final isSelected = airport['code'] == widget.selectedCode;
                return ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryBlue.withOpacity(0.1)
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        airport['code']!,
                        style: AppTypography.textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    airport['name']!,
                    style: AppTypography.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(airport['city']!),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.primaryBlue)
                      : null,
                  onTap: () => widget.onSelect(airport['code']!),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

// Travelers Selector Bottom Sheet
class _TravelersSelectorSheet extends StatefulWidget {
  const _TravelersSelectorSheet({
    required this.adults,
    required this.children,
    required this.infants,
    required this.onConfirm,
  });

  final int adults;
  final int children;
  final int infants;
  final ValueChanged3<int, int, int> onConfirm;

  @override
  State<_TravelersSelectorSheet> createState() =>
      _TravelersSelectorSheetState();
}

class _TravelersSelectorSheetState extends State<_TravelersSelectorSheet> {
  late int _adults;
  late int _children;
  late int _infants;

  @override
  void initState() {
    super.initState();
    _adults = widget.adults;
    _children = widget.children;
    _infants = widget.infants;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Select Travelers',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _TravelerCounter(
            label: 'Adults',
            subtitle: '12+ years',
            count: _adults,
            min: 1,
            onIncrement: () => setState(() => _adults++),
            onDecrement: () =>
                setState(() => _adults = _adults > 1 ? _adults - 1 : 1),
          ),
          _TravelerCounter(
            label: 'Children',
            subtitle: '2-11 years',
            count: _children,
            min: 0,
            onIncrement: () => setState(() => _children++),
            onDecrement: () =>
                setState(() => _children = _children > 0 ? _children - 1 : 0),
          ),
          _TravelerCounter(
            label: 'Infants',
            subtitle: 'Under 2 years',
            count: _infants,
            min: 0,
            onIncrement: () => setState(() => _infants++),
            onDecrement: () =>
                setState(() => _infants = _infants > 0 ? _infants - 1 : 0),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => widget.onConfirm(_adults, _children, _infants),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _TravelerCounter extends StatelessWidget {
  const _TravelerCounter({
    required this.label,
    required this.subtitle,
    required this.count,
    required this.min,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String label;
  final String subtitle;
  final int count;
  final int min;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(subtitle, style: AppTypography.textTheme.bodySmall),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: count > min ? onDecrement : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: count > min
                    ? AppColors.primaryBlue
                    : AppColors.textTertiary,
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: AppTypography.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.primaryBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Cabin Selector Bottom Sheet
class _CabinSelectorSheet extends StatelessWidget {
  const _CabinSelectorSheet({
    required this.selectedCabin,
    required this.cabins,
    required this.onSelect,
  });

  final String selectedCabin;
  final List<String> cabins;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Select Cabin Class',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...cabins.map(
            (cabin) => ListTile(
              title: Text(cabin),
              trailing: cabin == selectedCabin
                  ? Icon(Icons.check_circle, color: AppColors.primaryBlue)
                  : null,
              onTap: () => onSelect(cabin),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

// Currency Selector Bottom Sheet
class _CurrencySelectorSheet extends StatelessWidget {
  const _CurrencySelectorSheet({
    required this.selectedCurrency,
    required this.currencies,
    required this.onSelect,
  });

  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Select Currency',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...currencies.map(
            (currency) => ListTile(
              title: Text(currency),
              trailing: currency == selectedCurrency
                  ? Icon(Icons.check_circle, color: AppColors.primaryBlue)
                  : null,
              onTap: () => onSelect(currency),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

// Helper class for ValueChanged3
typedef ValueChanged3<T1, T2, T3> = void Function(T1, T2, T3);

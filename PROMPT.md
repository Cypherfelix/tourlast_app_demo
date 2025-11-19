# ✅ 1. WHAT WE SHOULD BUILD (High-level Breakdown)

The assessment expects:

### **1. Filtering functionality**

You must load `flights.json` and allow the user to filter by:

* Airline
* Price range
* Departure time
* Cabin class
* Stops (non-stop / connecting)

### **2. Flight Details Page**

Use:

* `airline-list.json` → logo, airline name, code 
* `extra-services.json` → baggage, meals, seats 
* `trip-details.json` → sample final detail structure (good for modeling) 
* `flights.json` → main flight search result (primary endpoint) 
* instructions.txt explains assessment expectations clearly 

### **3. Modern UI/UX**

Clean, airline-like UI:

* Card-based layout
* Light spacing & shadows
* Airline branding colors
* Animation for transitions
* Iconography for clarity

### **4. Architecture & Code Quality**

* Clean architecture (service → repository → providers → UI)
* State management (prefer **Riverpod** or **BLoC**)
* JSON to Dart models (using `json_serializable`)
* Optimized lists (`ListView.builder`)
* Error handling, loading states

### **5. Bonus**

* Persist search results / filters (Hive/SharedPreferences)
* Secure API calls (base64-encode credentials, though fake)
* Elegant custom animations (transition to detail page)
* Offline-first (cache JSON)

---

# ✅ 2. COMPLETE USER FLOW (Step-by-step, ready for Figma + Coding)

This is the most important part for demonstrating your senior-level maturity.

---

# **📍 A. SPLASH → ONBOARDING → HOME**

### **1. Splash Screen**

* Logo animation
* Loading assets (JSON files)

### **2. Home Page (Search Form)**

Fields:

* Origin (AMS)
* Destination (LON)
* Date picker
* Travellers (Adults/Children/Infants)
* Cabin class selector (Economy)
* Search button

On click → transition to Results Page.

---

# **📍 B. RESULTS PAGE (List of Flights)**

### **1. Load `flights.json`**

This is your main dataset.

### **2. Each Flight Card Shows:**

* Airline logo + name (from `airline-list.json`)
* Flight number + code
* Departure → Arrival time
* Duration
* Price (TotalFare)
* Baggage indicator
* Number of passengers
* "View Details" button

### **3. Apply Filters**

UI filter options:

* Sort by lowest price
* Filter by airline
* Filter by takeoff time
* Filter by cabin
* Filter by baggage

This shows your **data manipulation + UI thinking**.

---

# **📍 C. FLIGHT DETAILS PAGE**

### **Use ALL the extra JSON files here to shine**

### Shows:

#### **1. Airline & flight info**

* Logo + airline name
* Flight number
* Duration
* Terminals
* Cabin class
* Remaining seats

#### **2. Price Breakdown**

From `flights.json` + reference modeling from `trip-details.json`.

#### **3. Passenger breakdown (if required)**

Adult, Child, Infant cost mapping.

#### **4. Extra Services Section**

Fetched from `extra-services.json`:

* Baggage options with prices
* Meals (if any)
* Seat selection options

This is **very important** — it shows you can process multiple datasets.

#### **5. CTA Button**

“Continue / Book Flight”

---

# **📍 D. BOOKING / SUMMARY PAGE**

Here, you show you understand end-to-end flows:

* Selected flight summary
* Total pricing
* Selected extras
* Passenger info preview
* "Proceed to Checkout" button

Even though it’s not required to implement full checkout, showing a structured flow demonstrates professionalism.

---

# **📍 E. OPTIONAL (BONUS FOR SENIOR IMPRESSION)**

## ✔ Add Lottie animations

## ✔ Dark Mode

## ✔ Local caching using Hive

## ✔ Dio with interceptors (mock API security)

## ✔ Error handlers + retry mechanism

## ✔ Test cases (one or two)

## ✔ Flutter inspector-friendly widget structure

This will immediately tell interviewers:
👉 *“This developer works like a professional, not a junior.”*

---

# ✅ 3. RECOMMENDED MODERN PROJECT STRUCTURE

```
lib/
  core/
    utils/
    theme/
    constants/
  data/
    models/
    repositories/
    sources/
      local/
      remote/
  application/
    providers/
    state/
  presentation/
    screens/
      home/
      results/
      details/
      extras/
    widgets/
    components/
  main.dart
```

---

# ✅ 4. DIFFERENTIATORS TO IMPRESS THEM

### **A Senior Flutter Dev Will:**

✔ Normalize & merge all JSON data
✔ Build clean models with fromJson/toJson
✔ Show strong UI/UX design sense
✔ Explain architecture during demo
✔ Add error-handling states
✔ Use Riverpod/BLoC professionally
✔ Add simple automated tests
✔ Secure API credentials in `.env` or constants with comments
✔ Write clean comments + docstrings


import 'package:eccomerce_app/app/core/data/sharedPre.dart';
import 'package:eccomerce_app/app/core/utils/appString/app_storage_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/api_endpoints.dart';
import '../../../core/services/api_service.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/logger.dart';
import '../../../services/toast_service.dart';

class ReportSummeryController extends GetxController {
  // Reactive variables
  final isLoading = false.obs;
  final selectedDateRange = 'Today'.obs;
  final selectedStatus = 'All'.obs;
  final selectedParty = 'All Parties'.obs;

  // API Data
  final stateWiseData = <StateWiseData>[].obs;
  final partyWiseData = <PartyWiseData>[].obs;
  final topCustomersData = <TopCustomerData>[].obs;
  final topProductsData = <TopProductData>[].obs;
  final todayData = TodayData(0, 0).obs;
  final monthlyData = MonthlyComparisonData(
    thisMonth: MonthData(0, 0),
    prevMonth: MonthData(0, 0),
  ).obs;
  final dateRangeData = DateRangeData(0, 0, 0, 0, 0.0).obs;

  // Date range
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;

  // Filter options
  final List<String> dateRanges = [
    'Today',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'This Month',
    'Last Month',
    'Custom Range'
  ];

  final List<String> statusOptions = ['All', 'Success', 'Pending', 'Failed'];
  final List<String> partyOptions = ['All Parties'];

  // Chart data
  final List<SalesData> dailyOrders = [
    SalesData('Mon', 45),
    SalesData('Tue', 52),
    SalesData('Wed', 48),
    SalesData('Thu', 67),
    SalesData('Fri', 59),
    SalesData('Sat', 72),
    SalesData('Sun', 65),
  ].obs;

  final List<PaymentData> paymentStatus = [
    PaymentData('Success', 70, Colors.green),
    PaymentData('Pending', 20, Colors.orange),
    PaymentData('Failed', 10, Colors.red),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
    _initializeDates();
  }

  void _initializeDates() {
    final now = DateTime.now();
    fromDate.value = DateTime(now.year, now.month, now.day);
    toDate.value =
        DateTime(now.year, now.month, now.day).add(Duration(days: 1));
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        fetchStateWiseData(),
        fetchPartyWiseData(),
        fetchTodayData(),
        fetchMonthlyComparison(),
        fetchTopCustomers(),
        fetchTopProducts(),
        fetchDateRangeData(),
      ]);
      AppLogger.info('Dashboard data loaded successfully');
    } catch (e) {
      AppLogger.error('Failed to load dashboard data: $e');
      ApptoastUtils.showError('Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStateWiseData() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/state-wise/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        stateWiseData.assignAll(
            data.map((item) => StateWiseData.fromJson(item)).toList());
        AppLogger.debug(
            'State-wise data loaded: ${stateWiseData.length} states');
      } else {
        AppLogger.warning('State-wise data API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching state-wise data: $e');
    }
  }

  Future<void> fetchPartyWiseData() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/party-wise/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        partyWiseData.assignAll(
            data.map((item) => PartyWiseData.fromJson(item)).toList());

        // Update party options
        partyOptions.clear();
        partyOptions.addAll([
          'All Parties',
          ...partyWiseData.map((e) => e.customer.customerName)
        ]);

        AppLogger.debug(
            'Party-wise data loaded: ${partyWiseData.length} parties');
      } else {
        AppLogger.warning('Party-wise data API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching party-wise data: $e');
    }
  }

  Future<void> fetchTodayData() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/today/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        todayData.value = TodayData(
          data['totalSales'] ?? 0,
          data['totalOrders'] ?? 0,
        );
        AppLogger.debug(
            'Today data loaded: ${todayData.value.totalSales} sales, ${todayData.value.totalOrders} orders');
      } else {
        AppLogger.warning('Today data API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching today data: $e');
    }
  }

  Future<void> fetchMonthlyComparison() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/monthly-comparison/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        monthlyData.value = MonthlyComparisonData(
          thisMonth: MonthData.fromJson(data['thisMonth']),
          prevMonth: MonthData.fromJson(data['prevMonth']),
        );
        AppLogger.debug('Monthly comparison data loaded');
      } else {
        AppLogger.warning('Monthly comparison API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching monthly comparison: $e');
    }
  }

  Future<void> fetchTopCustomers() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/top-customers/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        topCustomersData.assignAll(
            data.map((item) => TopCustomerData.fromJson(item)).toList());
        AppLogger.debug(
            'Top customers data loaded: ${topCustomersData.length} customers');
      } else {
        AppLogger.warning('Top customers API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching top customers: $e');
    }
  }

  Future<void> fetchTopProducts() async {
    try {
      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/top-products/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}',
      );

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        topProductsData.assignAll(
            data.map((item) => TopProductData.fromJson(item)).toList());
        AppLogger.debug(
            'Top products data loaded: ${topProductsData.length} products');
      } else {
        AppLogger.warning('Top products API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching top products: $e');
    }
  }

  Future<void> fetchDateRangeData() async {
    try {
      final from = DateFormat('yyyy-MM-dd').format(fromDate.value);
      final to = DateFormat('yyyy-MM-dd').format(toDate.value);

      final response = await ApiService().getRequestAuth(
        '${ApiEndpoints.getOrders}/date-range/${SharedpreferenceUtil.getString(AppStorage.selectedCompanyId)}?fromDate=$from&toDate=$to',
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        dateRangeData.value = DateRangeData(
          data['totalSales'] ?? 0,
          data['totalOrders'] ?? 0,
          data['totalDiscount'] ?? 0,
          data['totalTax'] ?? 0,
          data['averageOrderValue'] ?? 0.0,
        );
        AppLogger.debug('Date range data loaded for $from to $to');
      } else {
        AppLogger.warning('Date range data API returned false success');
      }
    } catch (e) {
      AppLogger.error('Error fetching date range data: $e');
    }
  }

  void updateDateRange(String range) {
    selectedDateRange.value = range;
    final now = DateTime.now();

    switch (range) {
      case 'Today':
        fromDate.value = DateTime(now.year, now.month, now.day);
        toDate.value =
            DateTime(now.year, now.month, now.day).add(Duration(days: 1));
        break;
      case 'Yesterday':
        fromDate.value = DateTime(now.year, now.month, now.day - 1);
        toDate.value = DateTime(now.year, now.month, now.day);
        break;
      case 'Last 7 Days':
        fromDate.value = DateTime(now.year, now.month, now.day - 7);
        toDate.value =
            DateTime(now.year, now.month, now.day).add(Duration(days: 1));
        break;
      case 'Last 30 Days':
        fromDate.value = DateTime(now.year, now.month, now.day - 30);
        toDate.value =
            DateTime(now.year, now.month, now.day).add(Duration(days: 1));
        break;
      case 'This Month':
        fromDate.value = DateTime(now.year, now.month, 1);
        toDate.value = DateTime(now.year, now.month + 1, 1);
        break;
      case 'Last Month':
        fromDate.value = DateTime(now.year, now.month - 1, 1);
        toDate.value = DateTime(now.year, now.month, 1);
        break;
      case 'Custom Range':
        // Will be handled by date picker
        break;
    }

    if (range != 'Custom Range') {
      AppLogger.info('Date range updated to: $range');
      fetchDateRangeData();
    }
  }

  void updateFilters(String dateRange, String status, String party) {
    selectedDateRange.value = dateRange;
    selectedStatus.value = status;
    selectedParty.value = party;
    updateDateRange(dateRange);
    AppLogger.debug(
        'Filters updated: Date=$dateRange, Status=$status, Party=$party');
  }

  // Getters for computed values
  String get formattedDateRange {
    if (selectedDateRange.value == 'Custom Range') {
      return '${DateFormat('MMM dd, yyyy').format(fromDate.value)} - ${DateFormat('MMM dd, yyyy').format(toDate.value)}';
    }
    return selectedDateRange.value;
  }

  double get growthPercentage {
    final current = monthlyData.value.thisMonth.totalSales;
    final previous = monthlyData.value.prevMonth.totalSales;
    if (previous == 0) return current > 0 ? 100.0 : 0.0;
    return ((current - previous) / previous * 100);
  }

  String get formattedDate =>
      DateFormat('MMM dd, yyyy • HH:mm').format(DateTime.now());
}

// Data Models
class StateWiseData {
  final String state;
  final int totalSales;
  final int totalOrders;

  StateWiseData(
      {required this.state,
      required this.totalSales,
      required this.totalOrders});

  factory StateWiseData.fromJson(Map<String, dynamic> json) {
    return StateWiseData(
      state: json['_id'] ?? 'Unknown',
      totalSales: json['totalSales'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
    );
  }
}

class PartyWiseData {
  final String id;
  final int totalSales;
  final int totalOrders;
  final Customer customer;

  PartyWiseData({
    required this.id,
    required this.totalSales,
    required this.totalOrders,
    required this.customer,
  });

  factory PartyWiseData.fromJson(Map<String, dynamic> json) {
    return PartyWiseData(
      id: json['_id'] ?? '',
      totalSales: json['totalSales'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      customer: Customer.fromJson(json['customer'] ?? {}),
    );
  }
}

class Customer {
  final String id;
  final String customerName;
  final String contactPerson;
  final String emailAddress;
  final String country;
  final String currency;

  Customer({
    required this.id,
    required this.customerName,
    required this.contactPerson,
    required this.emailAddress,
    required this.country,
    required this.currency,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'] ?? '',
      customerName: json['customerName'] ?? '',
      contactPerson: json['contactPerson'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      country: json['country'] ?? '',
      currency: json['currency'] ?? '',
    );
  }
}

class TodayData {
  final int totalSales;
  final int totalOrders;

  TodayData(this.totalSales, this.totalOrders);
}

class MonthlyComparisonData {
  final MonthData thisMonth;
  final MonthData prevMonth;

  MonthlyComparisonData({required this.thisMonth, required this.prevMonth});
}

class MonthData {
  final int totalSales;
  final int totalOrders;

  MonthData(this.totalSales, this.totalOrders);

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      json['totalSales'] ?? 0,
      json['totalOrders'] ?? 0,
    );
  }
}

class TopCustomerData {
  final String id;
  final int totalSales;
  final Customer customer;

  TopCustomerData({
    required this.id,
    required this.totalSales,
    required this.customer,
  });

  factory TopCustomerData.fromJson(Map<String, dynamic> json) {
    return TopCustomerData(
      id: json['_id'] ?? '',
      totalSales: json['totalSales'] ?? 0,
      customer: Customer.fromJson(json['customer'] ?? {}),
    );
  }
}

class TopProductData {
  final int totalQuantity;
  final int totalSales;
  final int totalOrders;
  final String productId;

  TopProductData({
    required this.totalQuantity,
    required this.totalSales,
    required this.totalOrders,
    required this.productId,
  });

  factory TopProductData.fromJson(Map<String, dynamic> json) {
    return TopProductData(
      totalQuantity: json['totalQuantity'] ?? 0,
      totalSales: json['totalSales'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      productId: json['productId'] ?? '',
    );
  }
}

class DateRangeData {
  final int totalSales;
  final int totalOrders;
  final int totalDiscount;
  final int totalTax;
  final double averageOrderValue;

  DateRangeData(
    this.totalSales,
    this.totalOrders,
    this.totalDiscount,
    this.totalTax,
    this.averageOrderValue,
  );
}

// Chart data models
class SalesData {
  final String day;
  final int orders;

  SalesData(this.day, this.orders);
}

class PaymentData {
  final String status;
  final int percentage;
  final Color color;

  PaymentData(this.status, this.percentage, this.color);
}

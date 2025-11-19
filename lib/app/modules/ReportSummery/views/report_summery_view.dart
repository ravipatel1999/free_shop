import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Base/controllers/base_controller.dart';
import '../controllers/report_summery_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ReportSummeryView extends GetView<ReportSummeryController> {
  const ReportSummeryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportSummeryController controller =
        Get.put(ReportSummeryController());
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final BaseController baseController = Get.put(BaseController());

    return WillPopScope(
      onWillPop: () async {
        baseController.changeTabIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          title: const Text('Sales Dashboard'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                baseController.changeTabIndex(0);
              },
              icon: Icon(Platform.isIOS
                  ? Icons.arrow_back_ios_new_outlined
                  : Icons.arrow_back_outlined)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
              ),
              onPressed: controller.loadDashboardData,
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with date range
                _buildHeader(theme, colorScheme, controller),
                const SizedBox(height: 20),

                // Date Range Selector
                _buildDateRangeSelector(theme, colorScheme, controller),
                const SizedBox(height: 20),

                // Key Metrics
                _buildKeyMetrics(theme, colorScheme, controller),
                const SizedBox(height: 20),

                // Charts Section
                _buildChartsSection(theme, colorScheme, controller),
                const SizedBox(height: 20),

                // Top Performers
                _buildTopPerformers(theme, colorScheme, controller),
                const SizedBox(height: 20),

                // State-wise Performance
                _buildStateWisePerformance(theme, colorScheme, controller),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales Overview',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Last updated: ${controller.formattedDate}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primary.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.trending_up, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                'Live Data',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangeSelector(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date Range',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedDateRange.value,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down,
                          color: colorScheme.onSurface),
                      items: controller.dateRanges.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == 'Custom Range') {
                          _showCustomDateRangePicker(Get.context!, controller);
                        } else {
                          controller.updateDateRange(value!);
                        }
                      },
                    ),
                  ),
                ),
              ),
              if (controller.selectedDateRange.value == 'Custom Range') ...[
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: colorScheme.primary),
                  onPressed: () =>
                      _showCustomDateRangePicker(Get.context!, controller),
                ),
              ],
            ],
          ),
          if (controller.selectedDateRange.value == 'Custom Range') ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateChip(
                    'From: ${DateFormat('MMM dd, yyyy').format(controller.fromDate.value)}',
                    theme,
                    colorScheme,
                    onTap: () => _selectFromDate(Get.context!, controller),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDateChip(
                    'To: ${DateFormat('MMM dd, yyyy').format(controller.toDate.value)}',
                    theme,
                    colorScheme,
                    onTap: () => _selectToDate(Get.context!, controller),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateChip(String text, ThemeData theme, ColorScheme colorScheme,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDateRangePicker(
      BuildContext context, ReportSummeryController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Date Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('From Date'),
              subtitle: Text(
                  DateFormat('MMM dd, yyyy').format(controller.fromDate.value)),
              onTap: () => _selectFromDate(context, controller),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('To Date'),
              subtitle: Text(
                  DateFormat('MMM dd, yyyy').format(controller.toDate.value)),
              onTap: () => _selectToDate(context, controller),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.fetchDateRangeData();
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFromDate(
      BuildContext context, ReportSummeryController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.fromDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != controller.fromDate.value) {
      controller.fromDate.value = picked;
    }
  }

  Future<void> _selectToDate(
      BuildContext context, ReportSummeryController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.toDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != controller.toDate.value) {
      controller.toDate.value = picked;
    }
  }

  Widget _buildKeyMetrics(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      children: [
        _buildMetricCard(
          'Total Sales',
          '₹${_formatNumber(controller.dateRangeData.value.totalSales)}',
          '${controller.dateRangeData.value.totalOrders} orders',
          Icons.shopping_bag,
          Colors.blue,
          theme,
          colorScheme,
        ),
        _buildMetricCard(
          'Today Sales',
          '₹${_formatNumber(controller.todayData.value.totalSales)}',
          '${controller.todayData.value.totalOrders} orders',
          Icons.today,
          Colors.green,
          theme,
          colorScheme,
        ),
        _buildMetricCard(
          'This Month',
          '₹${_formatNumber(controller.monthlyData.value.thisMonth.totalSales)}',
          '${controller.monthlyData.value.thisMonth.totalOrders} orders',
          Icons.calendar_month,
          Colors.orange,
          theme,
          colorScheme,
        ),
        _buildMetricCard(
          'Growth',
          '${controller.growthPercentage.toStringAsFixed(1)}%',
          'vs last month',
          Icons.trending_up,
          controller.growthPercentage >= 0 ? Colors.green : Colors.red,
          theme,
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (title == 'Growth')
                Icon(
                  color == Colors.green
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: color,
                  size: 16,
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return Column(
      children: [
        // Sales by State Chart
        _buildChartCard(
          'Sales by State',
          SfCartesianChart(
            margin: EdgeInsets.zero,
            primaryXAxis: CategoryAxis(
              labelStyle:
                  TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
            ),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.compact(),
              labelStyle:
                  TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
            ),
            series: <CartesianSeries>[
              ColumnSeries<StateWiseData, String>(
                dataSource: controller.stateWiseData
                    .where((state) => state.state.isNotEmpty)
                    .toList(),
                xValueMapper: (StateWiseData data, _) => data.state,
                yValueMapper: (StateWiseData data, _) => data.totalSales,
                color: colorScheme.primary,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
          theme,
          colorScheme,
        ),
        const SizedBox(height: 16),

        // Payment Status Chart
        _buildChartCard(
          'Order Distribution',
          SfCircularChart(
            margin: EdgeInsets.zero,
            series: <CircularSeries>[
              DoughnutSeries<StateWiseData, String>(
                dataSource: controller.stateWiseData
                    .where((state) => state.state.isNotEmpty)
                    .take(5)
                    .toList(),
                xValueMapper: (StateWiseData data, _) => data.state,
                yValueMapper: (StateWiseData data, _) => data.totalOrders,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
          theme,
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildChartCard(
      String title, Widget chart, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 300,
            child: chart,
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformers(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Customers',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...controller.topCustomersData.take(5).map(
              (customer) => _buildCustomerItem(customer, theme, colorScheme)),
        ],
      ),
    );
  }

  Widget _buildCustomerItem(
      TopCustomerData customer, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.customer.customerName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  customer.customer.contactPerson,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${_formatNumber(customer.totalSales)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                'Sales',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStateWisePerformance(ThemeData theme, ColorScheme colorScheme,
      ReportSummeryController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'State-wise Performance',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${controller.stateWiseData.length} states',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...controller.stateWiseData
              .where((state) => state.state.isNotEmpty)
              .map((state) => _buildStateItem(state, theme, colorScheme)),
        ],
      ),
    );
  }

  Widget _buildStateItem(
      StateWiseData state, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              state.state,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${_formatNumber(state.totalSales)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  '${state.totalOrders} orders',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(1)}Cr';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

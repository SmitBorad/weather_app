import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart'; // For formatting date strings

class WeatherTemperatureChart extends StatelessWidget {
  final List<Weather> weatherData;

  const WeatherTemperatureChart({super.key, required this.weatherData});

  List<FlSpot> getTemperatureSpots() {
    return weatherData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      return FlSpot(index, entry.value.temperature);
    }).toList();
  }

  Widget bottomTitleWidgets(BuildContext context, double value, TitleMeta meta) {
    final int index = value.toInt();
    if (index < 0 || index >= weatherData.length) return const SizedBox.shrink();

    final dateTime = DateTime.tryParse(weatherData[index].dateTime);
    final formatted = dateTime != null ? DateFormat.MMMd().format(dateTime) : '';

    return SideTitleWidget(
      meta: meta,
      space: 6,
      child: AppText(formatted, style: AppStyles.of(context).s14w400Grey.copyWith(fontSize: 8)),
    );
  }

  Widget leftTitleWidgets(BuildContext context, double value, TitleMeta meta) {
    return AppText("${value.toInt()}°", style: AppStyles.of(context).s14w400Grey.copyWith(fontSize: 8));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final spots = getTemperatureSpots();

    final minY = weatherData.map((w) => w.temperature).reduce((a, b) => a < b ? a : b) - 2;
    final maxY = weatherData.map((w) => w.temperature).reduce((a, b) => a > b ? a : b) + 2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(color: appColors.secondary, borderRadius: BorderRadius.circular(12)),
      child: AspectRatio(
        aspectRatio: 1.70,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipRoundedRadius: 8,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                tooltipPadding: const EdgeInsets.all(8),
                getTooltipColor: (touchedSpot) => appColors.primary,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      "${touchedSpot.y.toStringAsFixed(1)}°", // Tooltip text
                      const TextStyle(
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
            gridData: FlGridData(show: false),
            backgroundColor: appColors.secondary,
            borderData: FlBorderData(show: true, border: Border.all(color: appColors.secondaryGrey.withValues(alpha: .2))),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 18,
                  getTitlesWidget: (value, meta) => bottomTitleWidgets(context, value, meta),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 5,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) => leftTitleWidgets(context, value, meta),
                ),
              ),
            ),
            minX: 0,
            maxX: spots.length.toDouble() - 1,
            minY: minY,
            maxY: maxY,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: appColors.primary, // ✅ Use primary color only
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(show: false), // ❌ No gradient fill
              ),
            ],
          ),
        ),
      ),
    );
  }
}

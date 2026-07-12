import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String timeAgo(int timestamp) {
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final diff = now.difference(time);

    if (diff.inSeconds < 30) {
      return "Updated just now";
    } else if (diff.inMinutes < 1) {
      return "Updated ${diff.inSeconds}s ago";
    } else if (diff.inMinutes < 60) {
      return "Updated ${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "Updated ${diff.inHours} hr ago";
    } else if (diff.inDays < 7) {
      return "Updated ${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
    } else {
      return "Updated on ${time.day}/${time.month}/${time.year}";
    }
  }

  static String formatCompactTime(dynamic value) {
    if (value == null) return "";

    DateTime time;

    if (value is Timestamp) {
      time = value.toDate();
    } else if (value is int) {
      time = DateTime.fromMillisecondsSinceEpoch(value);
    } else {
      return "";
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final msgDay = DateTime(time.year, time.month, time.day);

    if (msgDay == today) {
      return DateFormat('HH:mm').format(time); // 14:32
    } else if (msgDay == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM').format(time); // 12/09
    }
}}

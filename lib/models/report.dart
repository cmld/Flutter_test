class ReportData {
  List<String>? _status;
  int? _testNo;
  List<DataAgg>? _dataAgg;
  String? _average;

  ReportData(
      {List<String>? status,
      String? average,
      int? testNo,
      List<DataAgg>? dataAgg}) {
    if (status != null) {
      this._status = status;
    }
    if (average != null) {
      this._average = average;
    }
    if (testNo != null) {
      this._testNo = testNo;
    }
    if (dataAgg != null) {
      this._dataAgg = dataAgg;
    }
  }

  List<String>? get status => _status;
  set status(List<String>? status) => _status = status;
  int? get testNo => _testNo;
  set testNo(int? testNo) => _testNo = testNo;
  List<DataAgg>? get dataAgg => _dataAgg;
  set dataAgg(List<DataAgg>? dataAgg) => _dataAgg = dataAgg;
  String? get average => _average;
  set average(String? average) => _average = average;

  ReportData.fromJson(Map<String, dynamic> json, String category) {
    _status = json['${category}_status'].cast<String>();
    _average = json['average'];
    _testNo = json['test_no'];
    if (json['data_agg'] != null) {
      _dataAgg = <DataAgg>[];
      json['data_agg'].forEach((v) {
        _dataAgg!.add(new DataAgg.fromJson(v, category));
      });
    }
  }
}

class DataAgg {
  String? _datetime;
  double? _min;
  double? _max;

  DataAgg({String? datetime, double? min, double? max}) {
    if (datetime != null) {
      this._datetime = datetime;
    }
    if (min != null) {
      this._min = min;
    }
    if (max != null) {
      this._max = max;
    }
  }

  String? get datetime => _datetime;
  set datetime(String? datetime) => _datetime = datetime;
  double? get min => _min;
  set min(double? min) => _min = min;
  double? get max => _max;
  set max(double? max) => _max = max;

  DataAgg.fromJson(Map<String, dynamic> json, String category) {
    _datetime = json['datetime'];
    _min = json[category][0].toDouble();
    _max = json[category][1].toDouble();
  }
}

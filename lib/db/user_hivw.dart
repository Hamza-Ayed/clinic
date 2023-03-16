import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DBHive {
  static late Box _box;
  final String boxName;

  DBHive(this.boxName);

  Future<Box> get box async {
    if (_box.isOpen) {
      return _box;
    }
    _box = await initialBox();

    return _box;
  }

  Future<Box> initialBox() async {
    final docDirect = await getApplicationDocumentsDirectory();
    final path = docDirect.path;
    Hive.init(path);
    // Hive.registerAdapter(UserAdapter());
    // Hive.registerAdapter(PatientAdapter());
    // Hive.registerAdapter(ChecksHealthAdapter());
    // Hive.registerAdapter(DrugAdapter());
    // Hive.registerAdapter(SalaryAdapter());
    // Hive.registerAdapter(DeviceAdapter());
    // Hive.registerAdapter(ClinicExpensesAdapter());

    final box = await Hive.openBox(boxName);
    await _onCreate(box);
    return box;
  }

  Future<void> _onCreate(Box box) async {
    // await _createUsersTable(box);
    // await _createPatientsTable(box);
    // await _createChecksHealthTable(box);
    // await _createDrugsTable(box);
    // await _createSalaryTable(box);
    // await _createDeviceTable(box);
    // await _createClinicExpensesTable(box);
  }

  Future<int> insert(dynamic data) async {
    final box = await this.box;
    return await box.add(data);
  }

  Future<List<dynamic>> getData() async {
    final box = await this.box;
    return box.values.toList();
  }

  Future<dynamic> get(int key) async {
    final box = await this.box;
    return box.get(key);
  }

  Future<void> deleteAll() async {
    final box = await this.box;
    await box.clear();
  }

  Future<void> delete(int key) async {
    final box = await this.box;
    await box.delete(key);
  }
}

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String doctorId;
  @HiveField(4)
  final String devicename;

  User(this.id, this.username, this.password, this.doctorId, this.devicename);
}

  @HiveField(0)
  late final int id;
  @HiveField(1)
  late final String patintName;
  @HiveField(2)
  late final int birhdate;
  @HiveField(3)
  late final String gender;
  @HiveField(4)
  late final String site;
  @HiveField(5)
  late final String phone;
 




import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PhotoService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> captureProofPhoto(int taskId) async {
    final XFile? captured = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 1280,
    );

    if (captured == null) return null;

    final docsDir = await getApplicationDocumentsDirectory();
    final proofsDir = Directory(p.join(docsDir.path, 'task_proofs'));
    if (!await proofsDir.exists()) {
      await proofsDir.create(recursive: true);
    }

    final fileName =
        'proof_${taskId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedPath = p.join(proofsDir.path, fileName);

    await File(captured.path).copy(savedPath);

    return savedPath;
  }

  static Future<void> deleteProofPhoto(String? path) async {
    if (path == null || path.isEmpty) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:note_now/model/services/gemini_api_call.dart';

class GeminiCallNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _read;
  GeminiCallNotifier(this._read) : super(const AsyncData(null));

  final geminiCall = GeminiApiCall();

  Future<String?> geminiApiCall (
    {required String noteContent}
  ) async{
    state = const AsyncLoading();

    try {
      final result = await geminiCall.makeRequest(
      noteContent: noteContent,
    );

    if (result.success) {
      state = AsyncData(result.data);
      return result.data;
    } else{
      state = AsyncData(null);
      return null;
      
    }

    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }

    

  }
  
}

final geminiCallProvider = StateNotifierProvider<GeminiCallNotifier, AsyncValue<void>>(
  (ref) => GeminiCallNotifier(ref)
);
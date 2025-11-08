import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note_now/view/authentication/utils/auth_utils.dart';
import 'package:note_now/view_model/providers/gemini_call_provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NoteDetailsScreen extends ConsumerStatefulWidget {
  const NoteDetailsScreen({super.key});

  @override
  ConsumerState<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends ConsumerState<NoteDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();

  bool isListening = false;
  bool isSummarizing = false;
  bool _speechEnabled = false;
  String get _lastWords => _noteController.text;

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  void  useGemini (WidgetRef ref) async {
    final geminiCall =  ref.read(geminiCallProvider.notifier);


    final responseText = await geminiCall.geminiApiCall(
      noteContent: _lastWords,
    );

    

    setState(() {
      _noteController.text = responseText.toString();
     
    });


  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _noteController.text = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF6366F1);
    final accentColor = const Color(0xFF10B981);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black87),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          "New Note",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.save_2, color: Colors.black87),
            onPressed: () {
              // TODO: Implement save logic to Firebase or local storage
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Note Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: "Start typing or use voice input...",
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // 🎤 Speech-to-Text Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: 
                    // / If not yet listening for speech start, otherwise stop
                    _speechToText.isNotListening ? _startListening : _stopListening,
                    // onPressed: () {
                    //   setState(() {
                    //     isListening = !isListening;
                    //   });
                    //   // TODO: Add speech-to-text logic here
                    // },
                    icon: Icon(
                      isListening ? Iconsax.microphone_25 : Iconsax.microphone_2,
                      color: Colors.white,
                    ),
                    label: Text(
                      isListening ? "Listening..." : "Voice Input",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 🤖 Summarize Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => isSummarizing = true);
                      useGemini(ref);
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() => isSummarizing = false);
                    },
                    icon: Icon(
                      Iconsax.magicpen,
                      color: Colors.white,
                    ),
                    label: Text(
                      isSummarizing ? "Summarizing..." : "Summarize",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

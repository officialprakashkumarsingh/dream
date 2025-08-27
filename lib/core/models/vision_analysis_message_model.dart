import 'message_model.dart';

class VisionAnalysisMessage extends Message {
  final bool isAnalyzing;
  final String? analysisPrompt;
  final String? analysisResult;

  VisionAnalysisMessage({
    required String id,
    this.isAnalyzing = true,
    this.analysisPrompt,
    this.analysisResult,
    bool hasError = false,
    super.toolCalls,
  }) : super(
          id: id,
          content: analysisResult ?? '',
          type: MessageType.assistant,
          timestamp: DateTime.now(),
          isStreaming: isAnalyzing,
          hasError: hasError,
        );

  @override
  VisionAnalysisMessage copyWith({
    String? id,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isStreaming,
    bool? hasError,
    List<Map<String, dynamic>>? toolCalls,
    bool? isAnalyzing,
    String? analysisPrompt,
    String? analysisResult,
  }) {
    return VisionAnalysisMessage(
      id: id ?? this.id,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      analysisPrompt: analysisPrompt ?? this.analysisPrompt,
      analysisResult: content ?? analysisResult ?? this.analysisResult,
      hasError: hasError ?? this.hasError,
      toolCalls: toolCalls ?? this.toolCalls,
    );
  }
}
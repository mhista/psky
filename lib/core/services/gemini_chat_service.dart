import 'dart:async';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/coach_kai/presentation/business/cubits/chat_cubit.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/gemini_tools.dart';

@lazySingleton
class GeminiChatService {
  Future<void> sendAiMessage(String message) async {
    final chatSession = getIt<ChatSession>();
    try {
      final responseStream = await chatSession.sendMessage(
        Content.text(message),
      );
      pskyLog("Function Response: ${responseStream.text}");

      if (responseStream.functionCalls.isNotEmpty) {
        final geminiTools = getIt<GeminiTools>();
        final respondStream = await chatSession.sendMessage(
          Content.functionResponses([
            for (final functionCall in responseStream.functionCalls)
              FunctionResponse(
                functionCall.name,
                await geminiTools.handleFunctionCall(
                  functionCall.name,
                  functionCall.args,
                ),
              ),
          ]),
        );
        final responseText = respondStream.text;
        if (responseText != null) {
          pskyLog("Function Response: $responseText");
          // logStateNotifier.logLlmText(responseText);
        }
      pskyLog("Function Response: ${responseStream.text}");

      }
    } catch (e) {
      print(e);
      
    }
  }

  Future<void> sendMessage(String message) async {
    final chatSession = getIt<ChatSession>();
    final chatStateNotifier = getIt<ChatCubit>();
    // final logStateNotifier = ref.read(logStateNotifierProvider.notifier);

    chatStateNotifier.addUserMessage(message);

    // logStateNotifier.logUserText(message);
    final llmMessage = chatStateNotifier.createLlmMessage();
    try {
      // Modify from here...
      final responseStream = chatSession.sendMessageStream(
        Content.text(message),
      );
      await for (final block in responseStream) {
        await _processBlock(block, llmMessage.id);
      } // To here.
    } catch (e) {
      // logStateNotifier.logError(e, st: st);
      debugPrint(e.toString());
      chatStateNotifier.appendToMessage(
        llmMessage.id,
        "\nI'm sorry, I encountered an error processing your request. "
        "Please try again.",
      );
    } finally {
      chatStateNotifier.finalizeMessage(llmMessage.id);
    }
  }

  Future<void> _processBlock(
    // Add from here...
    GenerateContentResponse block,
    String llmMessageId,
  ) async {
    final chatSession = getIt<ChatSession>();
    final chatStateNotifier = getIt<ChatCubit>();
    // final logStateNotifier = ref.read(logStateNotifierProvider.notifier);
    final blockText = block.text;

    if (blockText != null) {
      // logStateNotifier.logLlmText(blockText);
      debugPrint("LLM Response: $blockText");
      chatStateNotifier.appendToMessage(llmMessageId, blockText);
    }

    if (block.functionCalls.isNotEmpty) {
      final geminiTools = getIt<GeminiTools>();
      final responseStream = chatSession.sendMessageStream(
        Content.functionResponses([
          for (final functionCall in block.functionCalls)
            FunctionResponse(
              functionCall.name,
              await geminiTools.handleFunctionCall(
                functionCall.name,
                functionCall.args,
              ),
            ),
        ]),
      );
      await for (final response in responseStream) {
        final responseText = response.text;
        if (responseText != null) {
          pskyLog("Function Response: $responseText");
          // logStateNotifier.logLlmText(responseText);
          chatStateNotifier.appendToMessage(llmMessageId, responseText);
        }
      }
    }
  } // To here.
}

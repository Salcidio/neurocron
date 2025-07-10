import 'package:flutter/material.dart';

class FlakesPage extends StatefulWidget {
  @override
  _FlakesPageState createState() => _FlakesPageState();
}

class _FlakesPageState extends State<FlakesPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  bool _isDarkTheme = false;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final userMessage = _controller.text.trim();
    setState(() {
      _messages.add({'role': 'user', 'text': userMessage});
      _messages.add({'role': 'assistant', 'text': 'This is a response to "$userMessage"'});
    });
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = _isDarkTheme ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("AI Assistant"),
          actions: [
            IconButton(
              icon: Icon(_isDarkTheme ? Icons.wb_sunny : Icons.dark_mode),
              onPressed: () {
                setState(() => _isDarkTheme = !_isDarkTheme);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['role'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(message['text'] ?? ''),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    // Implement voice input logic
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    label: Text("Summarize"),
                    onPressed: () {
                      _controller.text = "Summarize this text:";
                    },
                  ),
                  ActionChip(
                    label: Text("Translate"),
                    onPressed: () {
                      _controller.text = "Translate this to French:";
                    },
                  ),
                  ActionChip(
                    label: Text("Explain"),
                    onPressed: () {
                      _controller.text = "Explain this concept:";
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

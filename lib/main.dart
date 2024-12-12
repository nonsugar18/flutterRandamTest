import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MultiplicationQuizApp());
}

class MultiplicationQuizApp extends StatelessWidget {
  const MultiplicationQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '九九乘法表隨機問題',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MultiplicationQuizPage(),
    );
  }
}

class MultiplicationQuizPage extends StatefulWidget {
  const MultiplicationQuizPage({super.key});

  @override
  _MultiplicationQuizPageState createState() => _MultiplicationQuizPageState();
}

class _MultiplicationQuizPageState extends State<MultiplicationQuizPage> {
  final _random = Random();
  int _num1 = 1;
  int _num2 = 1;
  int? _userAnswer;
  String _resultMessage = '';
  int _score = 0; // 追蹤答對題數的變數
  int _wrongScore = 0; // 追蹤答對題數的變數

  // 初始化新問題
  void _generateNewQuestion() {
    setState(() {
      _num1 = _random.nextInt(9) + 1; // 隨機生成 1 到 9 的數字
      _num2 = _random.nextInt(9) + 1; // 隨機生成 1 到 9 的數字
      _userAnswer = null;
      _resultMessage = '';
    });
  }

  // 檢查用戶答案是否正確
  void _checkAnswer() {
    setState(() {
      if (_userAnswer == _num1 * _num2) {
        _resultMessage = '正確！';
        _score++; // 答對時增加得分
      } else {
        _resultMessage = '錯誤，答案是 ${_num1 * _num2}。';
        _wrongScore++; // 答對時增加得分
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _generateNewQuestion(); // 初始時生成一個問題
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('九九乘法表隨機問題'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '問題：$_num1 × $_num2 = ?',
              style: const TextStyle(fontSize: 24),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '輸入您的答案'),
              onChanged: (value) {
                _userAnswer = int.tryParse(value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('確認答案'),
            ),
            const SizedBox(height: 16),
            Text(
              _resultMessage,
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 16),
            Text(
              '目前答對題數：$_score', // 顯示當前得分
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              '目前錯誤題數：$_wrongScore', // 顯示當前得分
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateNewQuestion,
              child: const Text('下一題'),
            ),
          ],
        ),
      ),
    );
  }
}

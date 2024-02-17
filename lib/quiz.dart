import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;
  late List<Map<String, dynamic>> _questions;

  Future<void> _fetchQuestions() async {
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=5&category=17')); // Category 17 corresponds to Science: Nature
    final responseData = json.decode(response.body);
    setState(() {
      _questions = List<Map<String, dynamic>>.from(
          responseData['results'].map((question) => {
            'questionText': question['question'],
            'correctAnswer': question['correct_answer'],
            'incorrectAnswers': List<String>.from(question['incorrect_answers'])
          }));
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _fetchQuestions(); // Fetch new questions when restarting quiz
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Environment Quiz'),
      ),
      body: _questions == null
          ? Center(child: CircularProgressIndicator())
          : _questionIndex < _questions.length
          ? Quiz(
        questionIndex: _questionIndex,
        questions: _questions,
        answerQuestion: _answerQuestion,
      )
          : Result(_totalScore, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          questions[questionIndex]['questionText'] as String,
          style: TextStyle(fontSize: 24),
        ),
        ...(questions[questionIndex]['incorrectAnswers'] as List<String>
          ..add(questions[questionIndex]['correctAnswer'] as String))
            .map((answer) {
          return ElevatedButton(
            onPressed: () {
              if (answer == questions[questionIndex]['correctAnswer']) {
                answerQuestion(10); // Add score if the answer is correct
              } else {
                answerQuestion(0); // No score if the answer is incorrect
              }
            },
            child: Text(answer),
          );
        }).toList(),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 20) {
      resultText = 'Great job! You scored $resultScore';
    } else if (resultScore >= 10) {
      resultText = 'Not bad! You scored $resultScore';
    } else {
      resultText = 'You can do better! You scored $resultScore';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: resetHandler,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

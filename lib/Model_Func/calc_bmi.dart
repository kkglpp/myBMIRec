class CalcBMI {
  calcbmi(double height, double weight) {
    double bmiResult = (weight) / ((height / 100) * (height / 100));

    return bmiResult;
  }

  classbmi(double bmi) {
    String rs = "저체중";
    int rsInt = 0;
    if (bmi > 18.5) {
      rs = "정상";
      rsInt = 1;
    }
    if (bmi > 22.9) {
      rs = "과체중";
      rsInt = 2;
    }
    if (bmi > 25) {
      rs = "비만 1단계";
      rsInt = 3;
    }
    if (bmi > 30) {
      rs = "비만 2단계";
      rsInt = 4;
    }
    if (bmi > 34.9) {
      rs = "비만 3단계";
      rsInt = 5;
    }
    return [rsInt, rs];
  }
}

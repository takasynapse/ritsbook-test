class PassWordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'パスワードを入力してください';
    }
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    }
    if (value.length > 99) {
      return 'パスワードは99文字以下で入力してください';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'パスワードは小文字を含めてください';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'パスワードは大文字を含めてください';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'パスワードは数字を含めてください';
    }
    if (!RegExp(r'[!-/:-@[-`{-~]').hasMatch(value)) {
      return 'パスワードは記号を含めてください';
    }
    // ひらがなが入力された時のエラー
    if (RegExp(r'[ぁ-ん]').hasMatch(value)) {
      return 'パスワードは半角英数字と半角記号のみ入力可能です';
    }
    // 全角が入力された時のエラー
    if (RegExp(r'[一-龥]').hasMatch(value) ||  RegExp(r'[^\x01-\x7E]').hasMatch(value)) {
      return 'パスワードは半角英数字と半角記号のみ入力可能です';
    }
    // スペースが入力された時のエラー
    if (RegExp(r'\s').hasMatch(value)) {
      return 'パスワードは半角英数字と半角記号のみ入力可能です';
    }
    return null;
  }
}

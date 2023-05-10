class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    // 「ー」を含む正規表現
    if (!RegExp(r'^.+@[a-zA-Z-]+\.{1}[a-zA-Z-]+(\.{0,1}[a-zA-Z-]+)$')
        .hasMatch(value)) {
      return '正しいメールアドレスを入力してください';
    }
    // 全角英数字、記号以外の文字が入力された時のエラー
    if (RegExp(r'[ぁ-ん一-龥]').hasMatch(value)) {
      return '半角英数字と半角記号のみ入力可能です';
    }
    return null;
  }
}
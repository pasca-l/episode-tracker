class JapaneseCharacterCode {
  static const List<String> _kanaOrder = [
    // A-row
    'あ', 'ぁ', 'ア', 'ァ',
    'い', 'ぃ', 'イ', 'ィ',
    'う', 'ぅ', 'ウ', 'ゥ',
    'え', 'ぇ', 'エ', 'ェ',
    'お', 'ぉ', 'オ', 'ォ',
    // KA-row
    'か', 'が', 'カ', 'ガ',
    'き', 'ぎ', 'キ', 'ギ',
    'く', 'ぐ', 'ク', 'グ',
    'け', 'げ', 'ケ', 'ゲ',
    'こ', 'ご', 'コ', 'ゴ',
    // SA-row
    'さ', 'ざ', 'サ', 'ザ',
    'し', 'じ', 'シ', 'ジ',
    'す', 'ず', 'ス', 'ズ',
    'せ', 'ぜ', 'セ', 'ゼ',
    'そ', 'ぞ', 'ソ', 'ゾ',
    // TA-row
    'た', 'だ', 'タ', 'ダ',
    'ち', 'ぢ', 'チ', 'ヂ',
    'つ', 'っ', 'づ', 'ツ', 'ッ', 'ヅ',
    'て', 'で', 'テ', 'デ',
    'と', 'ど', 'ト', 'ド',
    // NA-row
    'な', 'ナ',
    'に', 'ニ',
    'ぬ', 'ヌ',
    'ね', 'ネ',
    'の', 'ノ',
    // HA-row
    'は', 'ば', 'ぱ', 'ハ', 'バ', 'パ',
    'ひ', 'び', 'ぴ', 'ヒ', 'ビ', 'ピ',
    'ふ', 'ぶ', 'ぷ', 'フ', 'ブ', 'プ',
    'へ', 'べ', 'ぺ', 'ヘ', 'ベ', 'ペ',
    'ほ', 'ぼ', 'ぽ', 'ホ', 'ボ', 'ポ',
    // MA-row
    'ま', 'マ',
    'み', 'ミ',
    'む', 'ム',
    'め', 'メ',
    'も', 'モ',
    // YA-row
    'や', 'ゃ', 'ヤ', 'ャ',
    'ゆ', 'ゅ', 'ユ', 'ュ',
    'よ', 'ょ', 'ヨ', 'ョ',
    // RA-row
    'ら', 'ラ',
    'り', 'リ',
    'る', 'ル',
    'れ', 'レ',
    'ろ', 'ロ',
    // WA-row
    'わ', 'ワ',
    'を', 'ヲ',
    'ん', 'ン'
  ];

  static String sanitize(String text) {
    // remove all non-kana characters
    return text.replaceAll(RegExp(r'[^\u3042-\u307D\u30A2-\u30DD]'), '');
  }

  static int compare(String a, String b) {
    for (var i = 0; i < a.length && i < b.length; i++) {
      final aChar = a[i];
      final bChar = b[i];
      final aIndex = _kanaOrder.indexOf(aChar);
      final bIndex = _kanaOrder.indexOf(bChar);
      
      if (aIndex != bIndex) {
        return aIndex - bIndex;
      }
    }
    return a.length - b.length;
  }
}

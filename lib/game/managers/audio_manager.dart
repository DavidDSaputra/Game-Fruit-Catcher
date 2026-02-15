import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool musicOn = true;
  bool sfxOn = true;

  Future<void> initialize() async {
    await FlameAudio.audioCache.loadAll([
      'music/background_music.mp3',
      'sfx/collect.mp3',
      'sfx/explosion.mp3',
      'sfx/jump.mp3',
    ]);
  }

  void playBackgroundMusic() {
    if (musicOn) {
      FlameAudio.bgm.play(
        'music/background_music.mp3',
        volume: 0.7,
      );
    }
  }

  void toggleMusic() {
    musicOn = !musicOn;
    if (musicOn) {
      playBackgroundMusic();
    } else {
      FlameAudio.bgm.stop();
    }
  }

  void toggleSfx() {
    sfxOn = !sfxOn;
  }

  void playSfx(String file) {
    if (sfxOn) {
      FlameAudio.play('sfx/$file');
    }
  }
}

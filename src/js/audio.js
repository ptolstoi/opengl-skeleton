var LibraryAudio = {
    audioInit: function() {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        console.log("initing audio... sort of :D");
        this.audioContext = new AudioContext();

        this.audioStart = 0;
    },
    audioUpdate: function() {
        if (audioStart == 0) {
            this.oscillator = audioContext.createOscillator();
            oscillator.frequency.value = 261.63;
            oscillator.type = "square";

            // Attach to destination
            oscillator.connect(audioContext.destination);

            // Play oscillator
            oscillator.start(0);
            this.audioStart = _emscripten_get_now();
        }
        if (_emscripten_get_now() - this.audioStart > 100) {
            oscillator.stop();
        }
    },
}

autoAddDeps(LibraryAudio, '$Audio');
mergeInto(LibraryManager.library, LibraryAudio);

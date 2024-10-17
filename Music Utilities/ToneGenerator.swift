import SwiftUI

struct ToneGenerator: View {
    @StateObject var soundEngine = SoundEngine()
    @StateObject var noteEngine = NoteEngine()
    
    var body: some View {
        VStack {
            Button(action: {
                noteEngine.octaveUp()
                soundEngine.updateFrequency(frequency: noteEngine.current_frequency)
            }) {
                Image(systemName: "arrowtriangle.up.circle.fill")
            }
            
            HStack {
                Button(action: {
                    noteEngine.nextNoteDown()
                    soundEngine.updateFrequency(frequency: noteEngine.current_frequency)
                }) {
                    Image(systemName: "minus")
                }.padding()

                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text(noteEngine.current_note)
                        .foregroundColor(.red)
                        .font(.system(size: 60))
                    Text(String(noteEngine.current_octave))
                        .foregroundColor(.gray)
                        .font(.system(size: 40))
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(width: 40)
                .padding()

                Button(action: {
                    noteEngine.nextNoteUp()
                    soundEngine.updateFrequency(frequency: noteEngine.current_frequency)
                }) {
                    Image(systemName: "plus")
                }.padding()
            }
            
            Button(action: {
                noteEngine.octaveDown()
                soundEngine.updateFrequency(frequency: noteEngine.current_frequency)
            }) {
                Image(systemName: "arrowtriangle.down.circle.fill")
            }
            
            
            Text(String(format: "%.2f", noteEngine.current_frequency)+"Hz").font(.system(size: 20))
                .padding()
            
            Button(action: {
                soundEngine.togglePlayPause(frequency: noteEngine.current_frequency)
            }) {
                Image(systemName: "play.fill")
                    .foregroundColor(soundEngine.isPlaying ? .red : .gray)
            }.padding()
        }
    }
}

struct ToneGenerator_Previews: PreviewProvider {
    static var previews: some View {
        ToneGenerator()
    }
}


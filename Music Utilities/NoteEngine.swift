import SwiftUI

class NoteEngine: ObservableObject {
    var note_names: [String] = ["A", "A♯", "B", "C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯"]
    @Published var current_note: String
    @Published var current_octave: Int
    @Published var current_frequency: Float

    init(base_note: String = "A", base_octave: Int = 4, base_frequency: Float = 440.0) {
        self.current_note = base_note
        self.current_octave = base_octave
        self.current_frequency = base_frequency
    }
    
    func nextNoteUp() {
        if self.current_note == "G♯" {
            if self.current_octave == Constants.MAX_OCTAVE {
                return
            }
            self.current_note = "A"
            self.current_octave += 1
        } else {
            if let currentIndex = note_names.firstIndex(of: self.current_note) {
                let nextIndex = (currentIndex + 1) % note_names.count
                self.current_note = note_names[nextIndex]
            }
        }
        self.current_frequency *= Constants.FREQ_DISTANCE
    }
    
    func nextNoteDown() {
        if self.current_note == "A" {
            if self.current_octave == Constants.MIN_OCTAVE {
                return
            }
            self.current_note = "G♯"
            self.current_octave -= 1
        } else {
            if let currentIndex = note_names.firstIndex(of: self.current_note) {
                let nextIndex = (currentIndex - 1) % note_names.count
                self.current_note = note_names[nextIndex]
            }
        }
        self.current_frequency /= Constants.FREQ_DISTANCE
    }
    
    func octaveUp() {
        if self.current_octave == Constants.MAX_OCTAVE {
            return
        }
        self.current_octave += 1
        self.current_frequency *= 2
    }
    
    func octaveDown() {
        if self.current_octave == Constants.MIN_OCTAVE {
            return
        }
        self.current_octave -= 1
        self.current_frequency /= 2
    }
}


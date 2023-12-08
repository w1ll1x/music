
# Chord array used by loop_one, chords made up of MIDI notes loosely inspired
# by Fade Into You by Mazzy Star

chords1 = [
  [57, 61, 64],
  [66, 61, 64],
  [52, 56, 59],
  [62, 59, 54],
  [59, 62, 66],
  [50, 54, 57]
]

# Chord array used by loop_two, chords made using sonic pi module

chords2 = [
  chord(:c, :major7),
  chord(:d, :m7),
  chord(:g, :major7),
  chord(:a, :m7)
]

# Chord array used by loop_three once again made from MIDI notes

chords3 = [
  [62, 66, 69],
  [57, 61, 64],
  [60, 64, 67],
  [55, 59, 62]
]

# Function to play the first loop
define :play_first_loop do
  with_fx :reverb, room: 0.8 do
    use_synth :dark_ambience
    chords1.each do |midi_notes|
      # Play the chord
      play_chord midi_notes, attack: 0.5, sustain: 3, release: 2
      
      use_synth :hollow
      # plays the individual MIDI notes to arpegiate each chord
      midi_notes.each do |note|
        play note
        sleep 0.5
      end
      sleep 2
    end
  end
end


# Function to play the second loop, inspired by social network soundtrack
define :play_second_loop do
  # Define note volume variable to reduce volume each iteration of loop
  note_vol = 0.75
  chords2.each do |chord|
    use_synth :dark_ambience
    play chord, sustain: 17, attack: 2, amp:4
    use_synth :piano
    
    play 66, sustain: 2,amp: note_vol
    sleep 2
    
    play 64, sustain: 1,amp: note_vol
    sleep 1
    
    play 55, sustain: 3,amp: note_vol
    sleep 3
    
    play 64, sustain: 2,amp: note_vol
    sleep 2
    
    play 62, sustain: 1,amp: note_vol
    sleep 1
    
    play 50, sustain: 8,amp: note_vol
    sleep 8
    
    #reduce not volume each iteration by 80%
    note_vol = note_vol * 0.8
  end
end

# Function to play third loop
define :play_third_loop do
  # Function plays similar to first loop, but in reverse with arpegio before chord
  with_fx :reverb, room: 0.8 do
    use_synth :dark_ambience
    #Note sleep variable reduced each loop iteration
    note_sleep = 1
    chords3.each do |midi_notes|
      use_synth :kalimba
      midi_notes.each do |note|
        play note, amp:3
        sleep 0.75
      end
      use_synth :hollow
      play_chord midi_notes,attack: 1, sustain: 4, release: 2
      sleep 4
      note_sleep *= 0.75
    end
  end
end

# Function to play fourth loop by inverting each chord
define :play_fourth_loop do
  # The chord progression is commonly found in pop music
  use_synth :kalimba
  2.times do |i|
    use_synth :kalimba
    [1, 3, 6, 4].each do |d|
      #range changes with each iteration
      (range -3, i).each do |i|
        play_chord (chord_degree d, :c, :major, 3, invert: i), sustain: 1, amp: 6
        sleep 1
      end
    end
    
    [1, 3, 6, 4].each do |d|
      (range -3, i).each do |i|
        play_chord (chord_degree d, :f, :major, 3, invert: i), sustain: 1, amp: 6
        sleep 1
      end
    end
    
    [1, 3, 6, 4].each do |d|
      (range -3, i).each do |i|
        play_chord (chord_degree d, :g, :major, 3, invert: i), sustain: 1, amp: 6
        sleep 1
      end
    end
  end
end


# This is where all of the methods are called
2.times do |i|
  play_first_loop
end

1.times do |i|
  sleep 2
  play_fourth_loop
end

1.times do |i|
  use_synth :dark_ambience
  play_chord [1, 3, 6, 4], sustain: 8, attack: 4, amp: 6
  sleep 8
  play_second_loop
end

3.times do |i|
  play_third_loop
end






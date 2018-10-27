class AudioConverter
  def initialize path
    @audio = path
  end

  def speech_streaming_recognize
    require "google/cloud/speech"

    speech = Google::Cloud::Speech.new

    audio_content  = File.binread @audio
    bytes_total    = audio_content.size
    bytes_sent     = 0
    chunk_size     = 32000

    streaming_config = {config: {encoding:                :LINEAR16,
                                 sample_rate_hertz:       16000,
                                 language_code:           "en-US",
                                 enable_word_time_offsets: true     },
                        interim_results: true}

    stream = speech.streaming_recognize streaming_config

    # Simulated streaming from a microphone
    # Stream bytes...
    while bytes_sent < bytes_total do
      stream.send audio_content[bytes_sent, chunk_size]
      bytes_sent += chunk_size
      sleep 1
    end

    puts "Stopped passing"
    stream.stop

    # Wait until processing is complete...
    stream.wait_until_complete!

    results = stream.results
    # [END speech_ruby_migration_streaming_request]

    alternatives = results.first.alternatives
    alternatives.each do |result|
      puts "Transcript: #{result.transcript}"
    end
  end
end
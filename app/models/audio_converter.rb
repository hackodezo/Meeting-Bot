class AudioConverter
  def initialize path
    @audio = path
  end

  def speech_streaming_recognize
    require "google/cloud/speech"

    speech = Google::Cloud::Speech.new

    audio_content  = File.binread(@audio)
    bytes_total    = audio_content.size
    bytes_sent     = 0
    chunk_size     = 32000

    streaming_config = {config: {encoding:                :FLAC,
                                 sample_rate_hertz:       44100,
                                 language_code:           "en-US",
                                 enable_word_time_offsets: true     },
                        interim_results: true}

    audio  = { content: audio_content }
    response = speech.recognize(streaming_config[:config], audio)
    results = response.results
    message = ""
    return "nothing to transpile" unless results.first.present?
    results.first.alternatives.each do |alternatives|
      message += "#{alternatives.transcript}"
    end
    puts message
    message
  end
end
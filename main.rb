require 'progressbar'

def generate_signal(len, noize, value)
  arr = []
  len.times do
    arr.push((value + rand() * noize - + rand() * noize).ceil)
  end
  arr
end

# _/\_
def add_spike_1(signal, size, offset)
  signal[offset - 2] += (0.3 * size).ceil if offset > 1
  signal[offset - 1] += (0.6 * size).ceil if offset > 0
  signal[offset] += size
  signal[offset + 2] += (0.3 * size).ceil if offset < signal.size - 2
  signal[offset + 1] += (0.6 * size).ceil if offset < signal.size - 1
  signal
end

# _/\_
def add_step(signal, size, offset)
  res = []
  signal.each_with_index do |v, i|
    if i >= offset
      res.push(v + size)
    else
      res.push(v)
    end
  end
  res
end

def start
  dataset_size = 100_000
  len = 500
  value = 50
  noize = 5
  spike_size = 12
  file = File.open("./data/signal_#{dataset_size}_#{len}.csv", 'w')

  file.write("#{(0...len).map{|i| "s#{i + 1}" }.join(',')},#{(0...len).map{|i| "spike#{i + 1}" }.join(',')},no_spike\n")
  progressbar = ProgressBar.create(total: dataset_size)

  dataset_size.times do
    progressbar.increment
    signal = generate_signal(len, noize, value)
    file.write("#{signal.join(',')},#{(0...len).map{|_| 0}.join(',')},1\n")
    offset = rand(len)
    signal_with_spike = add_step(signal, spike_size, offset)
    file.write("#{signal_with_spike.join(',')},#{(0...len).map{|i| i == offset ? 1 : 0 }.join(',')},0\n")
  end
  file.close
end

start

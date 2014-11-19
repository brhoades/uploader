#!/usr/bin/ruby

require 'optparse'

SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/" # vvv
URL="http://#{SITE}/"  #filename is put on the end of this
UMASK=775
PORT=22

SCREENSHOT = 0
opt = { auto:  false, 
        q:     80,
        sel:   false,
        filetype:  "png" }

# Determine what we are doing
OptionParser.new do |o|
  # o.banner

  o.on '-c', '--screenshot', "Take a screenshot and upload it" do
    opt[:type] = SCREENSHOT
  end

  o.on '-a', '--auto', "Automatically perform the action with no input" do
    opt[:auto] = true
  end

  o.on '-s', '--selection', "Select area for a screenshot" do
    opt[:sel] = true
  end

  o.on '-q N', '--quality', "Set a quality for the image" do |q|
    opt[:q] = q
  end

  o.on '-t TYPE', '--file-type', "Set the image file type" do |t|
    opt[:filetype] = t
  end

end.parse!

# Now deal with it
if opt[:type] == SCREENSHOT
  if not opt[:auto]
    # do stuff beforehand
  end

  com = "scrot" 

  if opt[:sel] != false
    com += " -s"
  end

  com += " -q" + opt[:q].to_s

  # Add destination name
  c = ('a'..'z').to_a | ('A'..'Z').to_a | ('0'..'9').to_a
  fn = (0..5).map { c[rand(c.size-1)] }.join + "." + opt[:filetype]
  tmppath = "/tmp/" + fn 
  com += " " + tmppath

  `#{com}`
  `chmod #{UMASK} #{tmppath}`
  `scp -p -P #{PORT} #{tmppath} #{USER}@#{SITE}:#{DIR}#{fn}`

  print "#{URL}#{fn}"
  `notify-send 'Uploaded and pasted into clipboard.' #{URL}#{fn} --icon=dialog-information`
  `echo "#{URL}#{fn}" | xsel --clipboard -i`
end


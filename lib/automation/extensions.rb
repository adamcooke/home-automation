class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def yellow
    "\e[33m#{self}\e[0m"
  end

  def cyan
    "\e[34m#{self}\e[0m"
  end

  def purple
    "\e[35m#{self}\e[0m"
  end

  def blue
    "\e[36m#{self}\e[0m"
  end

  def camelize
    string = self.sub(/^[a-z\d]*/) { $&.capitalize }
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
  end
end

class PostcodeChecker
  def valid?(postcode)
    if postcode.match(/^[a-z]{1,2}\d[a-z\d]?\s*\d[a-z]{2}$/i)
        # Reference: https://regex101.com/
        # type this regex in the textbox and hover each to see what it does..

      return true
    else
      return false
    end
  end
end
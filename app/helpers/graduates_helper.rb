#Helper functions specific to the graduate actions
module GraduatesHelper
  def display_full_name
    fname = @graduate.first_name
    lname = @graduate.last_name
    fullname = ""
    if !fname.blank?
      fullname += fname
    end
    if !lname.blank?
      fullname += " " + lname
    end
    (fullname.empty? ? "Profile incomplete!" : fullname)
  end
  def display_formatted_address
    address1 = @graduate.address_1
    address2 = @graduate.address_2
    address = ""
    if !address1.blank?
      address += address1 + "<br/>"
      if !address2.blank?
        address += address2 + "<br/>"
      end
      address += @graduate.city + ", " +
        @graduate.state + "  " +
        @graduate.zip_code + "<br/>"
    end
    raw(address)
  end
  def display_phone
    ph = @graduate.phone
    if !ph.blank?
      phone = "Phone: " + ph + "<br/>"
    end
    raw(phone)
  end
  def full_name(grad)
    return false if grad.nil?
    first_name = grad.first_name
    last_name = grad.last_name
    (first_name.blank? ? "(incomplete" : first_name) + " " +
    (last_name.blank? ? "profile)" : last_name)
  end
end
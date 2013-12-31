#Helper functions specific to the member actions
module MembersHelper
  def display_full_name
    fname = @member.first_name
    lname = @member.last_name
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
    address1 = @member.address_1
    address2 = @member.address_2
    address = ""
    if !address1.blank?
      address += address1 + "<br/>"
      if !address2.blank?
        address += address2 + "<br/>"
      end
      address += @member.city + ", " +
        @member.state + "  " +
        @member.zip_code + "<br/>"
    end
    raw(address)
  end
  def display_phone
    ph = @member.phone
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
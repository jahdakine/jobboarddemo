#Defines actions for static documents in footer
class DocsController < ApplicationController
  skip_before_filter :authenticate

  def contact_us
  end

  def user_agreement
  end

  def privacy_policy
  end
end
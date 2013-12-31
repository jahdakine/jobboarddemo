#Global helper functions
module ApplicationHelper
  def sanitized(element)
    sanitize element,
      :tags => %w(
        table tr td p div ul li ol strong b em i h1 h2 h3 h4 h5 h6
        sup sub code pre div blockquote span
      ),
      :attributes => %w(id class style)
  end

  def prewrap_form(obj, label, icon, pos='')
    obj += '_' if !obj.blank?
    html = <<-HTML
    <div class="control-group #{pos}" style="margin-right:25px;">
      <label class="control-label" for="#{obj}#{label.downcase}">
        #{label.tr("_", " ")}
      </label>
      <div class="controls">
        <div class="input-prepend input-append">
          <span class="add-on"><i class="icon-#{icon}"></i></span>
    HTML
    html.html_safe
  end

  def postwrap_form(msg)
    if !msg.blank?
      append = "
      <span class=\"add-on\">
        <a href=\"#\" title=\"#{msg}\" tabindex=\"-1\">
          <i class=\"icon-asterisk\"></i>
        </a>
      </span>
      "
    else
      append = ''
    end
    html = <<-HTML
          #{append}
        </div>
      </div>
    </div>
    HTML
    html.html_safe
  end

  #only needed for demo - translator
  def role(type)
    role = 'Employer' if type == 'Employer'
    role = 'Job Seeker' if type == 'Member'
    role = 'Administrator' if type == 'Admin'
    return role
  end

  def display_note(type)
    case type
      when 'date'
        note = '
<br>NOTE: Opening dates in the future, closing dates in the past,
and active status of \'No\' will not be shown in published listings.
These are marked in <span class="red">red</span>.'
      when 'password'
        note = '
<br>Instructions: Password must be between 6 and 20 characters of mixed case
and contain at least one number and one special character.'
      when 'filter'
        note = '
Enter search terms in search field. Further restrict results by selecting
filter choice(s). Use header links to sort the output. Reset will clear
the search criteria and return all available openings.'
      when 'dropouts'
        note = '
<br>NOTE: Users who have logged in once and not updated their profiles are
marked in <span class="lightred">light red</span>. Dropouts (registrations
over 3 months old) are shown in <span class="red">red</span>.'
      when 'users'
        note = '
Instructions: Use this listing to view and perform actions on all users.
Use of Delete should be limited to users who have not participated or made
obvious errors or given malicious or inappropriate input.'
      when 'interests'
        note = '
Instructions: Be careful with edits and deletions. Typically these actions
should only be used on new unassociated records that are misspelled or
accidental.'
      when 'employers'
        note = '
Instructions: Use this listing to view and perform actions on all Employer
users. Use of Edit and Delete should be limited to users who have not
participated or made obvious errors or given malicious or inappropriate input.'
      when 'emp_desc'
        note = '
Instructions: The description field should contain enough additional
information so that job seekers can contact your organization.'
      when 'agree'
        note = "
This information is used to connect you to employers in our network. Your
privacy is very important to us. We don't sell or make your information
available outside this application. By providing profile information,
you are agreeing to our <a href='/user_agreement' class='dialog'>
User Agreement</a> and <a href='/privacy_policy' class='dialog'>
Privacy Policy</a>."
      when 'privacy'
        note = "
Allowing Employers to view your profile and saved openings helps them find you
and increases your chances of getting connected with the companies that have
the right jobs for you."
      when 'closed'
        note = '
NOTE: Dates displayed in <span class="red">red</span> indicate an opening has
expired.'
      else
        note = ''
    end

    html = <<-HTML
    <p class="info">
      #{note}
    </p>
    HTML
    html.html_safe
  end

  def set_interest_cols(obj)
    if obj #user submits form w/input
      total = obj.count
    else
      total = 6
    end
    @count = 0
    @cols = 6.0
    @span = "span" + (12 / @cols.to_i).to_s
    @num_in_cols = (total / @cols).ceil
  end

  def randomized_background_image
    images = [
      "/assets/job-board-demo-banner1.gif",
      "/assets/job-board-demo-banner2.gif",
      "/assets/job-board-demo-banner3.gif",
      "/assets/job-board-demo-banner4.gif",
      "/assets/job-board-demo-banner5.gif",
      "/assets/job-board-demo-banner6.gif",
      "/assets/job-board-demo-banner7.gif",
    ]
    images[rand(images.size)]
  end
  def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end

  def display_closed_date(opening)
    closed = opening.date_closed
    return (
    closed && closed < Time.now ?
    "<span class='red'>
      #{closed.strftime('%m/%d/%Y')}
    </span>".html_safe :
    (closed ?
      closed.strftime('%m/%d/%Y') :
      "Ongoing"
    ))
  end

  def display_open_date(opening)
    open = opening.date_open
    return (
    open > Time.now ?
    "<span class='red'>
      #{open.strftime('%m/%d/%Y')}
    </span>".html_safe :
    open.strftime('%m/%d/%Y')
    )
  end

  #build action buttons -
  #for openings rows in table on NP show and Openings index
  def set_opening_actions_button_group(opening)
    #delete: white button - less warning
    if !opening.active ||
        opening.date_open > Time.now ||
        (opening.date_closed && opening.date_closed < Time.now)
      delete = "<a href=\"#{opening}\"
        class=\"btn btn-mini\"
        data-confirm=\"Are you sure? This action cannot be undone.\"
        data-method=\"delete\" rel=\"nofollow\">Delete</a>"
    #delete: white button stern warning
    else
      delete = "<a href=\"#{opening}\"
        class=\"btn btn-mini btn-danger\"
        data-confirm=\"WARNING: This opening is visible in job listings.\n\n
        Are you sure? This action cannot be undone.\"
        data-method=\"delete\" rel=\"nofollow\">Delete</a>"
    end
    if params[:controller] == 'openings'
      #edit - less warning
      if current_role(Employer)
        edit = "<a href=\"#{edit_opening_path(opening)}\"
          id=\"edit\" class=\"btn btn-mini btn-warning\">Edit</a>"
      #no delete button if NP
      else
        delete = ''
      end
    elsif params[:controller] == 'employers'
      #edit - stern warning
      edit = "<a href=\"#{edit_opening_path(opening)}\"
        id=\"edit\" class=\"btn btn-mini btn-warning\"
        data-confirm=\"Be cautious when editing another user\'s input.
        This could cause confusion and/or mistrust of the system.\n\n
        Are you sure?\">Edit</a>"
    end
    #build html
    html = <<-HTML
    <div class="btn-group btn-group-xs">
      <a href="#{opening_path(opening)}"
        class="btn btn-mini btn-success" id="show">Show</a>
      #{edit}
      #{delete}
    </div>
    HTML
    html.html_safe
  end
end
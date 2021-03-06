module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the new comment page/
      new_comment_path

    when /the new post page/
      new_post_path

    when /the login page/
      new_user_session_path

    # when /the show page for (.+)/
    #   polymorphic_path(model($1))

    when /the ?(.*) page for (.+)/
      params = {}
      params[:action] = $1.to_sym unless $1.empty?
      polymorphic_path(model($2), params)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

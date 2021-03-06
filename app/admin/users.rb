ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :fullname

    column "Trustcommiunity" do |user|
      if user.trustcommunity? && user.invitor == nil
        %(Yes #{link_to "(Remove from Trustcommunity)", outOfTrust_admin_user_path(user)}).html_safe
      else
        %(No #{link_to "(Join as Founder)", trustcommunity_admin_user_path(user)}).html_safe
      end
    end

    column :admin do |user|
      if user.admin
        %(Yes #{link_to "(Remove as admin)", remAdmin_admin_user_path(user)}).html_safe
      else
        %(No #{link_to "(Join as admin)", joinAdmin_admin_user_path(user)}).html_safe
      end
    end

    column "Activated" do |user|
      if user.banned?
        %(No #{link_to "(Activate User)", unban_admin_user_path(user)}).html_safe
      else
        %(Yes #{link_to "(Deactivate User)", ban_admin_user_path(user)}).html_safe
      end
    end

    default_actions
  end

  member_action :remAdmin do
  # your normal action code
    user = User.find(params[:id])
    user.admin = false
    user.save(:validate => false)
    redirect_to(:back)
  end

  member_action :joinAdmin do
  # your normal action code
    user = User.find(params[:id])
    user.admin = true
    user.save(:validate => false)
    redirect_to(:back)
  end

  member_action :trustcommunity do
  # your normal action code
    user = User.find(params[:id])
    user.trustcommunity = true
     user.save(:validate => false)
    redirect_to(:back)
  end

  member_action :outOfTrust do
  # your normal action code
    user = User.find(params[:id])
    user.trustcommunity = false
     user.save(:validate => false)
    redirect_to(:back)
  end

  member_action :unban do
  # your normal action code
    user = User.find(params[:id])
    user.banned = false
     user.save(:validate => false)
    redirect_to(:back)
  end

  member_action :ban do
  # your normal action code
    user = User.find(params[:id])
    user.banned = true
     user.save(:validate => false)
    redirect_to(:back)
  end

end

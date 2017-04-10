ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    section t('recently_updated_content') do
      table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
        column (t('Item')) { |v| v.item }
        #column ('Item') { |v| link_to v.item, [:admin, v.item] } # Uncomment to display as link
        column (t('Type')) { |v| v.item_type.underscore.humanize }
        column (t('Modified_at')) { |v| v.created_at.to_s :long }
        column (t('Admin')) { |v| link_to User.find((v.whodunnit.nil? ? '1' : v.whodunnit)).name, [:admin, User.find((v.whodunnit.nil? ? '1' : v.whodunnit))] }
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
